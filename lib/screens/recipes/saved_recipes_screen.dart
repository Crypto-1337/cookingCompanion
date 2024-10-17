import 'package:flutter/material.dart';

class SavedRecipesScreen extends StatelessWidget {
  const SavedRecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Recipes'),
      ),
      body: Center(
        child: Text('Here are your saved recipes.'),
      ),
    );
  }
}
