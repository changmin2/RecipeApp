import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:recipe_app/common/provider/comment_pagination_provider.dart';
import 'package:recipe_app/common/provider/pagination_provider.dart';
import 'package:recipe_app/recipe/component/comment_param.dart';
import 'package:recipe_app/recipe/model/comment_model.dart';
import 'package:recipe_app/recipe/repository/comment_repository.dart';

import '../../common/model/cursor_pagination_model.dart';

final commentProvider = StateNotifierProvider.family<CommentStateNotifier,CursorPaginationBase,int>(
        (ref,recipe_id) {
          final repository = ref.watch(commentRepositoryProvider);
          final notifier = CommentStateNotifier(
            repository: repository,
            recipe_id: recipe_id
          );

          return notifier;
        }
);

class CommentStateNotifier extends CommentPaginationProvider<CommentModel,CommentRepository>{

  CommentStateNotifier({
    required super.repository,
    required super.recipe_id,
  });

  void createComment(String creator,String content) async {
    CommentParam commentParam = new CommentParam(
      creator: creator,
      content: content
    );
    //처음에 댓글이 아예 없을 때
    if(state is CursorPaginationError){
      final resp =  await repository.createComment(recipe_id: recipe_id,commentParam: commentParam);
      super.paginate(recipe_id: recipe_id);
    }
    //댓글을 추가하는 경우
    else{
      final pState = state as CursorPagination;
      //Detail은 RestaurantModel을 상속받은 것이므로 교체해준다.
      final resp =  await repository.createComment(recipe_id: recipe_id,commentParam: commentParam);
      state = pState.copyWith(
          data: <CommentModel>[
            ...pState.data,
            resp
          ]
      );
    }

  }

}