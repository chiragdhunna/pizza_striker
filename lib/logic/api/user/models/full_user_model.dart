// This file is "main.dart"
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:pizza_striker/logic/api/user/models/user_model.dart';

// required: associates our `main.dart` with the code generated by Freezed
part 'full_user_model.freezed.dart';
// optional: Since our FullUserModel class is serializable, we must add this line.
// But if FullUserModel was not serializable, we could skip it.
part 'full_user_model.g.dart';

@freezed
class FullUserModel with _$FullUserModel {
  const factory FullUserModel({
    required String accessToken,
    required UserModel user,
  }) = _FullUserModel;

  factory FullUserModel.fromJson(Map<String, Object?> json) =>
      _$FullUserModelFromJson(json);
}
