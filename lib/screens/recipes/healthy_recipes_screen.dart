import 'package:flutter/material.dart';

class HealthyRecipesScreen extends StatelessWidget {
  const HealthyRecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Healthy Recipes'),
      ),
      body: Center(
        child: Text('Here you can find healthy recipes.'),
      ),
    );
  }
}
