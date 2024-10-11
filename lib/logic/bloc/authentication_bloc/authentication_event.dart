part of 'authentication_bloc.dart';

@freezed
class AuthenticationEvent with _$AuthenticationEvent {
  const factory AuthenticationEvent.started() = _Started;

  const factory AuthenticationEvent.checkExisting() = _CheckExisting;

  const factory AuthenticationEvent.newAdminLogin({
    required String authToken,
    required AdminModel admin,
  }) = _NewAdminLogin;

  const factory AuthenticationEvent.newUserLogin({
    required String authToken,
    required UserModel user,
  }) = _NewUserLogin;

  const factory AuthenticationEvent.adminIsInReviewEvent({
    required String authToken,
    required AdminModel admin,
  }) = _AdminIsInReviewEvent;

  const factory AuthenticationEvent.logout() = _Logout;
}
