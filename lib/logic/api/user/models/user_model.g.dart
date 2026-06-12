// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: json['id'] as String,
      name: json['name'] as String?,
      profilePhoto: json['profile_photo'] as String?,
      phone: json['phone'] as String,
      createdAt: json['created_at'] as String,
      strikeCount: json['strike_count'] as String,
      updatedAt: json['updated_at'] as String,
      hashedPassword: json['hashed_password'] as String,
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'profile_photo': instance.profilePhoto,
      'phone': instance.phone,
      'created_at': instance.createdAt,
      'strike_count': instance.strikeCount,
      'updated_at': instance.updatedAt,
      'hashed_password': instance.hashedPassword,
    };
