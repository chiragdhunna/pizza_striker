// This file is "main.dart"
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

// required: associates our `main.dart` with the code generated by Freezed
part 'admin_device_token_model.freezed.dart';
// optional: Since our AdminDeviceTokenModel class is serializable, we must add this line.
// But if AdminDeviceTokenModel was not serializable, we could skip it.
part 'admin_device_token_model.g.dart';

@freezed
class AdminDeviceTokenModel with _$AdminDeviceTokenModel {
  const factory AdminDeviceTokenModel({
    required String deviceToken,
  }) = _AdminDeviceTokenModel;

  factory AdminDeviceTokenModel.fromJson(Map<String, Object?> json) =>
      _$AdminDeviceTokenModelFromJson(json);
}
