part of 'login_bloc.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial() = _Initial;
  const factory LoginState.inProgress() = _InProgress;

  const factory LoginState.loginStarted({
    required UserType userType,
    required String phone,
    required int attempts,
  }) = _LoginStarted;

  const factory LoginState.verificationStarted({
    required UserType userType,
    required String phone,
    required int attempts,
  }) = _VerificationStarted;

  const factory LoginState.loginAdminSuccess({
    required String authToken,
    required UserType userType,
    required AdminModel admin,
  }) = _LoginAdminSuccess;

  const factory LoginState.loginUserSuccess({
    required String authToken,
    required UserType userType,
    required UserModel user,
  }) = _LoginUserSucces;

  const factory LoginState.error(String message) = _LoginError;
}
