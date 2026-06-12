// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoginUserModelImpl _$$LoginUserModelImplFromJson(Map<String, dynamic> json) =>
    _$LoginUserModelImpl(
      phone: json['phone'] as String,
      hashedPassword: json['hashed_password'] as String,
    );

Map<String, dynamic> _$$LoginUserModelImplToJson(
        _$LoginUserModelImpl instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      'hashed_password': instance.hashedPassword,
    };
