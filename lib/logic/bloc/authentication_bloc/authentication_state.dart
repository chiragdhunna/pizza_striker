part of 'authentication_bloc.dart';

@freezed
class AuthenticationState with _$AuthenticationState {
  factory AuthenticationState.initial() = _Initial;
  factory AuthenticationState.checking() = _Checking;
  factory AuthenticationState.inProgress({
    required UserType userType,
    required String phone,
    required int attempt,
  }) = _InProgess;
  factory AuthenticationState.userAuthenticated({
    required UserModel user,
    required String authToken,
  }) = _UserAuthenticated;
  factory AuthenticationState.adminAuthenticated({
    required AdminModel admin,
    required String authToken,
  }) = _AdminAuthenticated;
  factory AuthenticationState.unAuthenticated() = _UnAuthenticated;
  factory AuthenticationState.loggedOut() = _LoggedOut;

  factory AuthenticationState.userLoggedIn({
    required UserModel user,
    required String authToken,
  }) = _UserLoggedIn;

  factory AuthenticationState.adminLoggedIn({
    required AdminModel admin,
    required String authToken,
  }) = _AdminLoggedIn;
  factory AuthenticationState.adminNeedsProfileDetails({
    required AdminModel admin,
    required String authToken,
  }) = _AdminNeedsProfileDetails;
  factory AuthenticationState.adminIsInReview({
    required AdminModel admin,
    required String authToken,
  }) = _AdminIsInReview;
  factory AuthenticationState.userNeedsProfileDetails({
    required UserModel userModel,
    required String authToken,
  }) = _UserNeedsProfileDetails;
  factory AuthenticationState.userNeedsOnboard() = _UserNeedsOnboard;
}

extension AuthenticationStateX on AuthenticationState {
  bool get isAuthenticated =>
      this is _UserAuthenticated ||
      this is _AdminAuthenticated ||
      this is _UserLoggedIn ||
      this is _AdminLoggedIn;
  bool get isAuthUser => this is _UserAuthenticated || this is _UserLoggedIn;
  bool get isAuthAdmin => this is _AdminAuthenticated || this is _AdminLoggedIn;
  UserModel? get authUser => maybeWhen(
        userAuthenticated: (user, authToken) => user,
        userLoggedIn: (user, authToken) => user,
        orElse: () => null,
      );
  // bool get isAdminNeedsProfileDetails => ;
  AdminModel? get authAdmin => maybeWhen(
        adminAuthenticated: (admin, authToken) => admin,
        adminLoggedIn: (admin, authToken) => admin,
        orElse: () => null,
      );
}
