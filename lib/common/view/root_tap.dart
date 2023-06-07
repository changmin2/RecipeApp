import 'package:flutter/material.dart';

class RootTab extends StatelessWidget {
  static String get routeName => 'home';
  const RootTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      child: Center(
        child: Text('RootTab',
        style: TextStyle(
          color: Colors.white
        ),),
      ),
    );
  }
}
