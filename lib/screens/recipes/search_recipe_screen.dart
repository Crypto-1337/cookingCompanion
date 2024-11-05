import 'package:flutter/material.dart';
import 'package:cooking_compantion/services/interface.dart';
import 'package:cooking_compantion/screens/recipe_detail_screen.dart';

class SearchRecipeScreen extends StatefulWidget {
  const SearchRecipeScreen({super.key});

  @override
  _SearchRecipeScreenState createState() => _SearchRecipeScreenState();
}

class _SearchRecipeScreenState extends State<SearchRecipeScreen> {
  final _searchController = TextEditingController();
  List<dynamic>? _recipes;
  List<dynamic>? _autocompleteSuggestions;
  bool _isLoading = false;
  String? _errorMessage;

  // Function to search for recipes based on the query
  Future<void> _searchRecipes(String query) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _autocompleteSuggestions = null; // Clear autocomplete suggestions
    });

    try {
      final recipes = await SpoonacularService().searchRecipes(query);
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

  // Function to get autocomplete suggestions
  Future<void> _getAutocompleteSuggestions(String query) async {
    if (query.isEmpty) {
      setState(() {
        _autocompleteSuggestions = [];
      });
      return;
    }

    try {
      final suggestions = await SpoonacularService().getAutocompleteSuggestions(query);
      setState(() {
        _autocompleteSuggestions = suggestions;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Error fetching suggestions: ${e.toString()}';
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Recipes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Text field to input the search query
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Enter recipe name',
                border: OutlineInputBorder(),
              ),
              onChanged: _getAutocompleteSuggestions,
              onSubmitted: (query) {
                _searchRecipes(query); // Call search on enter
                _autocompleteSuggestions = null; // Clear suggestions
              },
            ),
            const SizedBox(height: 16),

            // Show loading indicator or error message
            if (_isLoading) const CircularProgressIndicator(),
            if (_errorMessage != null) Text(_errorMessage!, style: const TextStyle(color: Colors.red)),

            // Show autocomplete suggestions
            if (_autocompleteSuggestions != null && _autocompleteSuggestions!.isNotEmpty) ...[
              const SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  itemCount: _autocompleteSuggestions!.length,
                  itemBuilder: (context, index) {
                    final suggestion = _autocompleteSuggestions![index];
                    return ListTile(
                      title: Text(suggestion['title']),
                      onTap: () {
                        _searchController.text = suggestion['title'];
                        _searchRecipes(suggestion['title']);
                      },
                    );
                  },
                ),
              ),
            ],

            // Display list of found recipes
            if (_recipes != null) Expanded(
              child: ListView.builder(
                itemCount: _recipes!.length,
                itemBuilder: (context, index) {
                  final recipe = _recipes![index];

                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    color: Colors.deepPurple[10],
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0), // Increase padding
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          recipe['image'] ?? '',
                          height: 100, // Increase height of image
                          width: 100, // Increase width of image
                          fit: BoxFit.cover, // Maintain aspect ratio and fill space
                        ),
                      ),
                      title: Text(
                        recipe['title'],
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18), // Increase font size
                      ),
                      subtitle: const SizedBox.shrink(), // Add space for subtitle
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
