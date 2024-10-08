import 'package:flutter/material.dart';

// Import the different screens
import 'screens/home_screen.dart';
import 'screens/grocery_list_screen.dart';
import 'screens/recipe_suggestions_screen.dart';
import 'screens/meal_planner_screen.dart';
import 'screens/settings_screen.dart';

void main() {
  runApp(CookingCompanionApp());
}

class CookingCompanionApp extends StatelessWidget {
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
