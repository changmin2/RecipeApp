import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/common/provider/go_router.dart';
import 'package:recipe_app/recipe/provider/search_recipe_provider.dart';
import 'package:recipe_app/recipe/view/recipe_detail_screen.dart';
import 'package:recipe_app/recipe/view/recipe_search_detail_screen.dart';

import '../../common/component/pagination_list_view.dart';
import '../../common/layout/default_layout.dart';
import '../component/recipe_card.dart';

class SearchRecipe extends ConsumerWidget {
  static get routeName => 'searchRecipe';
  final String search;
  const SearchRecipe({
    required this.search,
    Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return DefaultLayout(
      isDetail: true,
      title: search,
      child: PaginationListView(
          provider: searchRecipeProvider(search),
          itemBuilder: <RecipeModel>(_,index,recipe){
            return GestureDetector(
              onTap: (){
                context.goNamed(SearchRecipeDetailScreen.routeName,
                    pathParameters: {
                      'search':search,
                      'rid':recipe.recipe_id.toString()
                    });
              },
              child: RecipeCard(
                  recipe_nm: recipe.recipe_nm,
                  summary: recipe.summary,
                  nation_nm: recipe.nation_nm,
                  cooking_time: recipe.cooking_time,
                  calorie: recipe.calorie,
                  imgUrl: recipe.image_url,
                  level: recipe.level_nm
              ),
            );
          }),
    );
  }
}
