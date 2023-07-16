import 'package:json_annotation/json_annotation.dart';
import 'package:recipe_app/common/model/model_with_id.dart';

part 'recipe_model.g.dart';

@JsonSerializable()
class RecipeModel implements IModelWithId{
  final int recipe_id;
  final String recipe_nm;
  final String summary;
  final int nation_code;
  final String nation_nm;
  final String ty_code;
  final String ty_nm;
  final String cooking_time;
  final String calorie;
  final String qnt;
  final String level_nm;
  final String irdnt_code;
  final String pc_nm;
  final String image_url;
  final String detail_url;

  RecipeModel({
    required this.recipe_id,
    required this.recipe_nm,
    required this.summary,
    required this.nation_code,
    required this.nation_nm,
    required this.ty_code,
    required this.ty_nm,
    required this.cooking_time,
    required this.calorie,
    required this.qnt,
    required this.level_nm,
    required this.irdnt_code,
    required this.pc_nm,
    required this.image_url,
    required this.detail_url,
  });

  factory RecipeModel.fromJson(Map<String,dynamic> json)
    => _$RecipeModelFromJson(json);

  Map<String,dynamic> toJson() => _$RecipeModelToJson(this);


}