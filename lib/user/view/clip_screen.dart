import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/common/component/cllip_pagination_list_view.dart';
import 'package:recipe_app/recipe/component/clip_card.dart';
import 'package:recipe_app/user/provider/clip_provider.dart';

import '../../common/component/pagination_list_view.dart';
import '../../common/layout/default_layout.dart';
import '../../recipe/component/recipe_card.dart';
import '../../recipe/view/category_recipe_detail_screen.dart';
import '../../recipe/view/recipe_detail_screen.dart';

class ClipScreen extends ConsumerWidget {
  const ClipScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return DefaultLayout(
      title: '저장한 레시피들',
      clipScreen: true,
      child: ClipPaginationListView(
          provider: clipProvider,
          itemBuilder: <RecipeModel>(_,index,recipe){
            return GestureDetector(
              onTap: (){
                context.goNamed(CategoryRecipeDetailScreen.routeName,
                    pathParameters: {
                      'rid':recipe.recipe_id.toString()
                    });
              },
              child: ClipCard(
                  recipe_nm: recipe.recipe_nm,
                  summary: recipe.summary,
                  nation_nm: recipe.nation_nm,
                  cooking_time: recipe.cooking_time,
                  calorie: recipe.calorie,
                  imgUrl: recipe.image_url,
                  level: recipe.level_nm,
                  recipe_id: recipe.recipe_id,
              ),
            );
          }),
    );
  }
}
