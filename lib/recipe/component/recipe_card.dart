import 'package:flutter/material.dart';

class RecipeCard extends StatelessWidget {

  //요리 이름
  final String recipe_nm;
  //요약 설명
  final String summary;
  //분류 명
  final String nation_nm;
  //조리 시간
  final String cooking_time;
  //칼로리
  final String calorie;
  //대표 이미지
  final String imgUrl;
  //난이도
  final String level;


  const RecipeCard({
    required this.recipe_nm,
    required this.summary,
    required this.nation_nm,
    required this.cooking_time,
    required this.calorie,
    required this.imgUrl,
    required this.level,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var rating = 0;
    if(level=='초보환영') rating =1;
    else if(level=='보통') rating=2;
    else rating=3;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            height: 200,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                  'http://file.okdab.com/UserFiles/searching/recipe/000200.jpg',
                  fit:BoxFit.fill,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                  Text(
                    recipe_nm,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.black
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '난이도:  ',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16
                        ),

                      ),
                      ...List.generate(3, (index) => Icon(
                          index<rating ? Icons.star : Icons.star_border_outlined,
                          color: Colors.red ,
                      ))
                    ],
                  )
                ]
              ),
              const SizedBox(height: 8.0),
              Text(
                summary,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey
                ),
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  Icon(
                    Icons.search,
                    size: 14,
                    color: Colors.green,
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    nation_nm
                  ),
                  const SizedBox(width: 8.0),
                  Icon(
                    Icons.timelapse_outlined,
                    size: 14,
                    color: Colors.green,
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    cooking_time
                  ),
                  const SizedBox(width: 8.0),
                  Icon(
                    Icons.accessibility_new,
                    size: 14,
                    color: Colors.green,
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    calorie
                  )
                ],
              )
            ],
          ),
        )

      ],
    );
  }

}

