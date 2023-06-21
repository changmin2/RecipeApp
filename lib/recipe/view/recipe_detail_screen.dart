import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/common/layout/default_layout.dart';
import 'package:recipe_app/common/provider/go_router.dart';
import 'package:recipe_app/recipe/model/recipe_detail_model.dart';
import 'package:recipe_app/recipe/provider/recipe_provider.dart';

import '../../common/component/pagination_list_view.dart';
import '../component/recipe_card.dart';

class RecipeDetailScreen extends ConsumerStatefulWidget {
  static get routeName => 'recipeDetail';
  final int recipe_id;


  const RecipeDetailScreen({
    required this.recipe_id,
    Key? key
  }) : super(key: key);
  @override
  ConsumerState<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends ConsumerState<RecipeDetailScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('레시피ID: '+widget.recipe_id.toString());
    ref.read(recipeProvider.notifier).getDetail(id: widget.recipe_id);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(recipeDetailProvider(widget.recipe_id));
    if (state == null) {
      return DefaultLayout(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    if (state is RecipeDetailModel) {
      // return DefaultLayout(
      //     child: CustomScrollView(
      //       slivers: <Widget>[
      //         new SliverAppBar(
      //           pinned: true,
      //           centerTitle: true,
      //           expandedHeight: 400,
      //           backgroundColor: Colors.white,
      //           bottom: PreferredSize(
      //             preferredSize: const Size.fromHeight(0),
      //             child: Padding(
      //               padding: EdgeInsets.only(bottom: 10),
      //               child: Text(
      //                 '조리방법',
      //                 textAlign: TextAlign.left,
      //                 style: TextStyle(
      //                   fontWeight: FontWeight.w700,
      //                   fontSize: 24
      //                 ),
      //               ),
      //             ),
      //           ),
      //           flexibleSpace: FlexibleSpaceBar(
      //             background: Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 RecipeCard(
      //                   recipe_nm: state.recipe_nm,
      //                   summary: state.summary,
      //                   nation_nm: state.nation_nm,
      //                   cooking_time: state.cooking_time,
      //                   calorie: state.calorie,
      //                   imgUrl: state.image_url,
      //                   level: state.level_nm,
      //                   isDetail: true,
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ),
      //
      //         SliverList(
      //
      //           delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
      //             return Padding(
      //               padding: EdgeInsets.all(16),
      //               child: Container(
      //                 child: Column(
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: [
      //                     Text(
      //                       state.data[index].cooking_no.toString() +'.',
      //                       style: TextStyle(
      //                           fontSize: 20
      //                       ),
      //                     ),
      //                     const SizedBox(height: 8.0),
      //                     Row(
      //                       mainAxisAlignment: MainAxisAlignment.start,
      //                       children: [
      //                         if(state.data[index].cooking_img.length>1)
      //                           SizedBox(
      //                             child: Image.network(
      //                               state.data[index].cooking_img,
      //                               fit: BoxFit.fill,
      //                             ),
      //                           ),
      //                         Flexible(
      //                           child: Text(
      //                             state.data[index].cooking_dc,
      //                             style: TextStyle(
      //                                 fontSize: 18,
      //                                 fontWeight: FontWeight.w500
      //                             ),
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                     const SizedBox(height: 16.0)
      //                   ],
      //                 ),
      //               ),
      //             );
      //           }, childCount: state.data.length),
      //         ),
      //       ],
      //     )
      // );
      return DefaultLayout(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(),
              renderDetail(state: state)
            ],
          )
      );
    }
    else {
      return DefaultLayout(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}

Expanded renderDetail({
  required RecipeDetailModel state
}){
  return Expanded(
    child: ListView.builder(
      itemCount: state.data.length,
      itemBuilder: (BuildContext context,int index){
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              index==0
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RecipeCard(
                          recipe_nm: state.recipe_nm,
                          summary: state.summary,
                          nation_nm: state.nation_nm,
                          cooking_time: state.cooking_time,
                          calorie: state.calorie,
                          imgUrl: state.image_url,
                          level: state.level_nm,
                          isDetail: true,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Text(
                            '조리 방법',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700
                            ),
                          ),
                        ),
                        const SizedBox(height: 8.0)
                      ],
                  )
                  : Container(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  state.data[index].cooking_no.toString() +'.',
                  style: TextStyle(
                    fontSize: 20
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if(state.data[index].cooking_img.length>1)
                      SizedBox(
                        child: Image.network(
                          state.data[index].cooking_img,
                          fit: BoxFit.fill,
                        ),
                      ),
                    Flexible(
                      child: Text(
                          state.data[index].cooking_dc,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500
                          ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0)
            ],
          ),
        );
      },
    ),
  );
}
