import "package:flutter/material.dart";
import "../const/colors.dart";

class CustomTextFormField extends StatelessWidget {

  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final bool autofocus;
  final ValueChanged<String> onChanged;

  const CustomTextFormField({
    required this.onChanged,
    this.autofocus = false,
    this.obscureText = false,
    this.hintText,
    this.errorText,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final baseBorder = OutlineInputBorder(
        borderSide: BorderSide(
          color: INPUT_BORDER_COLOR,
          width: 1.0,
        )
    );

    return TextFormField(
      cursorColor: PRIMARY_COLOR,
      //비밀번호 입력할때만 거의 사용
      obscureText: obscureText,
      //위젯을 로드했을 때 자동으로 선택될지
      autofocus: autofocus,
      onChanged: onChanged,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(20),
          hintText: hintText,
          errorText: errorText,
          hintStyle: TextStyle(
              color: BODY_TEXT_COLOR,
              fontSize: 14
          ),
          fillColor: INPUT_BG_COLOR,
          filled: true,
          border: baseBorder,
          enabledBorder: baseBorder.copyWith(),
          focusedBorder: baseBorder.copyWith(
              borderSide: baseBorder.borderSide.copyWith(
                  color: PRIMARY_COLOR
              )
          )
      ),
    );
  }
}
