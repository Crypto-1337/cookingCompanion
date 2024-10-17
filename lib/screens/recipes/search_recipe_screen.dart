import 'package:flutter/material.dart';

class SearchRecipeScreen extends StatelessWidget {
  const SearchRecipeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Recipes'),
      ),
      body: Center(
        child: Text('Here you can search for recipes.'),
      ),
    );
  }
}
