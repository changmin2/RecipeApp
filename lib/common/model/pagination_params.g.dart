// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginationParams _$PaginationParamsFromJson(Map<String, dynamic> json) =>
    PaginationParams(
      after: json['after'] as int?,
      count: json['count'] as int?,
      keyword: json['keyword'] as String?,
      nm: json['nm'] as String?,
      level: json['level'] as String?,
      recipe_id: json['recipe_id'] as int?,
    );

Map<String, dynamic> _$PaginationParamsToJson(PaginationParams instance) =>
    <String, dynamic>{
      'after': instance.after,
      'count': instance.count,
      'keyword': instance.keyword,
      'nm': instance.nm,
      'level': instance.level,
      'recipe_id': instance.recipe_id,
    };
