import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/common/layout/default_layout.dart';
import 'package:recipe_app/recipe/provider/recipe_provider.dart';

class RecipeDetailScreen extends ConsumerStatefulWidget {
  static get routeName => 'recipeDetail';
  final int id;


  const RecipeDetailScreen({
    required this.id,
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

    ref.read(recipeProvider.notifier).getDetail(id: widget.id);

  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(recipeDetailProvider(widget.id));
    if(state==null) {
      return DefaultLayout(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

      return DefaultLayout(
          child: Column(
            children:[
              Text(
                state.recipe_nm,
              ),
              Text(
                state.summary,
              )
            ]
          )
      );
    }
}
