import 'dart:convert';

import 'package:awesome_notifications_fcm/awesome_notifications_fcm.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/web.dart';
import 'package:pizza_striker/logic/api/admin/admin_api.dart';
import 'package:pizza_striker/logic/api/admin/models/admin_device_token_model.dart';
import 'package:pizza_striker/logic/api/admin/models/admin_model.dart';
import 'package:pizza_striker/logic/api/devices/models/user_device_token_model.dart';
import 'package:pizza_striker/logic/api/user/models/user_model.dart';
import 'package:pizza_striker/logic/api/user/user_api.dart';
import 'package:pizza_striker/logic/bloc/authentication_bloc/authentication_bloc.dart';

Logger log = Logger(
  printer: PrettyPrinter(),
);

class AuthRepository {
  AuthRepository({
    required this.adminApi,
    required this.userApi,
  });

  final String _logTag = 'AuthRepository';
  final authTokenkey = 'authToken';
  final authUserKey = 'authUser';
  final adminUserKey = 'adminUser';

  final _storage = const FlutterSecureStorage();
  final AdminApi adminApi;
  final UserApi userApi;

  Future<void> logout() async {
    final userDeviceToken = UserDeviceTokenModel(
      deviceToken: await AwesomeNotificationsFcm().requestFirebaseAppToken(),
    );

    final adminDeviceToken = AdminDeviceTokenModel(
      deviceToken: await AwesomeNotificationsFcm().requestFirebaseAppToken(),
    );

    log.d('Device Token While Logging Out : $userDeviceToken');
    if (AuthenticationBloc().isAuthUser()) {
      try {
        await userApi.logout(userDeviceToken);
      } catch (e) {
        log
          ..e('Error in Logout user : $e')
          ..e('Device Token is : $userDeviceToken');
      }
    } else if (AuthenticationBloc().isAuthAdmin()) {
      try {
        await adminApi.logout(adminDeviceToken);
      } catch (e) {
        log.e('Error in Logout admin : $e');
      }
    }
    await _storage.delete(key: authTokenkey);
    await _storage.delete(key: authUserKey);
    await _storage.delete(key: adminUserKey);
    /* Logout for deleting the auth token from the backend */
  }

  Future<String?> getAuthToken() async {
    final authToken = await _storage.read(key: authTokenkey);
    log.d(_logTag, error: 'Returning the authToken : $authToken');
    return authToken;
  }

  Future<UserModel?> getAuthUser() async {
    final data = await _storage.read(key: authUserKey);
    if (data != null) {
      final userData = jsonDecode(data);
      try {
        final user = UserModel.fromJson(userData as Map<String, dynamic>);
        log.d(_logTag, error: 'Returning the user : $user');
        return user;
      } on Exception catch (e) {
        // Anything else that is an exception
        log.e(
          _logTag,
          error: 'Exception converting to user:  userString: $data $e',
        );
      }
    }

    return null;
  }

  Future<AdminModel?> getAuthAdmin() async {
    final data = await _storage.read(key: adminUserKey);
    log.d(_logTag, error: 'data for admin : $data');
    if (data != null) {
      final userData = jsonDecode(data);
      try {
        final admin = AdminModel.fromJson(userData as Map<String, dynamic>);
        log.d(_logTag, error: 'Returning the admin : $admin');
        return admin;
      } on Exception catch (e) {
        log.e(_logTag, error: 'Exception converting to admin: $data $e');
      }
    }

    return null;
  }

  Future<AdminModel?> setAdmin(AdminModel admin) async {
    await _storage.write(
      key: adminUserKey,
      value: jsonEncode(admin.toJson()),
    );
    return getAuthAdmin();
  }

  Future<String?> setAuthToken(String authToken) async {
    await _storage.write(key: authTokenkey, value: authToken);
    return _storage.read(key: authTokenkey);
  }

  Future<UserModel?> setUser(UserModel user) async {
    await _storage.write(
      key: authUserKey,
      value: jsonEncode(user.toJson()),
    );
    return getAuthUser();
  }
}
