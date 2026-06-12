// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leaderboard_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LeaderBoardResponseModelImpl _$$LeaderBoardResponseModelImplFromJson(
        Map<String, dynamic> json) =>
    _$LeaderBoardResponseModelImpl(
      items: (json['items'] as List<dynamic>)
          .map((e) => FullUserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num).toInt(),
      page: (json['page'] as num).toInt(),
      size: (json['size'] as num).toInt(),
      pages: (json['pages'] as num).toInt(),
    );

Map<String, dynamic> _$$LeaderBoardResponseModelImplToJson(
        _$LeaderBoardResponseModelImpl instance) =>
    <String, dynamic>{
      'items': instance.items.map((e) => e.toJson()).toList(),
      'total': instance.total,
      'page': instance.page,
      'size': instance.size,
      'pages': instance.pages,
    };
