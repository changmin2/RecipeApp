import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DefaultLayoutV2 extends ConsumerWidget {
  final Color? backgroundColor;
  final Widget child;
  final AppBar? appBar;

  const DefaultLayoutV2({
    this.appBar =null,
    this.backgroundColor,
    required this.child,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef reft) {
    return Scaffold(
      appBar: appBar==null ? null
      : appBar,
      body: child,
      backgroundColor: backgroundColor ?? Colors.white,
    );
  }
}
