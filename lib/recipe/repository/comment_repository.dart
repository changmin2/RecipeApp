import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/common/repository/base_pagination_repository.dart';
import 'package:recipe_app/recipe/component/comment_param.dart';
import 'package:recipe_app/recipe/model/comment_model.dart';
import 'package:retrofit/http.dart';

import '../../common/const/data.dart';
import '../../common/dio/dio.dart';
import '../../common/model/cursor_pagination_model.dart';
import '../../common/model/pagination_params.dart';
import '../../common/repository/base_pagination_repositoryV2.dart';

part 'comment_repository.g.dart';

final commentRepositoryProvider = Provider<CommentRepository>((ref){
  final dio = ref.watch(dioProvider);

  final repository = CommentRepository(dio,baseUrl: 'http://$ip/comment');

  return repository;
});

@RestApi()
abstract class CommentRepository implements IBasePaginationRepositoryV2<CommentModel>{

  factory CommentRepository(Dio dio,{String baseUrl})
  = _CommentRepository;

  @GET("/{recipe_id}")
  @Headers({
    'accessToken':'true'
  })
  Future<CursorPagination<CommentModel>> commentPaginate({
    @Path() required int recipe_id,
    @Body() PaginationParams? paginationParams = const PaginationParams(),
  });

  @POST("/{recipe_id}")
  @Headers({
    'accessToken':'true'
  })
  Future<CommentModel> createComment({
    @Path() required int recipe_id,
    @Body() CommentParam? commentParam = const CommentParam()
  });

  @DELETE("/{comment_id}")
  @Headers({
    'accessToken':'true'
  })
  Future<void> deleteComment({
    @Path() required int comment_id
  });


  @POST("/recomment/{comment_id}")
  @Headers({
    'accessToken':'true'
  })
  Future<Recomment> createReComment({
    @Path() required int comment_id,
    @Body() CommentParam? commentParam = const CommentParam()
  });

  @DELETE("/recomment/{recomment_id}")
  @Headers({
    'accessToken':'true'
  })
  Future<void> deleteReComment({
    @Path() required int recomment_id
  });
}

