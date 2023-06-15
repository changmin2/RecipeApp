import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/common/layout/default_layout.dart';
import 'package:recipe_app/recipe/component/recipe_card.dart';
import 'package:recipe_app/recipe/model/recipe_model.dart';
import 'package:recipe_app/recipe/repository/recipe_repository.dart';

class RecipeScreen extends ConsumerWidget {
  const RecipeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return DefaultLayout(
        title: '주부의 레시피',
        child: FutureBuilder<List<RecipeModel>>(
          future: ref.watch(recipeRepositoryProvider).paginate(),
          builder: (context,snapshot) {
            final List<RecipeModel>? datas = snapshot.data;

            if(snapshot.connectionState != ConnectionState.done){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if(snapshot.hasError){
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }

            if(datas != null){
              return ListView.builder(
                  itemCount: datas.length,
                  itemBuilder: (context,index){
                    final recipe = datas[index];
                    return RecipeCard(
                        recipe_nm: recipe.recipe_nm,
                        summary: recipe.summary,
                        nation_nm: recipe.nation_nm,
                        cooking_time: recipe.cooking_time,
                        calorie: recipe.calorie,
                        imgUrl: recipe.image_url,
                        level: recipe.level_nm
                    );
                  });
            }
            return Center(
              child: Text('No Data'),
            );
          }
        ),
    );
  }
}
