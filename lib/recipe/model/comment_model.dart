import 'package:json_annotation/json_annotation.dart';

import '../../common/model/model_with_idV2.dart';

part 'comment_model.g.dart';

@JsonSerializable()
class CommentModel implements IModelWithIdV2{
  final int comment_id;
  final int recipe_id;
  final String creator;
  final String content;
  final DateTime createDate;

  CommentModel({
    required this.comment_id,
    required this.recipe_id,
    required this.creator,
    required this.content,
    required this.createDate,
  });

  factory CommentModel.fromJson(Map<String,dynamic> json)
  => _$CommentModelFromJson(json);

  Map<String,dynamic> toJson() => _$CommentModelToJson(this);
}