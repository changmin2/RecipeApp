import 'package:flutter/material.dart';
import 'package:recipe_app/common/layout/default_layout_v2.dart';

class ChefRegisteScreen2 extends StatefulWidget {
  static get routeName => 'chefRegister2';
  const ChefRegisteScreen2({Key? key}) : super(key: key);

  @override
  State<ChefRegisteScreen2> createState() => _ChefRegisteScreen2State();
}

class _ChefRegisteScreen2State extends State<ChefRegisteScreen2> {
  @override
  Widget build(BuildContext context) {
    return DefaultLayoutV2(
        appBar: _renderAppbar(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('두번째')
          ],
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
