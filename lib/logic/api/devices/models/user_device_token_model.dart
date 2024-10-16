// This file is "main.dart"
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

// required: associates our `main.dart` with the code generated by Freezed
part 'user_device_token_model.freezed.dart';
// optional: Since our UserDeviceTokenModel class is serializable, we must add this line.
// But if UserDeviceTokenModel was not serializable, we could skip it.
part 'user_device_token_model.g.dart';

@freezed
class UserDeviceTokenModel with _$UserDeviceTokenModel {
  const factory UserDeviceTokenModel({
    required String deviceToken,
  }) = _UserDeviceTokenModel;

  factory UserDeviceTokenModel.fromJson(Map<String, Object?> json) =>
      _$UserDeviceTokenModelFromJson(json);
}
