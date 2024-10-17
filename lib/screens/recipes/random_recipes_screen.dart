import 'package:flutter/material.dart';

class RandomRecipesScreen extends StatelessWidget {
  const RandomRecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random Recipe Suggestions'),
      ),
      body: Center(
        child: Text('Here are some random recipe suggestions.'),
      ),
    );
  }
}
