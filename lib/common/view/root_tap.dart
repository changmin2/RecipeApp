import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/common/layout/default_layout.dart';
import 'package:recipe_app/recipe/view/recipe_screen.dart';
import 'package:recipe_app/user/provider/clip_provider.dart';
import 'package:recipe_app/user/view/clip_screen.dart';
import 'package:recipe_app/user/view/profile_screen.dart';

import '../const/colors.dart';

class RootTab extends ConsumerStatefulWidget {
  static String get routeName => 'home';
  const RootTab({Key? key}) : super(key: key);

  @override
  ConsumerState<RootTab> createState() => _RootTabState();
}

class _RootTabState extends ConsumerState<RootTab> with SingleTickerProviderStateMixin{

  late TabController controller;
  int index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    controller.removeListener(tabListener);
    //controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller,
        children: [
          RecipeScreen(),
          ClipScreen(),
          ProfiesScreen()
        ],
      ),
      bottomNavagtionBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: PRIMARY_COLOR,
        unselectedItemColor: BODY_TEXT_COLOR,
        onTap: (int index){
          if(index==1){
            ref.read(clipProvider.notifier).paginate(forceRefetch: true);
          }
          controller.animateTo(index);
          controller.addListener(tabListener);
        },
        showUnselectedLabels: true,

        currentIndex: index,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: '홈'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.star_border_outlined),
              label: '즐겨찾기'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.perm_identity),
              label: '프로필'
          ),
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
