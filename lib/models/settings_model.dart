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

  @HiveField(6)
  String apiKey;

  SettingsModel({
    this.darkMode = true,
    this.mealReminders = false,
    this.newRecipeSuggestions = false,
    this.confirmBeforeDelete = false,
    this.language = 'English',
    this.measurementUnit = 'Imperial',
    this.apiKey = '',
  });
}
