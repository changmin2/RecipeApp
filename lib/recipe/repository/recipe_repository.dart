import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/common/const/data.dart';
import 'package:recipe_app/common/model/cursor_pagination_model.dart';
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
abstract class RecipeRepository{
  
  factory RecipeRepository(Dio dio,{String baseUrl})
  = _RecipeRepository;
  
  @GET('/all')
  @Headers({
    'accessToken':'true'
  })
  Future<List<RecipeModel>> paginate();
}