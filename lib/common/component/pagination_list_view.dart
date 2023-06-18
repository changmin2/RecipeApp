import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/cursor_pagination_model.dart';
import '../model/model_with_id.dart';
import '../provider/pagination_provider.dart';
import '../utils/pagination_utils.dart';

typedef PaginationWidgetBuilder<T extends IModelWithId> =
Widget Function(BuildContext context, int index,T model);

class PaginationListView<T extends IModelWithId> extends ConsumerStatefulWidget {
  final StateNotifierProvider<PaginationProvider,CursorPaginationBase> provider;
  final PaginationWidgetBuilder<T> itemBuilder;


  const PaginationListView({
    required this.provider,
    required this.itemBuilder,
    Key? key}) : super(key: key);

  @override
  ConsumerState<PaginationListView> createState() => _PaginationListViewState<T>();
}

class _PaginationListViewState<T extends IModelWithId> extends ConsumerState<PaginationListView> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    controller.addListener(listener);
  }

  void listener(){
    PaginationUtils.paginate(
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
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            state.message,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16,),
          ElevatedButton(
              onPressed: (){
                ref.read(widget.provider.notifier).paginate(
                    forceRefetch: true
                );
              },
              child: Text(
                  '다시시도'))
        ],
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
