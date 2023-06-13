import 'package:flutter/material.dart';
import 'package:recipe_app/recipe/component/recipe_card.dart';

class RecipeScreen extends StatelessWidget {
  const RecipeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RecipeCard(
              recipe_nm: '나물비빔밥',
              summary: '육수로 지은 밥에 야채를 듬뿍 넣은 영양만점 나물비빔밥!',
              nation_nm: '한식',
              cooking_time: '60분',
              calorie: '580Kcal',
              imgUrl: 'http://file.okdab.com/UserFiles/searching/recipe/000200.jpg',
              level: '보통',
    );
  }
}
