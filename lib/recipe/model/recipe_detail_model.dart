import 'package:json_annotation/json_annotation.dart';
import 'package:recipe_app/common/model/model_with_id.dart';
import 'package:recipe_app/recipe/model/recipe_model.dart';

part 'recipe_detail_model.g.dart';

@JsonSerializable()
class RecipeDetailModel extends RecipeModel{
  final List<DetailDto> data;
  final List<IngredientDto> ingredients;

  RecipeDetailModel({
    required super.recipe_id,
    required super.recipe_nm,
    required super.summary,
    required super.nation_code,
    required super.nation_nm,
    required super.ty_code,
    required super.ty_nm,
    required super.cooking_time,
    required super.calorie,
    required super.qnt,
    required super.level_nm,
    required super.irdnt_code,
    required super.pc_nm,
    required super.image_url,
    required super.detail_url,
    required this.data,
    required this.ingredients,
  });

  factory RecipeDetailModel.fromJson(Map<String,dynamic> json)
  => _$RecipeDetailModelFromJson(json);

  Map<String,dynamic> toJson() => _$RecipeDetailModelToJson(this);
}

@JsonSerializable()
class DetailDto{
  final int id;
  final int recipe_id;
  final int cooking_no;
  final String cooking_dc;
  final String cooking_img;
  final String step_tip;

  DetailDto({
    required this.id,
    required this.recipe_id,
    required this.cooking_no,
    required this.cooking_dc,
    required this.cooking_img,
    required this.step_tip
  });

  factory DetailDto.fromJson(Map<String,dynamic> json)
  => _$DetailDtoFromJson(json);
}

@JsonSerializable()
class IngredientDto{
  final int recipe_no;
  final int recipe_code;
  final String ingredientName;
  final String quantity;
  final int ingredientCode;
  final String ingredientType;

  IngredientDto({
    required this.recipe_no,
    required this.recipe_code,
    required this.ingredientName,
    required this.quantity,
    required this.ingredientCode,
    required this.ingredientType
  });

  factory IngredientDto.fromJson(Map<String,dynamic> json)
  => _$IngredientDtoFromJson(json);
}