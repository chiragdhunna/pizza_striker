// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AdminModelImpl _$$AdminModelImplFromJson(Map<String, dynamic> json) =>
    _$AdminModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      profilePhoto: json['profile_photo'] as String,
      phone: json['phone'] as String,
      createdAt: json['created_at'] as String,
      strikeCount: json['strike_count'] as String,
      updatedAt: json['updated_at'] as String,
      hashedPassword: json['hashed_password'] as String,
      isActive: json['is_active'] as bool,
    );

Map<String, dynamic> _$$AdminModelImplToJson(_$AdminModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'profile_photo': instance.profilePhoto,
      'phone': instance.phone,
      'created_at': instance.createdAt,
      'strike_count': instance.strikeCount,
      'updated_at': instance.updatedAt,
      'hashed_password': instance.hashedPassword,
      'is_active': instance.isActive,
    };
