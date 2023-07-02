import 'package:flutter/material.dart';

import '../model/recipe_detail_model.dart';

class IngredientCard extends StatelessWidget {
  final List<IngredientDto> ingredients;


  IngredientCard({
    required this.ingredients,
    Key? key
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: ingredients.length,
        itemBuilder: (BuildContext context,int index){
          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                index == 0 ? Padding(
                  padding: EdgeInsets.only(left: 10,bottom: 8),
                  child: Text(
                      '재료',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.green
                    ),
                  ),
                ) : Container(),
                Padding(
                  padding: EdgeInsets.only(left: 60,right: 60),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ingredients[index].ingredientName,
                        style: TextStyle(
                          fontSize: 18
                        ),
                      ),

                      Text(
                        ingredients[index].quantity
                      ),
                    ],
                  ),
                ),
              ]
            ),
          );
        }

    );
  }
}
