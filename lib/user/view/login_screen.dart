import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/common/component/custom_text_form_field.dart';
import 'package:recipe_app/common/layout/default_layout.dart';
import 'package:recipe_app/common/provider/go_router.dart';
import 'package:recipe_app/recipe/view/recipe_detail_screen.dart';
import 'package:recipe_app/recipe/view/recipe_search_detail_screen.dart';
import 'package:recipe_app/user/model/user_model.dart';
import 'package:recipe_app/user/provider/auth_provider.dart';
import 'package:recipe_app/user/provider/user_me_provider.dart';
import 'package:recipe_app/user/view/join_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static String get routeName => 'login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  String username ='';
  String password ='';

  final _idFormKey = GlobalKey<FormState>();
  final _psFormKey = GlobalKey<FormState>();

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
                  const SizedBox(height: 8.0),
                  state is UserModelError
                  ? Center(
                    child: Text(
                      '아이디와 비밀번호를 확인해주세요!!!',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.red,
                        fontWeight: FontWeight.w700
                      ),
                    ),
                  )
                  : Container(),
                  const SizedBox(height: 8.0),
                  Form(
                    key: _idFormKey,
                    child: CustomTextFormField(
                      validator: (value){
                        if(value.length<3){
                          return "아이디를 3글자 이상 입력해주세요.";
                        }else if(value.length>15){
                          return "아이디를 15자 이하로 입력해주세요.";
                        }
                        if(!isValidEmailFormat(value)){
                          return "영문과 숫자 조합으로 입력해주세요.";
                        }
                      },
                        onChanged: (String value){
                          username= value;
                        },
                        hintText: '아이디를 입력하세요',
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Form(
                    key: _psFormKey,
                    child: CustomTextFormField(
                      validator: (value){
                        if(value.length<3){
                          return "비밀번호를 3글자 이상 입력해주세요.";
                        }else if(value.length>15){
                          return "비밀번호를 15자 이하로 입력해주세요.";
                        }
                        if(!isValidEmailFormat(value)){
                          return "영문과 숫자 조합으로 입력해주세요.";
                        }
                      },
                        obscureText: true,
                        onChanged: (String value){
                          password = value;
                        },
                        hintText: '비밀번호를 입력하세요.',
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                      onPressed: state is UserModelLoading
                      ? null
                      : ()  async {
                        if(_idFormKey.currentState!.validate() && _psFormKey.currentState!.validate()){
                          await ref.read(userMeProvider.notifier)
                              .login(username: username,password: password,context: context);
                        }
                      },
                      child: Text('로그인'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.brown.shade400)
                      ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        context.goNamed(JoinScreen.routeName);
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
