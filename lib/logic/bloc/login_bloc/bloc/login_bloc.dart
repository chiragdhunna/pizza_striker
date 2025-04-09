import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logger/web.dart';
import 'package:pizza_striker/dio_factory.dart';
import 'package:pizza_striker/logic/api/admin/admin_api.dart';
import 'package:pizza_striker/logic/api/admin/models/admin_model.dart';
import 'package:pizza_striker/logic/api/user/models/login_user_model.dart';
import 'package:pizza_striker/logic/api/user/models/user_model.dart';
import 'package:pizza_striker/logic/api/user/models/user_type.dart';
import 'package:pizza_striker/logic/api/user/user_api.dart';
import 'package:pizza_striker/logic/bloc/authentication_bloc/authentication_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

Logger log = Logger(
  printer: PrettyPrinter(),
);

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const _Initial()) {
    on<_StartLogin>(_startLogin);
    on<_VerifyLogin>(_verifyLogin);
  }

  final _authenticationBloc = AuthenticationBloc();
  final _expertApi = AdminApi(DioFactory().create());
  final _userApi = UserApi(DioFactory().create());
  final String _logTag = 'LoginBloc';

  Future<void> _startLogin(
    _StartLogin event,
    Emitter<LoginState> emit,
  ) async {
    emit(const LoginState.inProgress());

    try {
      await Future.delayed(const Duration(seconds: 1), () {
        emit(
          LoginState.loginStarted(
            userType: event.userType,
            phone: event.phone,
            attempts: event.attempts + 1,
          ),
        );
      });
    } on Exception catch (error, stackTrace) {
      log.e(_logTag, error: error, stackTrace: stackTrace);
      addError(error, stackTrace);
      emit(LoginState.error(error.toString()));
    }
  }

  Future<void> _verifyLogin(
    _VerifyLogin event,
    Emitter<LoginState> emit,
  ) async {
    emit(const LoginState.inProgress());

    try {
      if (event.userType == UserType.user) {
        final loggedInUser = await _userApi.login(
          LoginUserModel(
            phone: event.phone,
            hashedPassword: event.otp,
          ),
        );

        emit(
          LoginState.loginUserSuccess(
            authToken: loggedInUser.accessToken,
            user: loggedInUser.user!,
            userType: event.userType,
          ),
        );

        _authenticationBloc.add(
          AuthenticationEvent.newUserLogin(
            authToken: loggedInUser.accessToken,
            user: loggedInUser.user!,
          ),
        );
      } else {
        final loggedInAdmin = await _expertApi.login(
          LoginUserModel(
            phone: event.phone,
            hashedPassword: event.otp,
          ),
        );

        emit(
          LoginState.loginAdminSuccess(
            authToken: loggedInAdmin.accessToken,
            userType: event.userType,
            admin: loggedInAdmin.admin,
          ),
        );

        _authenticationBloc.add(
          AuthenticationEvent.newAdminLogin(
            authToken: loggedInAdmin.accessToken,
            admin: loggedInAdmin.admin,
          ),
        );
      }
    } on Exception catch (error, stackTrace) {
      if (error is DioException) {
        log.e(_logTag, error: error, stackTrace: stackTrace);
        // ignore: avoid_dynamic_calls
        if (error.response!.data['detail'] == 'Otp mismatch') {
          emit(const LoginState.error('Otp mismatch'));
        }
      } else {
        log.e(_logTag, error: error, stackTrace: stackTrace);
        addError(error, stackTrace);
        emit(LoginState.error(error.toString()));
      }
    }
  }
}
