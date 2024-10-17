import 'package:flutter/material.dart';

class TrendingRecipesScreen extends StatelessWidget {
  const TrendingRecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trending Recipes'),
      ),
      body: Center(
        child: Text('Here are the trending recipes.'),
      ),
    );
  }
}
