import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final Color? backgroundColor;
  final Widget child;
  final String? title;
  final Widget? bottomNavagtionBar;

  const DefaultLayout({
    required this.child,
    this.backgroundColor,
    this.title,
    this.bottomNavagtionBar,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderAppBar(),
      //??는 왼쪽 값이 null 이면 ?? 뒤에 값 적용
      backgroundColor: backgroundColor ?? Colors.white,
      body: child,

    );
  }
  AppBar? renderAppBar(){
    if(title !=null){
      return AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Center(
          child: Text(
            title!,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.black
            ),
          ),
        ),
      );
    }
    return null;
  }
}
