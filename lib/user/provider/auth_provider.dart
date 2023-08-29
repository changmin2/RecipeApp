import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/Chef/view/chef_register_screen.dart';
import 'package:recipe_app/Chef/view/chef_register_screen2.dart';
import 'package:recipe_app/common/view/root_tap.dart';
import 'package:recipe_app/recipe/view/recipe_comment_screen.dart';
import 'package:recipe_app/recipe/view/recipe_detail_screen.dart';
import 'package:recipe_app/recipe/view/recipe_search_detail_screen.dart';
import 'package:recipe_app/recipe/view/search_recipe_screen.dart';
import 'package:recipe_app/user/provider/user_me_provider.dart';
import 'package:recipe_app/user/repository/user_me_repository.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/user/view/join_screen.dart';
import 'package:recipe_app/user/view/splash_screen.dart';
import '../../recipe/view/category_recipe_detail_screen.dart';
import '../model/user_model.dart';
import '../view/login_screen.dart';

final authProvider = ChangeNotifierProvider<AuthProviderNotifier>((ref) {
  return AuthProviderNotifier(ref: ref);
});

class AuthProviderNotifier extends ChangeNotifier{
  final Ref ref;

  AuthProviderNotifier({
    required this.ref
  }){
    ref.listen<UserModelBase?>(userMeProvider, (previous, next) {
      if(previous!=next){
        notifyListeners();
      }
    });
  }

  List<GoRoute> get routes => [
    GoRoute(
        path: '/',
        name: RootTab.routeName,
        builder: (_,__) => RootTab(),
        routes: [
          GoRoute(
              path: 'recipe/:rid',
              name: CategoryRecipeDetailScreen.routeName,
              builder: (_,state) => RecipeDetailScreen(
                recipe_id: int.parse(state.pathParameters['rid']!)
                  //rid: 123
              ),
            routes: [
                GoRoute(
                  path: 'recipeComment/:recipe_id',
                  name: RecipeCommentScreen.routeName,
                  builder: (_,state) => RecipeCommentScreen(
                  recipe_id: int.parse(state.pathParameters['recipe_id']!)
                  //rid: 123
                ),
              )
            ]
          ),
          GoRoute(
              path: 'search/:search',
              name: SearchRecipe.routeName,
              builder: (_,state) => SearchRecipe(
                search: state.pathParameters['search']!,
              ),
              routes: [
                GoRoute(
                    path: 'searchDetail/:rid',
                    name: SearchRecipeDetailScreen.routeName,
                    builder: (_,state) => SearchRecipeDetailScreen(
                      recipe_id: int.parse(state.pathParameters['rid']!),
                      //rid: 123
                    )
                ),
              ]
          ),
          GoRoute(
              path: 'chef/register',
              name: ChefRegisterScreen.routeName,
              builder: (_,state) => ChefRegisterScreen(),
              routes: [
                GoRoute(
                    path: 'chef/register/two',
                    name: ChefRegisteScreen2.routeName,
                    builder: (_,state) => ChefRegisteScreen2(
                      //rid: 123
                    )
                ),
              ]
          )
        ]
    ),
    GoRoute(
        path: '/splash',
        name: SplashScreen.routeName,
        builder: (_,__) => SplashScreen()
    ),
    GoRoute(
        path: '/login',
        name: LoginScreen.routeName,
        builder: (_,__) => LoginScreen(),
        routes: [
          GoRoute(
              path: 'join',
              name: JoinScreen.routeName,
              builder: (_,__) => JoinScreen()
          ),
        ]
    ),
  ];

  void logout(){
    ref.read(userMeProvider.notifier).logout();
  }

  //SplashScreen
  //앱을 처음 시작했을때
  //토큰이 존재하는지 확인하고
  //로그인 스크린으로 보내줄지
  //홈스크린으로 보내줄지 확인하는 과정이 필요
  FutureOr<String?> redirectLogic(BuildContext context,GoRouterState state)  {
    final UserModelBase? user = ref.read(userMeProvider);
    //로그인 중
    final logginIn = state.location == '/login';
    //회원가입 페이지 이동중인지
    final joinIn = state.location == '/login/join';
    //유저 정보가 없는데
    //로그인중이면 그대로 로그인 페이지에 두고
    //만약 로그인중이 아니라면 로그인 페이지로 이동
    if(user == null && !joinIn){
      return logginIn ? null : '/login';
    }
    //회원가입 페이지로 이동중이라면
    if(user==null && joinIn){
      return '/login/join';
    }


    //user가 null이 아님

    //UserModel
    //사용자 정보가 있는상태면
    //로그인 중이거나 현재 위치가 SplashScreen이면
    //홈으로 이동
    if(user is UserModel){
      return logginIn || state.location == '/splash' ? '/' : null;
    }

    //UserModelError
    if(user is UserModelError){
      if(joinIn){
        return '/login/join';
      }
      return logginIn ? null : '/login';
    }

    return null;
  }
}