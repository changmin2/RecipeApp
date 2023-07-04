import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../user/provider/clip_provider.dart';

class ClipCard extends ConsumerWidget {
  //레시피 번호
  final int recipe_id;
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
  //상세페이지인지
  final bool isDetail;


  const ClipCard({
    required this.recipe_id,
    required this.recipe_nm,
    required this.summary,
    required this.nation_nm,
    required this.cooking_time,
    required this.calorie,
    required this.imgUrl,
    required this.level,
    this.isDetail=false,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {

    final state =ref.watch(clipProvider.notifier);
    final clipState = ref.watch(clipeDetailProvider(recipe_id));
    var rating = 0;
    if(level=='초보환영') rating =1;
    else if(level=='보통') rating=2;
    else rating=3;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0)
      ),
      elevation: 4.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(
            imgUrl,
            fit:BoxFit.fill,
            width: 120,
            height: 120,
          ),
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: SizedBox(
              width: 125,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe_nm,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8.0),
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
                        size: 20,
                      ))
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16.0),
          IconButton(

            onPressed: (){
              clipState ==null ?
              state.addClip(id: recipe_id) : state.deleteClip(id: recipe_id);
            },
            icon: Icon(
              clipState==null ?
              Icons.label_important_outline
                  : Icons.label_important,
              color: Colors.red,
              size: 35,
            )
            ,
            // Icons.label_important_outline,
            // color: Colors.red,
            // size: 35,
          ),
          const SizedBox(width: 10,)
        ],
      ),
    );
  }
}
