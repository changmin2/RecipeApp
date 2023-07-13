import 'package:flutter/material.dart';
import 'package:recipe_app/common/layout/default_layout.dart';
import 'package:recipe_app/common/layout/default_layout_v2.dart';
import 'package:recipe_app/recipe/component/comment_card.dart';
import 'package:recipe_app/recipe/component/recomment_card.dart';

class RecipeCommentScreen extends StatelessWidget {
  static get routeName => 'recipeComment';
  final int recipe_id;

  const RecipeCommentScreen({
    required this.recipe_id,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayoutV2(
      appBar: _renderAppbar(context),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CommentCard(),
            ReCommentCard(),
            ReCommentCard(),
            CommentCard(),
          ],
        )
      ),
    );
  }
}
AppBar _renderAppbar(BuildContext context){
  return AppBar(
    backgroundColor: Colors.white,
    title: Text(
      '댓 글',
      style: TextStyle(
          color: Colors.brown,
          fontWeight: FontWeight.w700
      ),
    ),
    centerTitle: true,
    leading: IconButton(
        onPressed: (){Navigator.pop(context);},
        icon: Icon(Icons.arrow_back),
        color: Colors.brown,
        alignment: Alignment.centerLeft,
      )
  );
}
