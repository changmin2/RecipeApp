import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';
import 'package:recipe_app/recipe/model/recipe_model.dart';
import 'package:recipe_app/recipe/repository/recipe_repository.dart';

import '../../common/model/cursor_pagination_model.dart';
import '../../common/provider/pagination_provider.dart';

final recipeDetailProvider =
Provider.family<RecipeModel?,int>((ref,id) {
  final state = ref.watch(recipeProvider);

  if(state is! CursorPagination){
    return null;
  }

  return state.data.firstWhereOrNull((element) => element.id == id);

});

final recipeProvider = StateNotifierProvider<RestaurantStateNotifier,CursorPaginationBase>(
        (ref) {
      final repository = ref.watch(recipeRepositoryProvider);

      final notifier = RestaurantStateNotifier(repository: repository);

      return notifier;
    }
);

class RestaurantStateNotifier extends PaginationProvider<RecipeModel,RecipeRepository>{

  RestaurantStateNotifier({
    required super.repository
  });

  void getDetail({
    required int id,
  })async{
    // 만약에 아직 데이터가 하나도 없는 상태라면 (CursorPagination이 아니라면)
    // 데이터를 가져오는 시도를 한다.
    if(state is! CursorPagination){
      await this.paginate();
    }

    // state가 CursorPagination이 아닐때 그냥 리턴
    if(state is! CursorPagination){
      return;
    }


    //원래는 RestaurantModel이지만
    final pState = state as CursorPagination;
    //Detail은 RestaurantModel을 상속받은 것이므로 교체해준다.
    final resp = await repository.getRestaurantDetail(id: id);
    //레스토랑모델이 3개있음
    //요청 10번째 모델
    // 데이터가 없음
    // 캐시의 끝에다가 데이터를 추가
    if(pState.data.where((e) => e.id==id).isEmpty){
      state = pState.copyWith(
          data: <RecipeModel>[
            ...pState.data,
            resp
          ]
      );

    }else{
      state = pState.copyWith(
          data: pState.data.map<RecipeModel>((e) => e.id==id ? resp : e).toList()
      );
    }
  }
}