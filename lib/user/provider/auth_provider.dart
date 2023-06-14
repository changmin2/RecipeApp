import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/common/view/root_tap.dart';
import 'package:recipe_app/user/provider/user_me_provider.dart';
import 'package:recipe_app/user/repository/user_me_repository.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/user/view/splash_screen.dart';
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
        builder: (_,__) => RootTab()
    ),
    GoRoute(
        path: '/splash',
        name: SplashScreen.routeName,
        builder: (_,__) => SplashScreen()
    ),
    GoRoute(
        path: '/login',
        name: LoginScreen.routeName,
        builder: (_,__) => LoginScreen()
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
  FutureOr<String?> redirectLogic(BuildContext context,GoRouterState state){
    final UserModelBase? user = ref.read(userMeProvider);
    //로그인 중
    final logginIn = state.location == '/login';
    //유저 정보가 없는데
    //로그인중이면 그대로 로그인 페이지에 두고
    //만약 로그인중이 아니라면 로그인 페이지로 이동
    if(user == null){
      return logginIn ? null : '/login';
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
      return logginIn ? null : '/login';
    }

    return null;
  }
}