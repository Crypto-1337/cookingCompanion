import 'package:flutter/material.dart';

class RecipesByIngredientsScreen extends StatelessWidget {
  const RecipesByIngredientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find Recipes by Ingredients'),
      ),
      body: Center(
        child: Text('Here you can find recipes by ingredients.'),
      ),
    );
  }
}
