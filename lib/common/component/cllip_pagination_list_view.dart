import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/common/provider/clip_pagination_provider.dart';
import 'package:recipe_app/common/repository/base_pagination_repository.dart';

import '../model/cursor_pagination_model.dart';
import '../model/model_with_id.dart';
import '../provider/pagination_provider.dart';
import '../utils/pagination_utils.dart';

typedef PaginationWidgetBuilder<T extends IModelWithId> =
Widget Function(BuildContext context, int index,T model);

class ClipPaginationListView<T extends IModelWithId> extends ConsumerStatefulWidget {
  final StateNotifierProvider<ClipPaginationProvider,CursorPaginationBase> provider;
  final PaginationWidgetBuilder<T> itemBuilder;


  const ClipPaginationListView({
    required this.provider,
    required this.itemBuilder,
    Key? key}) : super(key: key);

  @override
  ConsumerState<ClipPaginationListView> createState() => _PaginationListViewState<T>();
}

class _PaginationListViewState<T extends IModelWithId> extends ConsumerState<ClipPaginationListView> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    controller.addListener(listener);
  }

  void listener(){
    ClipPaginationUtils.paginate(
        controller: controller,
        provider: ref.read(widget.provider.notifier)
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
          '데이터가 없습니다.'
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
                Text('더이상 데이터가 없습니다.'),
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
