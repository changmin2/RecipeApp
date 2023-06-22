import 'package:flutter/material.dart';

class SearchRecipe extends StatelessWidget {
  static get routeName => 'searchRecipe';
  final String search;
  const SearchRecipe({
    required this.search,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        search
      ),
    );
  }
}
