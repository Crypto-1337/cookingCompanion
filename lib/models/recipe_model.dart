import 'package:hive/hive.dart';

part 'recipe_model.g.dart';

@HiveType(typeId: 3)
class RecipeModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String instructions;

  @HiveField(3)
  final List<String> ingredients;

  @HiveField(4)
  final String imageUrl;

  @HiveField(5)
  final int readyInMinutes;

  @HiveField(6)
  final int servings;

  RecipeModel({
    required this.id,
    required this.title,
    required this.instructions,
    required this.ingredients,
    required this.imageUrl,
    required this.readyInMinutes,
    required this.servings,
  });
}
