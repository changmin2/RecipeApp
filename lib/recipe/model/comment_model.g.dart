// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) => CommentModel(
      comment_id: json['comment_id'] as int,
      recipe_id: json['recipe_id'] as int,
      creator: json['creator'] as String,
      content: json['content'] as String,
      createDate: DateTime.parse(json['createDate'] as String),
      commentList: (json['commentList'] as List<dynamic>?)
          ?.map((e) => Recomment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) =>
    <String, dynamic>{
      'comment_id': instance.comment_id,
      'recipe_id': instance.recipe_id,
      'creator': instance.creator,
      'content': instance.content,
      'createDate': instance.createDate.toIso8601String(),
      'commentList': instance.commentList,
    };

Recomment _$RecommentFromJson(Map<String, dynamic> json) => Recomment(
      recomment_id: json['recomment_id'] as int,
      creator: json['creator'] as String,
      content: json['content'] as String,
      createDate: DateTime.parse(json['createDate'] as String),
    );

Map<String, dynamic> _$RecommentToJson(Recomment instance) => <String, dynamic>{
      'recomment_id': instance.recomment_id,
      'creator': instance.creator,
      'content': instance.content,
      'createDate': instance.createDate.toIso8601String(),
    };
