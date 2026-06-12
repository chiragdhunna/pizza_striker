// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'full_admin_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FullAdminModelImpl _$$FullAdminModelImplFromJson(Map<String, dynamic> json) =>
    _$FullAdminModelImpl(
      accessToken: json['access_token'] as String,
      admin: AdminModel.fromJson(json['admin'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$FullAdminModelImplToJson(
        _$FullAdminModelImpl instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'admin': instance.admin.toJson(),
    };
