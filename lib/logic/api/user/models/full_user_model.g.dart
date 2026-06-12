// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'full_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FullUserModelImpl _$$FullUserModelImplFromJson(Map<String, dynamic> json) =>
    _$FullUserModelImpl(
      accessToken: json['access_token'] as String,
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$FullUserModelImplToJson(_$FullUserModelImpl instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'user': instance.user?.toJson(),
    };
