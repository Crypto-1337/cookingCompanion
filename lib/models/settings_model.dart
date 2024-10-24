import 'package:hive/hive.dart';

part 'settings_model.g.dart';

@HiveType(typeId: 4)
class SettingsModel extends HiveObject {
  @HiveField(0)
  bool darkMode;

  @HiveField(1)
  bool mealReminders;

  @HiveField(2)
  bool newRecipeSuggestions;

  @HiveField(3)
  bool confirmBeforeDelete;

  @HiveField(4)
  String language;

  @HiveField(5)
  String measurementUnit;

  SettingsModel({
    required this.darkMode,
    required this.mealReminders,
    required this.newRecipeSuggestions,
    required this.confirmBeforeDelete,
    required this.language,
    required this.measurementUnit,
  });
}
