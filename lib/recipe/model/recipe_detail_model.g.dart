// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeDetailModel _$RecipeDetailModelFromJson(Map<String, dynamic> json) =>
    RecipeDetailModel(
      recipe_id: json['recipe_id'] as int,
      recipe_nm: json['recipe_nm'] as String,
      summary: json['summary'] as String,
      nation_code: json['nation_code'] as int,
      nation_nm: json['nation_nm'] as String,
      ty_code: json['ty_code'] as String,
      ty_nm: json['ty_nm'] as String,
      cooking_time: json['cooking_time'] as String,
      calorie: json['calorie'] as String,
      qnt: json['qnt'] as String,
      level_nm: json['level_nm'] as String,
      irdnt_code: json['irdnt_code'] as String,
      pc_nm: json['pc_nm'] as String,
      image_url: json['image_url'] as String,
      detail_url: json['detail_url'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => DetailDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RecipeDetailModelToJson(RecipeDetailModel instance) =>
    <String, dynamic>{
      'recipe_id': instance.recipe_id,
      'recipe_nm': instance.recipe_nm,
      'summary': instance.summary,
      'nation_code': instance.nation_code,
      'nation_nm': instance.nation_nm,
      'ty_code': instance.ty_code,
      'ty_nm': instance.ty_nm,
      'cooking_time': instance.cooking_time,
      'calorie': instance.calorie,
      'qnt': instance.qnt,
      'level_nm': instance.level_nm,
      'irdnt_code': instance.irdnt_code,
      'pc_nm': instance.pc_nm,
      'image_url': instance.image_url,
      'detail_url': instance.detail_url,
      'data': instance.data,
    };

DetailDto _$DetailDtoFromJson(Map<String, dynamic> json) => DetailDto(
      id: json['id'] as int,
      recipe_id: json['recipe_id'] as int,
      cooking_no: json['cooking_no'] as int,
      cooking_dc: json['cooking_dc'] as String,
      cooking_img: json['cooking_img'] as String,
      step_tip: json['step_tip'] as String,
    );

Map<String, dynamic> _$DetailDtoToJson(DetailDto instance) => <String, dynamic>{
      'id': instance.id,
      'recipe_id': instance.recipe_id,
      'cooking_no': instance.cooking_no,
      'cooking_dc': instance.cooking_dc,
      'cooking_img': instance.cooking_img,
      'step_tip': instance.step_tip,
    };
