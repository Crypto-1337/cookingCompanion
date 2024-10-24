// Import the needed packages
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

// Import the models
import 'package:cooking_compantion/models/grocery_list_model.dart';
import 'package:cooking_compantion/models/meal_plan_model.dart';
import 'package:cooking_compantion/models/recipe_model.dart';
import 'package:cooking_compantion/models/settings_model.dart';

// Import the different screens
import 'screens/home_screen.dart';
import 'screens/grocery_list_screen.dart';
import 'screens/recipe_screen.dart';
import 'screens/meal_planner_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/recipes/healthy_recipes_screen.dart';
import 'screens/recipes/random_recipes_screen.dart';
import 'screens/recipes/recipes_by_ingredients_screen.dart';
import 'screens/recipes/saved_recipes_screen.dart';
import 'screens/recipes/search_recipe_screen.dart';
import 'screens/recipes/trending_recipes_screen.dart';
import 'screens/recipes/upload_image_screen.dart';

void main() async {
  // Ensure Flutter is initialized before running any async operations
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive with Flutter support
  Hive.init("Hive_db");

  Hive.registerAdapter(GroceryListModelAdapter());

  await Hive.openBox<GroceryListModel>('groceryListBox');

  Hive.registerAdapter(MealPlanModelAdapter());

  await Hive.openBox<MealPlanModel>('mealPlanBox');

  Hive.registerAdapter(RecipeModelAdapter());

  await Hive.openBox<RecipeModel>('recipeBox');

  Hive.registerAdapter(SettingsModelAdapter());

  await Hive.openBox<SettingsModel>('settingsBox');

  // Run the app
  runApp(CookingCompanionApp());
}

class CookingCompanionApp extends StatelessWidget {
  const CookingCompanionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cooking Companion App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        brightness: Brightness.dark, // for the dark mode
      ),
      initialRoute: '/',
        routes: {
          '/': (context) => HomeScreen(),
          '/grocery-list': (context) => GroceryListScreen(),
          '/settings': (context) => SettingsScreen(),
          '/meal-planner': (context) => MealPlannerScreen(),
          '/recipe-suggestions': (context) => RecipeScreen(), // Hier deine Rezept-Hauptseite
          '/recipes-by-ingredients': (context) => RecipesByIngredientsScreen(),
          '/search-recipe': (context) => SearchRecipeScreen(),
          '/upload-image': (context) => UploadImageScreen(),
          '/saved-recipes': (context) => SavedRecipesScreen(),
          '/random-recipes': (context) => RandomRecipesScreen(),
          '/healthy-recipes': (context) => HealthyRecipesScreen(),
          '/trending-recipes': (context) => TrendingRecipesScreen(),
        },
    );
  }
}
