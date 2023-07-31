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
  final List<Recomment>? commentList;

  CommentModel({
    required this.comment_id,
    required this.recipe_id,
    required this.creator,
    required this.content,
    required this.createDate,
    this.commentList
  });

  factory CommentModel.fromJson(Map<String,dynamic> json)
  => _$CommentModelFromJson(json);

  Map<String,dynamic> toJson() => _$CommentModelToJson(this);
}

//대댓글
@JsonSerializable()
class Recomment{
  final int recomment_id;
  final String creator;
  final String content;
  final DateTime createDate;

  Recomment({
    required this.recomment_id,
    required this.creator,
    required this.content,
    required this.createDate,
  });

  factory Recomment.fromJson(Map<String,dynamic> json)
  => _$RecommentFromJson(json);
}