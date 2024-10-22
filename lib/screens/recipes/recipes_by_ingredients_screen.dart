import 'package:flutter/material.dart';
import '../../services/interface.dart';
import '../recipe_detail_screen.dart';

class RecipesByIngredientsScreen extends StatefulWidget {
  const RecipesByIngredientsScreen({super.key});

  @override
  _RecipesByIngredientsScreenState createState() => _RecipesByIngredientsScreenState();
}

class _RecipesByIngredientsScreenState extends State<RecipesByIngredientsScreen> {
  final _ingredientController = TextEditingController();
  List<dynamic>? _recipes;
  bool _isLoading = false;
  String? _errorMessage;

  // Function to search for recipes based on ingredients
  Future<void> _searchRecipesByIngredients() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final ingredients = _ingredientController.text.split(',');
      final recipes = await SpoonacularService().findRecipesByIngredients(ingredients);

      setState(() {
        _recipes = recipes;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Error fetching recipes: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _ingredientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Recipes by Ingredients'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Text field to input ingredients
            TextField(
              controller: _ingredientController,
              decoration: InputDecoration(
                labelText: 'Enter ingredients (comma separated)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Button to search for recipes
            ElevatedButton(
              onPressed: _searchRecipesByIngredients,
              child: const Text('Search Recipes'),
            ),

            const SizedBox(height: 16),

            // Show loading indicator or recipes
            if (_isLoading) CircularProgressIndicator(),
            if (_errorMessage != null) Text(_errorMessage!, style: TextStyle(color: Colors.red)),

            // Display list of found recipes
            if (_recipes != null) Expanded(
              child: ListView.builder(
                itemCount: _recipes!.length,
                itemBuilder: (context, index) {
                  final recipe = _recipes![index];
                  final usedIngredients = recipe['usedIngredients'] as List<dynamic>;
                  final missedIngredients = recipe['missedIngredients'] as List<dynamic>;

                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    color: Colors.deepPurple[10],
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          recipe['image'] ?? '', // Recipe image
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        recipe['title'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8.0),
                          Text(
                            'Used ingredients: ${usedIngredients.length}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Wrap(
                            children: usedIngredients.map((ingredient) {
                              return Container(
                                margin: const EdgeInsets.all(4.0), // Abstand zwischen den Chips
                                child: Chip(
                                  label: Text(
                                    ingredient['name'],
                                    style: TextStyle(color: Colors.black), // Schriftfarbe anpassen
                                  ),
                                  backgroundColor: Colors.green,
                                  side: BorderSide(color: Colors.green, width: 0), // Border entfernen oder anpassen
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            'Missing ingredients: ${missedIngredients.length}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Wrap(
                            children: missedIngredients.map((ingredient) {
                              return Container(
                                margin: const EdgeInsets.all(4.0), // Abstand zwischen den Chips
                                child: Chip(
                                  label: Text(
                                    ingredient['name'],
                                    style: TextStyle(color: Colors.black), // Schriftfarbe anpassen
                                  ),
                                  backgroundColor: Colors.red,
                                  side: BorderSide(color: Colors.red, width: 0), // Border entfernen oder anpassen
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.deepPurple),
                      onTap: () {
                        // Navigate to recipe detail screen
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
