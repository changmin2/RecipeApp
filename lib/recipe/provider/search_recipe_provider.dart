import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/model/cursor_pagination_model.dart';
import '../../common/provider/pagination_provider.dart';
import '../model/recipe_model.dart';
import '../repository/recipe_repository.dart';

final searchRecipeProvider = StateNotifierProvider.family<SearchRestaurantStateNotifier,CursorPaginationBase,String>(
        (ref,keyword) {
      final repository = ref.watch(recipeRepositoryProvider);

      final notifier = SearchRestaurantStateNotifier(repository: repository,keyword:keyword);

      return notifier;
    }
);

class SearchRestaurantStateNotifier extends PaginationProvider<RecipeModel,RecipeRepository>{

  SearchRestaurantStateNotifier({
    required super.repository,
    required super.keyword
  });

  void init(){
    state is CursorPaginationLoading;
  }
  void getDetail({
    required int id,
  })async{
    // 만약에 아직 데이터가 하나도 없는 상태라면 (CursorPagination이 아니라면)
    // 데이터를 가져오는 시도를 한다.
    if(state is! CursorPagination){
      await this.paginate(
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