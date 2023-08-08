import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/Chef/view/chef_register_screen.dart';
import 'package:recipe_app/common/layout/default_layout_v2.dart';

class ChefScreen extends StatelessWidget {
  const ChefScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayoutV2(
        appBar: _renderAppbar(context),
        floatingActionButton: _floatingActionButton(context),
        child: Center(
          child: Text(
            '셰프'
          ),
        )
    );
  }
}

AppBar _renderAppbar(BuildContext context){
  return AppBar(
      backgroundColor: Colors.white,
      title: Text(
        '쉐프',
        style: TextStyle(
            color: Colors.brown,
            fontWeight: FontWeight.w700,
            fontSize: 24
        ),
      ),
      centerTitle: true
  );
}

FloatingActionButton _floatingActionButton(BuildContext context){

  return FloatingActionButton.extended(
    backgroundColor: Colors.green,
    onPressed: (){
      context.goNamed(ChefRegisterScreen.routeName);
    },
    label: Text(
        "레시피 등록"
    ),
    icon: Icon(
      Icons.edit,
    ),
  );
}
