import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/common/layout/default_layout.dart';
import 'package:recipe_app/common/provider/go_router.dart';
import 'package:recipe_app/recipe/model/recipe_detail_model.dart';
import 'package:recipe_app/recipe/provider/recipe_provider.dart';

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
    if(state==null) {
      return DefaultLayout(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    if(state is RecipeDetailModel){
      print(state.data[0].cooking_dc);
    }
    return DefaultLayout(

          child: Column(
            children:[
              Text(
                'ㅗㅑㅗㅑ',
              ),
              Text(
                'ㅗㅑㅗㅑ',
              )
            ]
          )
      );
    }
}
