import 'package:flutter/material.dart';
import '../../services/interface.dart';
import '../recipe_detail_screen.dart';

class TrendingRecipesScreen extends StatelessWidget {
  const TrendingRecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trendy Recipes'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: SpoonacularService().getTrendyRecipes(5), // Nutze die getTrendyRecipes Methode
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  final recipes = snapshot.data as List;
                  return ListView.builder(
                    itemCount: recipes.length,
                    itemBuilder: (context, index) {
                      final recipe = recipes[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                        color: Colors.deepPurple[10],
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              recipe['image'] ?? '', // Füge Rezeptbild hinzu
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            recipe['title'],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text('Ready in ${recipe['readyInMinutes']} minutes'),
                          trailing: Icon(Icons.arrow_forward_ios, color: Colors.deepPurple),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RecipeDetailScreen(recipeId: recipe['id']),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                }
                return Container();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Logik, um neue Trendy Rezepte zu holen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => TrendingRecipesScreen()),
                );
              },
              child: Text('Get New Trendy Recipes'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple, // Hintergrundfarbe des Buttons
              ),
            ),
          ),
        ],
      ),
    );
  }
}
