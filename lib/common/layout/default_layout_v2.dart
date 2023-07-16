import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/recipe/provider/comment_provider.dart';

class DefaultLayoutV2 extends ConsumerWidget {
  final Color? backgroundColor;
  final Widget child;
  final AppBar? appBar;
  final FloatingActionButton? floatingActionButton;

  const DefaultLayoutV2({
    this.appBar =null,
    this.backgroundColor,
    required this.child,
    this.floatingActionButton=null,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      appBar: appBar==null ? null
      : appBar,
      body: child,
      backgroundColor: backgroundColor ?? Colors.white,
      floatingActionButton: floatingActionButton,
    );
  }
}
