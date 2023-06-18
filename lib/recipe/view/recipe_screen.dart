import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/common/component/pagination_list_view.dart';
import 'package:recipe_app/recipe/component/recipe_card.dart';
import 'package:recipe_app/recipe/provider/recipe_provider.dart';
import 'package:recipe_app/recipe/view/recipe_detail_screen.dart';

class RecipeScreen extends ConsumerWidget {
  const RecipeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return PaginationListView(
        provider: recipeProvider,
        itemBuilder: <RecipeModel>(_,index,recipe){
          return GestureDetector(
            onTap: (){
              context.goNamed(RecipeDetailScreen.routeName,
                  pathParameters: {
                    'id':recipe.recipe_id.toString()
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
        });;
  }
}
