import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import 'package:cooking_compantion/models/settings_model.dart'; // Importiere dein SettingsModel

// Define the interface for the SpoonacularService
abstract class SpoonacularServiceInterface {
  Future<List<dynamic>> getRandomRecipes(int number);
  Future<List<dynamic>> searchRecipes(String query, {List<String>? excludeIngredients, List<String>? intolerances});
  Future<List<dynamic>> findRecipesByIngredients(List<String> ingredients);
  Future<dynamic> analyzeRecipeImage(String imagePath);
  Future<List<dynamic>> getSavedRecipes();
  Future<List<dynamic>> getHealthyRecipes(int number); // Added getHealthyRecipes method
  Future<List<dynamic>> getTrendyRecipes(int number);  // Added getTrendyRecipes method
  Future<List<dynamic>> getAutocompleteSuggestions(String query); // New autocomplete method
}

// Implement the SpoonacularServiceInterface
class SpoonacularService implements SpoonacularServiceInterface {
  final String baseUrl = 'https://api.spoonacular.com';

  // Lese den API-Key aus den Hive-Einstellungen
  String _getApiKey() {
    final settingsBox = Hive.box<SettingsModel>('settingsBox');
    final settings = settingsBox.get('settings');
    return settings?.apiKey ?? ''; // Falls kein Key vorhanden, leer zurückgeben
  }

  // Fetch random recipes
  @override
  Future<List<dynamic>> getRandomRecipes(int number) async {
    final apiKey = _getApiKey(); // API-Key jedes Mal abrufen
    final url = Uri.parse('$baseUrl/recipes/random?apiKey=$apiKey&number=$number');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['recipes'];
    } else {
      throw Exception('Failed to load random recipes');
    }
  }

  // Fetch healthy recipes
  @override
  Future<List<dynamic>> getHealthyRecipes(int number) async {
    final apiKey = _getApiKey(); // API-Key jedes Mal abrufen
    final url = Uri.parse('$baseUrl/recipes/complexSearch?apiKey=$apiKey&number=$number&tags=healthy&addRecipeInformation=true');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results'];
    } else {
      throw Exception('Failed to load healthy recipes');
    }
  }

  // Fetch trendy recipes (e.g., recipes sorted by popularity)
  @override
  Future<List<dynamic>> getTrendyRecipes(int number) async {
    final apiKey = _getApiKey(); // API-Key jedes Mal abrufen
    final url = Uri.parse('$baseUrl/recipes/complexSearch?apiKey=$apiKey&sort=popularity&number=$number&addRecipeInformation=true');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results'];
    } else {
      throw Exception('Failed to load trendy recipes');
    }
  }

  // Search recipes with query, excluded ingredients, and intolerances
  @override
  Future<List<dynamic>> searchRecipes(String query, {List<String>? excludeIngredients, List<String>? intolerances}) async {
    final apiKey = _getApiKey(); // API-Key jedes Mal abrufen
    String exclude = excludeIngredients?.join(',') ?? '';
    String intolerance = intolerances?.join(',') ?? '';

    final url = Uri.parse(
        '$baseUrl/recipes/complexSearch?apiKey=$apiKey&query=$query&excludeIngredients=$exclude&intolerances=$intolerance&addRecipeInformation=true');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results'];
    } else {
      throw Exception('Failed to search recipes');
    }
  }

  // Find recipes by ingredients
  @override
  Future<List<dynamic>> findRecipesByIngredients(List<String> ingredients) async {
    final apiKey = _getApiKey(); // API-Key jedes Mal abrufen
    String ingredientString = ingredients.join(',');
    final url = Uri.parse('$baseUrl/recipes/findByIngredients?apiKey=$apiKey&ingredients=$ingredientString&number=10');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to find recipes by ingredients');
    }
  }

  // Analyze uploaded recipe image
  @override
  Future<dynamic> analyzeRecipeImage(String imagePath) async {
    final apiKey = _getApiKey(); // API-Key jedes Mal abrufen
    final url = Uri.parse('$baseUrl/food/images/analyze?apiKey=$apiKey');
    var request = http.MultipartRequest('POST', url);
    request.files.add(await http.MultipartFile.fromPath('file', imagePath));

    final response = await request.send();
    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();
      return json.decode(responseData);
    } else {
      throw Exception('Failed to analyze recipe image');
    }
  }

  // Get saved recipes (this would be connected to your local storage solution)
  @override
  Future<List<dynamic>> getSavedRecipes() async {
    // Example: You could retrieve this from a local database like Hive
    // For now, let's assume we have a list of saved recipes
    return [];
  }

  // Implement autocomplete suggestions
  @override
  Future<List<dynamic>> getAutocompleteSuggestions(String query) async {
    final apiKey = _getApiKey(); // API-Key jedes Mal abrufen
    final url = Uri.parse('$baseUrl/recipes/autocomplete?apiKey=$apiKey&query=$query');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to load autocomplete suggestions');
    }
  }

  Future<Map<String, dynamic>> fetchRecipeDetails(int recipeId) async {
    final apiKey = _getApiKey(); // API-Key jedes Mal abrufen
    final url = '$baseUrl/recipes/$recipeId/information?apiKey=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load recipe details');
    }
  }
}
