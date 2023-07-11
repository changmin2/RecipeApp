import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/common/component/pagination_list_view.dart';
import 'package:recipe_app/common/layout/default_layout.dart';
import 'package:recipe_app/recipe/component/recipe_card.dart';
import 'package:recipe_app/recipe/provider/category_recipe_provider.dart';
import 'package:recipe_app/recipe/provider/level_provider.dart';
import 'package:recipe_app/recipe/provider/nm_provider.dart';

import 'category_recipe_detail_screen.dart';

class RecipeScreen extends ConsumerStatefulWidget {
  const RecipeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RecipeScreen> createState() => _RecipeScreen();
}

class _RecipeScreen extends ConsumerState<RecipeScreen> {

  final _nationNmList = ['전체','한식','중국','동남아시아','서양','이탈리아','퓨전','일본'];
  final _levelList = ['전체','초보환영','보통','어려움'];

  @override
  Widget build(BuildContext context) {
    final nmState = ref.watch(nmProvider);
    final levelState = ref.watch(levelProvider);
    return DefaultLayout(
      title: 'hi',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '종류: '
              ),
              const SizedBox(width: 8),
              DropdownButton(
                  value: nmState,
                  items: _nationNmList.map(
                          (value) {
                            return DropdownMenuItem(
                                value: value,
                                child: Text(value)
                            );
                          }
                  ).toList(),
                  onChanged: (value) {
                    ref.read(nmProvider.notifier).update((state) => value!);
                  },
              ),
              const SizedBox(width: 16.0),
              Text(
                  '난이도: '
              ),
              const SizedBox(width: 8),
              DropdownButton(

                value: levelState,
                items: _levelList.map(
                        (value) {
                      return DropdownMenuItem(
                          value: value,
                          child: Text(value)
                      );
                    }
                ).toList(),
                onChanged: (value){
                  ref.read(levelProvider.notifier).update((state) => value!);
                },
              ),
            ],
          ),
          Expanded(
            child: PaginationListView(
              provider: categoryRecipeProvider,
              itemBuilder: <RecipeModel>(_,index,recipe){
                return GestureDetector(
                  onTap: (){
                    context.goNamed(CategoryRecipeDetailScreen.routeName,
                        pathParameters: {
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
          ),
      ]
    ),
    );
  }
}

