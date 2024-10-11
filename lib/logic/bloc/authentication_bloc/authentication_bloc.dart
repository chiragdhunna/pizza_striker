import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pizza_striker/dio_factory.dart';
import 'package:pizza_striker/logic/api/admin/admin_api.dart';
import 'package:pizza_striker/logic/api/admin/models/admin_model.dart';
import 'package:pizza_striker/logic/api/user/models/user_model.dart';
import 'package:pizza_striker/logic/api/user/models/user_type.dart';
import 'package:pizza_striker/logic/api/user/user_api.dart';
import 'package:pizza_striker/logic/bloc/authentication_bloc/authentication_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';
part 'authentication_bloc.freezed.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  factory AuthenticationBloc() {
    return _instance;
  }
  AuthenticationBloc._internal() : super(_Initial()) {
    on<_CheckExisting>(_checkExisting);
    on<_NewAdminLogin>(_adminLoggedIn);
    on<_NewUserLogin>(_userLoggedIn);
    on<_Logout>(_logout);
  }

  final String _logTag = 'LoginBloc';

  static final AuthenticationBloc _instance = AuthenticationBloc._internal();
  final _authRepository = AuthRepository(
    adminApi: AdminApi(DioFactory().create()),
    userApi: UserApi(DioFactory().create()),
  );

  Future<void> _logout(
    _Logout event,
    Emitter<AuthenticationState> emit,
  ) async {
    try {
      await _authRepository.logout();

      /* Login for updating the device token to the backend */
      emit(AuthenticationState.loggedOut());
      add(const AuthenticationEvent.checkExisting());
    } on Exception catch (error, stackTrace) {
      log.e(_logTag, error: 'Caught an exception  $error     $stackTrace');
    }
  }

  Future<void> _adminLoggedIn(
    _NewAdminLogin event,
    Emitter<AuthenticationState> emit,
  ) async {
    try {
      await _authRepository.setAuthToken(event.authToken);
      await _authRepository.setAdmin(event.admin);

      emit(
        AuthenticationState.adminLoggedIn(
          admin: event.admin,
          authToken: event.authToken,
        ),
      );
    } on Exception catch (error, stackTrace) {
      log.e(_logTag, error: 'Caught an exception  $error     $stackTrace');
    }
  }

  Future<void> _userLoggedIn(
    _NewUserLogin event,
    Emitter<AuthenticationState> emit,
  ) async {
    try {
      log.d('Auth token for user is : ${event.authToken}');
      await _authRepository.setAuthToken(event.authToken);
      await _authRepository.setUser(event.user);

      emit(
        AuthenticationState.userLoggedIn(
          user: event.user,
          authToken: event.authToken,
        ),
      );
    } on Exception catch (error, stackTrace) {
      log.e(_logTag, error: 'Caught an exception  $error     $stackTrace');
    }
  }

  Future<void> _checkExisting(
    _CheckExisting event,
    Emitter<AuthenticationState> emit,
  ) async {
    try {
      final authToken = await _authRepository.getAuthToken();
      final authUser = await _authRepository.getAuthUser();
      final authExpert = await _authRepository.getAuthAdmin();
      if (authToken != null && authUser != null) {
        emit(
          AuthenticationState.userAuthenticated(
            user: authUser,
            authToken: authToken,
          ),
        );
      } else if (authToken != null && authExpert != null) {
        emit(
          AuthenticationState.adminAuthenticated(
            admin: authExpert,
            authToken: authToken,
          ),
        );
      } else {
        emit(AuthenticationState.unAuthenticated());
      }
    } on Exception catch (error, stackTrace) {
      log.e(_logTag, error: 'Caught an exception  $error     $stackTrace');
      emit(AuthenticationState.unAuthenticated());
    }
  }

  bool isAuthenticated() {
    return state.isAuthenticated;
  }

  bool isAuthUser() {
    return state.isAuthUser;
  }

  bool isAuthAdmin() {
    return state.isAuthAdmin;
  }

  UserModel? authUser() {
    return state.authUser;
  }

  AdminModel? authAdmin() {
    return state.authAdmin;
  }
}
