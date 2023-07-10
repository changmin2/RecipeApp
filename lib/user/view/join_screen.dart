import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/common/layout/default_layout.dart';
import 'package:recipe_app/user/model/duplicate_request.dart';
import 'package:recipe_app/user/model/join_request.dart';
import 'package:recipe_app/user/repository/user_me_repository.dart';

import '../../common/component/custom_text_form_field.dart';
import '../provider/user_me_provider.dart';

class JoinScreen extends ConsumerStatefulWidget {
  static String get routeName => 'join';
  const JoinScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<JoinScreen> createState() => _JoinScreenState();
}

class _JoinScreenState extends ConsumerState<JoinScreen> {
  String username= '';
  String password= '';
  bool dulicateCheck = false;

  @override
  Widget build(BuildContext context) {
    final _idFormKey = GlobalKey<FormState>();
    final _psFormKey = GlobalKey<FormState>();

    return DefaultLayout(
      title: '회원가입',
      isDetail: true,
      child: Center(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: SafeArea(
            top: true,
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '아이디',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          if(_idFormKey.currentState!.validate()){
                            DuplicateRequest du = new DuplicateRequest(email: username);
                            dulicateCheck = await ref.read(userMeRepositoryProvider).duplicate(du);
                            if(!dulicateCheck){
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('중복된 아이디입니다!'),
                                    duration: Duration(seconds: 1),
                                  )
                              );
                            }else{
                              await ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('중복확인 완료'),
                                    duration: Duration(seconds: 1),
                                  )
                              );
                            }
                          }
                        },
                        child: Text('중복확인'),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.brown.shade400)
                        ),
                    )
                  ],
                ),
                Container(
                  child: Form(
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
                        dulicateCheck = false;
                        username= value;
                      },
                      hintText: '3~15자 영문/숫자 조합으로 입력',
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Text(
                      '비밀번호',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700
                      ),
                    )
                  ],
                ),
                Form(
                  key: _psFormKey,
                  child: CustomTextFormField(
                    obscureText: true,
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
                    onChanged: (String value){
                      password = value;
                    },
                    hintText: '3~15자 영문/숫자 조합으로 입력',
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    if(!dulicateCheck){
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('아이디 중복확인을 하세요!'),
                            duration: Duration(seconds: 3),
                          )
                      );
                    }
                    if(_idFormKey.currentState!.validate() && _psFormKey.currentState!.validate()&&dulicateCheck){
                      JoinRequest request = new JoinRequest(memberId: username, password: password);
                      await ref.read(userMeRepositoryProvider).join(request);
                      await ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('회원가입 완료'),
                            duration: Duration(seconds: 1),
                          )
                      );
                      await Future.delayed(const Duration(milliseconds: 1000), () {
                        print('Hello, world');
                      });
                      Navigator.pop(context);
                    }
                  },
                  child: Text('가입'),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.brown.shade400)
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}

bool isValidEmailFormat(String word) {
  return RegExp(
      r"^(?=.*[a-zA-Z])(?=.*[0-9])")
      .hasMatch(word);
}
