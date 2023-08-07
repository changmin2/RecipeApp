import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';
import 'package:recipe_app/recipe/provider/level_provider.dart';
import 'package:recipe_app/recipe/provider/nm_provider.dart';
import '../../common/model/cursor_pagination_model.dart';
import '../../common/provider/pagination_provider.dart';
import '../model/recipe_model.dart';
import '../repository/recipe_repository.dart';

final categoryDetailProvider =
Provider.family<RecipeModel?,int>((ref,id) {
  final state = ref.watch(categoryRecipeProvider);

  if(state is! CursorPagination){
    return null;
  }

  return state.data.firstWhereOrNull((element) => element.recipe_id == id);

});

final categoryRecipeProvider = StateNotifierProvider<SearchRestaurantStateNotifier,CursorPaginationBase>(
        (ref) {
      final repository = ref.watch(recipeRepositoryProvider);
      final nmState = ref.watch(nmProvider);
      final levelState = ref.watch(levelProvider);
      final notifier = SearchRestaurantStateNotifier(repository: repository,nm:nmState,level: levelState);

      return notifier;
    }
);

class SearchRestaurantStateNotifier extends PaginationProvider<RecipeModel,RecipeRepository>{

  SearchRestaurantStateNotifier({
    required super.repository,
    required super.nm,
    required super.level
  });

  void init(){
    state is CursorPaginationLoading;
  }
  Future<void> getDetail({
    required int id,
  })async{
    // 만약에 아직 데이터가 하나도 없는 상태라면 (CursorPagination이 아니라면)
    // 데이터를 가져오는 시도를 한다.
    if(state is! CursorPagination){
      await this.paginate(
        nm:nm!,
        level: level!,
      );
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
    if(pState.data.where((e) => e.recipe_id==id).isEmpty){
      state = pState.copyWith(
          data: <RecipeModel>[
            ...pState.data,
            resp
          ]
      );

    }else{
      state = pState.copyWith(
          data: pState.data.map<RecipeModel>((e) => e.recipe_id==id ? resp : e).toList()
      );
    }
  }
}