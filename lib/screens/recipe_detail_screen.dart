import 'package:flutter/material.dart';
import '../services/interface.dart';

class RecipeDetailScreen extends StatelessWidget {
  final int recipeId;

  RecipeDetailScreen({required this.recipeId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe Details'),
      ),
      body: FutureBuilder(
        future: SpoonacularService().fetchRecipeDetails(recipeId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final recipe = snapshot.data;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Füge Rezeptbild hinzu
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      recipe?['image'] ?? '',
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    recipe?['title'],
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Ready in ${recipe?['readyInMinutes']} minutes | Servings: ${recipe?['servings']}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Ingredients',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  for (var ingredient in recipe?['extendedIngredients'])
                    Text('- ${ingredient['original']}'),
                  SizedBox(height: 20),
                  Text(
                    'Instructions',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(recipe?['instructions'] ?? 'No instructions available'),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
