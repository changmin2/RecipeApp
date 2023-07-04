import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/user_model.dart';
import '../provider/user_me_provider.dart';

class ProfiesScreen extends ConsumerWidget {
  const ProfiesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final state = ref.watch(userMeProvider);
    final pState = state as UserModel;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start ,
        children: [
          const SizedBox(height: 100),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              'asset/img/logo/appLogo.png',
              fit: BoxFit.cover,
              height: 150,
            ),
          ),
          const SizedBox(height: 10),
          Text(
              pState.username+' 님 안녕하세요!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500
              ),
          ),
          const SizedBox(height: 18),
          Text(
            '현재 기능을 계속 추가하고 있는 상태입니다.'
          ),
          const SizedBox(height: 18),
          Text(
            '원하시는 기능이 있다면 아래의 이메일로 연락주세요',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'dlckdals9467@naver.com'
          ),
          const SizedBox(height: 100),
          ElevatedButton(
            onPressed: (){
              ref.read(userMeProvider.notifier).logout();
            },
            child: Text(
                '로그아웃'
            ),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown
            ),
          ),
          const SizedBox(height: 46),
          Text(
            '앱 버전 1.0.0'
          ),
        ],
      ),
    );
  }
}