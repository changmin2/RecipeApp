import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/common/const/data.dart';
import 'package:recipe_app/common/model/cursor_pagination_model.dart';
import 'package:recipe_app/common/model/pagination_params.dart';
import 'package:recipe_app/common/repository/base_pagination_repository.dart';
import 'package:recipe_app/recipe/model/recipe_detail_model.dart';
import 'package:recipe_app/recipe/model/recipe_model.dart';
import 'package:retrofit/http.dart';

import '../../common/dio/dio.dart';

part 'recipe_repository.g.dart';

final recipeRepositoryProvider = Provider<RecipeRepository>((ref){
  final dio = ref.watch(dioProvider);

  final repository = RecipeRepository(dio,baseUrl: 'http://$ip/recipe');

  return repository;
});

@RestApi()
abstract class RecipeRepository implements IBasePaginationRepository<RecipeModel>{
  
  factory RecipeRepository(Dio dio,{String baseUrl})
  = _RecipeRepository;
  
  @GET('/all')
  @Headers({
    'accessToken':'true'
  })
  Future<CursorPagination<RecipeModel>> paginate({
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });

  @GET('/{id}')
  @Headers({
    'accessToken': 'true'
  })
  Future<RecipeDetailModel> getRestaurantDetail({
    //url id와 대체 or 괄호안에 선언가능
    @Path() required int id,
  });


}