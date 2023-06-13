import 'package:flutter/material.dart';
import 'package:recipe_app/common/layout/default_layout.dart';
import 'package:recipe_app/recipe/view/recipe_screen.dart';

class RootTab extends StatefulWidget {
  static String get routeName => 'home';
  const RootTab({Key? key}) : super(key: key);

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin{

  late TabController controller;
  int index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(length: 1, vsync: this);
  }

  @override
  void dispose() {
    controller.removeListener(tabListener);
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '주부의 레시피',
      child: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller,
        children: [
          RecipeScreen()
        ],
      ),
    );
  }

  void tabListener(){
    setState(() {
      index = controller.index;
    });
  }
}
