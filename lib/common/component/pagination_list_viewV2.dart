import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/common/provider/comment_pagination_provider.dart';

import '../model/cursor_pagination_model.dart';
import '../model/model_with_id.dart';
import '../model/model_with_idV2.dart';
import '../provider/pagination_provider.dart';
import '../utils/pagination_utils.dart';

typedef PaginationWidgetBuilder<T extends IModelWithIdV2> =
Widget Function(BuildContext context, int index,T model);

class PaginationListViewV2<T extends IModelWithIdV2> extends ConsumerStatefulWidget {
  final StateNotifierProvider<CommentPaginationProvider,CursorPaginationBase> provider;
  final PaginationWidgetBuilder<T> itemBuilder;
  final int recipe_id;

  const PaginationListViewV2({
    required this.provider,
    required this.itemBuilder,
    required this.recipe_id,
    Key? key}) : super(key: key);

  @override
  ConsumerState<PaginationListViewV2> createState() => _PaginationListViewStateV2<T>();
}

class _PaginationListViewStateV2<T extends IModelWithIdV2> extends ConsumerState<PaginationListViewV2> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    controller.addListener(listener);
  }

  void listener(){
    PaginationUtilsV2.paginate(
        controller: controller,
        provider: ref.read(widget.provider.notifier),
        recipe_id: widget.recipe_id
    );
  }

  @override
  void dispose() {
    controller.removeListener(listener);
    controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(widget.provider);
    //완전 처음 로딩 일때
    if(state is CursorPaginationLoading){
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if(state is CursorPaginationError){
      return Center(
        child: Text(
          '댓글이 없습니다.'
        ),
      );
    }

    final cp = state as CursorPagination<T>;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child:  ListView.separated(
        controller: controller,
        itemCount: cp.data.length + 1,
        itemBuilder: (_,index){
          if(index == cp.data.length){
            return Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8
              ),
              child: Center(
                child: cp is CursorPaginationFetchingMore ?
                CircularProgressIndicator() :
                Text('댓글이 없습니다.'),
              ),
            );
          }

          final pItem = cp.data[index];

          //parsed변환
          return widget.itemBuilder(
            context,
            index,
            pItem,
          );
        },
        separatorBuilder: (_,index){
          return SizedBox(height: 16,);
        },
      ),
    );

  }
}
