// Import the needed packages
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

// Import the models
import 'package:cooking_compantion/models/grocery_list_model.dart';
import 'package:cooking_compantion/models/meal_plan_model.dart';
import 'package:cooking_compantion/models/recipe_model.dart';
import 'package:cooking_compantion/models/settings_model.dart';

// Import the different screens
import 'package:cooking_compantion/screens/home_screen.dart';
import 'package:cooking_compantion/screens/grocery_list_screen.dart';
import 'package:cooking_compantion/screens/recipe_screen.dart';
import 'package:cooking_compantion/screens/meal_planner_screen.dart';
import 'package:cooking_compantion/screens/settings_screen.dart';
import 'package:cooking_compantion/screens/recipes/healthy_recipes_screen.dart';
import 'package:cooking_compantion/screens/recipes/random_recipes_screen.dart';
import 'package:cooking_compantion/screens/recipes/recipes_by_ingredients_screen.dart';
import 'package:cooking_compantion/screens/recipes/saved_recipes_screen.dart';
import 'package:cooking_compantion/screens/recipes/search_recipe_screen.dart';
import 'package:cooking_compantion/screens/recipes/trending_recipes_screen.dart';
import 'package:cooking_compantion/screens/recipes/upload_image_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive with Flutter support
  try {
    final directory = await getApplicationDocumentsDirectory();
    Hive.init("${directory.path}/Hive_db");
  } catch(e) {
    Hive.init("Hive_db");
  }

  // Register adapters
  Hive.registerAdapter(GroceryListModelAdapter());
  await Hive.openBox<GroceryListModel>('groceryListBox');

  Hive.registerAdapter(MealPlanModelAdapter());
  await Hive.openBox<MealPlanModel>('mealPlanBox');

  Hive.registerAdapter(RecipeModelAdapter());
  await Hive.openBox<RecipeModel>('recipeBox');

  Hive.registerAdapter(SettingsModelAdapter());
  await Hive.openBox<SettingsModel>('settingsBox');

  // Fetch settings from the Hive box or create a new instance with default values
  var settingsBox = Hive.box<SettingsModel>('settingsBox');
  SettingsModel settings = settingsBox.get('settings') ?? SettingsModel();

  // Run the app
  runApp(CookingCompanionApp(settings: settings));
}


class CookingCompanionApp extends StatefulWidget {
  const CookingCompanionApp({super.key, required this.settings});

  final SettingsModel settings;

  // Method to access the state
  static _CookingCompanionAppState of(BuildContext context) {
    return context.findAncestorStateOfType<_CookingCompanionAppState>()!;
  }

  @override
  _CookingCompanionAppState createState() => _CookingCompanionAppState();
}

class _CookingCompanionAppState extends State<CookingCompanionApp> {
  late ThemeData _themeData;

  @override
  void initState() {
    super.initState();
    _themeData = widget.settings.darkMode ? ThemeData.dark() : ThemeData.light();
  }

  // Method to change the theme
  void setThemeData(ThemeData theme) {
    setState(() {
      _themeData = theme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cooking Companion App',
      theme: _themeData,
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/grocery-list': (context) => GroceryListScreen(),
        '/settings': (context) => SettingsScreen(),
        '/meal-planner': (context) => MealPlannerScreen(),
        '/recipe-suggestions': (context) => RecipeScreen(),
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
