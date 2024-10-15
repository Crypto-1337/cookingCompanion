import 'package:cooking_compantion/models/grocery_list_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

// Import the different screens
import 'screens/home_screen.dart';
import 'screens/grocery_list_screen.dart';
import 'screens/recipe_suggestions_screen.dart';
import 'screens/meal_planner_screen.dart';
import 'screens/settings_screen.dart';

void main() async {
  // Ensure Flutter is initialized before running any async operations
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive with Flutter support
  Hive.init("Hive_db");

  // Register the GroceryListModel adapter
  Hive.registerAdapter(GroceryListModelAdapter());

  // Open a box for grocery list items (or any other data)
  await Hive.openBox<GroceryListModel>('groceryListBox');

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
        '/recipe-suggestions': (context) => RecipeSuggestionsScreen(),
        '/meal-planner': (context) => MealPlannerScreen(),
        '/settings': (context) => SettingsScreen(),
      },
    );
  }
}
