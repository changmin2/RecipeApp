import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/common/provider/comment_pagination_provider.dart';
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

  //댓글 생성
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

  //댓글 삭제
  Future<void> deleteComment(int comment_id) async {
    await repository.deleteComment(comment_id: comment_id);

    final pState = state as CursorPagination;
    List<CommentModel> tempList = [];

    //comment_id와 같은 항목은 삭제 했으므로 제외
    for(var i =0; i<pState.data.length;i++){
      if(pState.data[i].comment_id != comment_id){
        tempList.add(pState.data[i]);
      }

    }
    state = pState.copyWith(
      data: tempList
    );
  }

  //대댓글 등록
  void createRecommend(String creator,String content, int comment_id) async {
    CommentParam commentParam = new CommentParam(
        creator: creator,
        content: content
    );

    final resp =  await repository.createReComment(comment_id: comment_id,commentParam: commentParam);

    final pState = state as CursorPagination;

    //comment_id와 같은 항목은 삭제 했으므로 제외
    for(var i =0; i<pState.data.length;i++){
      if(pState.data[i].comment_id == comment_id){
        pState.data[i].commentList.add(resp);
        state = pState.copyWith(
          data: pState.data
        );
        break;
      }
    }
  }

  void deleteReComment(int recomment_id,int comment_id) async {
    await repository.deleteReComment(recomment_id: recomment_id);

    final pState = state as CursorPagination;

    for(var i =0; i<pState.data.length;i++){
      if(pState.data[i].comment_id == comment_id){
        pState.data[i].commentList.removeWhere((item) => item.recomment_id == recomment_id);
        state = pState.copyWith(
            data: pState.data
        );
        break;
      }
    }
  }
}