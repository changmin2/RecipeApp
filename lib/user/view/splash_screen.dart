import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/common/const/colors.dart';

import '../../common/layout/default_layout.dart';

class SplashScreen extends ConsumerWidget {
  static String get routeName => 'splash';


  @override
  Widget build(BuildContext context,WidgetRef) {

    return Image.asset(
                  'asset/img/logo/splashV3.png',
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                );
  }
}
