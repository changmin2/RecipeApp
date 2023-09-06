import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:recipe_app/common/layout/default_layout_v2.dart';

class ChefRegisteScreen2 extends StatefulWidget {
  static get routeName => 'chefRegister2';
  final  query;
  const ChefRegisteScreen2({
    required this.query,
    Key? key
  }) : super(key: key);

  @override
  State<ChefRegisteScreen2> createState() => _ChefRegisteScreen2State();
}

class _ChefRegisteScreen2State extends State<ChefRegisteScreen2> {
  @override
  Widget build(BuildContext context) {
    //첫번째 단계에서 전달받은 값
    Map toss = widget.query as Map<String,String>;
    return DefaultLayoutV2(
        appBar: _renderAppbar(context),
        child: Padding(
          padding: EdgeInsets.only(left: 20,right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '재료등록',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  OutlinedButton(
                      onPressed: (){},
                      child: Text('추가')
                  )
                ],
              )
            ],
          ),
        )
    );
  }
}


AppBar _renderAppbar(BuildContext context){
  return AppBar(
      backgroundColor: Colors.white,
      title: Text(
        '레시피 등록 두번째',
        style: TextStyle(
            color: Colors.brown,
            fontWeight: FontWeight.w700,
            fontSize: 24
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
