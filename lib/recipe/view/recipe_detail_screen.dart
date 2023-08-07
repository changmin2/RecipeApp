import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/common/layout/default_layout.dart';
import 'package:recipe_app/common/provider/go_router.dart';
import 'package:recipe_app/recipe/model/recipe_detail_model.dart';
import 'package:recipe_app/recipe/provider/category_recipe_provider.dart';
import 'package:recipe_app/recipe/provider/recipe_provider.dart';

import '../../common/component/pagination_list_view.dart';
import '../component/ingredient_card.dart';
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
    ref.read(categoryRecipeProvider.notifier).getDetail(id: widget.recipe_id);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(categoryDetailProvider(widget.recipe_id));
    if (state == null) {
      return DefaultLayout(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    if (state is RecipeDetailModel) {
      return DefaultLayout(
          title: "",
          isDetail: true,
          isClip: true,
          recipe_id: widget.recipe_id,
          commentCount: state.commentCount,
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
                  index ==0 ? Column(
                      children: [
                        IngredientCard(
                          ingredients: state.ingredients,
                        ),
                        const SizedBox(height: 8.0),
                        state.ingredients.length >0 ? Divider(color: Colors.deepOrangeAccent)
                            : Container(),
                        const SizedBox(height: 8.0)
                      ]
                  ) : Container(),
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
                  const SizedBox(height: 8.0),
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
                          height: 100,
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