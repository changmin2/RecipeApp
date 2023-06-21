import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/common/component/custom_text_form_field.dart';
import 'package:recipe_app/common/layout/default_layout.dart';
import 'package:recipe_app/user/model/user_model.dart';
import 'package:recipe_app/user/provider/user_me_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static String get routeName => 'login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {

  String username ='';
  String password ='';

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userMeProvider);

    return DefaultLayout(
      backgroundColor: Color.fromRGBO(250, 234, 215,12),
      child: Center(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: SafeArea(
            top: true,
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    'asset/img/login/login.png',
                  ),
                  const SizedBox(height: 16.0),
                  CustomTextFormField(
                      onChanged: (String value){
                        username= value;
                      },
                      hintText: '아이디를 입력하세요',
                  ),
                  const SizedBox(height: 8.0),
                  CustomTextFormField(
                      onChanged: (String value){
                        password = value;
                      },
                      hintText: '비밀번호를 입력하세요.',
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                      onPressed: state is UserModelLoading
                      ? null
                      : () async {
                        ref.read(userMeProvider.notifier)
                            .login(username: username,password: password);
                      },
                      child: Text('로그인'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.brown.shade400)
                      ),
                  ),
                  ElevatedButton(
                      onPressed: state is UserModelLoading
                          ? null
                          : () async {
                        ref.read(userMeProvider.notifier)
                            .login(username: username,password: password);
                      },
                      child: Text('회원가입'),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.brown.shade400)
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
