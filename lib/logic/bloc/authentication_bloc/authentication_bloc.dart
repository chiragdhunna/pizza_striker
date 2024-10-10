import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pizza_striker/logic/api/admin/models/admin_model.dart';
import 'package:pizza_striker/logic/api/user/models/user_model.dart';
import 'package:pizza_striker/logic/api/user/models/user_type.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';
part 'authentication_bloc.freezed.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(_Initial()) {
    on<AuthenticationEvent>((event, emit) {
      // TODO: implement event handler
    });
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

  AdminModel? authExpert() {
    return state.authAdmin;
  }
}
