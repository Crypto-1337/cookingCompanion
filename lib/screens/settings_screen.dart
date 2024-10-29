import 'package:cooking_compantion/main.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:cooking_compantion/services/service.dart'; // Stelle sicher, dass dieser Pfad korrekt ist
import 'package:cooking_compantion/models/settings_model.dart'; // Importiere dein SettingsModel

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final SettingsService _settingsService = SettingsService();
  late Future<SettingsModel> _settingsFuture;

  @override
  void initState() {
    super.initState();
    _settingsFuture = _settingsService.getSettings(); // Einstellungen beim Start laden
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: FutureBuilder<SettingsModel>(
        future: _settingsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final settings = snapshot.data!;

          return SettingsList(
            sections: [
              // API Section
              SettingsSection(
                title: const Text('API'),
                tiles: [
                  SettingsTile.navigation(
                    leading: const Icon(Icons.sync_alt),
                    title: const Text("API Key"),
                    value: Text(settings.apiKey),
                    onPressed: (context) {
                      _showApiDialog(context, settings);
                    },
                  ),
                ],
              ),
              // General Settings
              SettingsSection(
                title: const Text('General'),
                tiles: [
                  SettingsTile.navigation(
                    leading: const Icon(Icons.language),
                    title: const Text('Language'),
                    value: Text(settings.language),
                    onPressed: (context) {
                      _showLanguageDialog(context, settings);
                    },
                  ),
                  SettingsTile.navigation(
                    leading: const Icon(Icons.straighten),
                    title: const Text('Measurement Units'),
                    value: Text(settings.measurementUnit),
                    onPressed: (context) {
                      _showUnitsDialog(context, settings);
                    },
                  ),
                  SettingsTile.switchTile(
                    onToggle: (value) async {
                      settings.darkMode = value;
                      await _settingsService.saveSettings(settings);
                      setState(() {});
                      if (value) {
                        CookingCompanionApp.of(context).setThemeData(ThemeData.dark());
                      } else {
                        CookingCompanionApp.of(context).setThemeData(ThemeData.light());
                      }
                    },
                    initialValue: settings.darkMode,
                    leading: const Icon(Icons.dark_mode),
                    title: const Text('Dark Mode'),
                  ),
                ],
              ),
              // Notification Settings
              SettingsSection(
                title: const Text('Notifications'),
                tiles: [
                  SettingsTile.switchTile(
                    onToggle: (value) async {
                      settings.mealReminders = value;
                      await _settingsService.saveSettings(settings);
                      setState(() {});
                    },
                    initialValue: settings.mealReminders,
                    leading: const Icon(Icons.notifications),
                    title: const Text('Meal Reminders'),
                  ),
                  SettingsTile.switchTile(
                    onToggle: (value) async {
                      settings.newRecipeSuggestions = value;
                      await _settingsService.saveSettings(settings);
                      setState(() {});
                    },
                    initialValue: settings.newRecipeSuggestions,
                    leading: const Icon(Icons.new_releases),
                    title: const Text('New Recipe Suggestions'),
                  ),
                ],
              ),
              // Shopping List Settings
              SettingsSection(
                title: const Text('Shopping List'),
                tiles: [
                  SettingsTile.switchTile(
                    onToggle: (value) async {
                      settings.confirmBeforeDelete = value;
                      await _settingsService.saveSettings(settings);
                      setState(() {});
                    },
                    initialValue: settings.confirmBeforeDelete,
                    leading: const Icon(Icons.delete),
                    title: const Text('Confirm Before Deleting Items'),
                  ),
                ],
              ),
              // Privacy Section
              SettingsSection(
                title: const Text('Privacy'),
                tiles: [
                  SettingsTile.navigation(
                    leading: const Icon(Icons.privacy_tip),
                    title: const Text('Privacy Policy'),
                    onPressed: (context) {
                      // Anzeige der Datenschutzerklärung
                    },
                  ),
                  SettingsTile.navigation(
                    leading: const Icon(Icons.feedback),
                    title: const Text('Send Feedback'),
                    onPressed: (context) {
                      // Öffnen des Feedbackformulars
                    },
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  // Dialog für die Spracheinstellungen
  void _showLanguageDialog(BuildContext context, SettingsModel settings) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Language'),
          content: SizedBox(
            height: 150,
            child: Column(
              children: [
                RadioListTile(
                  title: const Text('English'),
                  value: 'English',
                  groupValue: settings.language,
                  onChanged: (value) {
                    settings.language = value.toString();
                    _settingsService.saveSettings(settings);
                    Navigator.of(context).pop();
                    setState(() {});
                  },
                ),
                RadioListTile(
                  title: const Text('German'),
                  value: 'German',
                  groupValue: settings.language,
                  onChanged: (value) {
                    settings.language = value.toString();
                    _settingsService.saveSettings(settings);
                    Navigator.of(context).pop();
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Dialog für die Einheitseinstellungen
  void _showUnitsDialog(BuildContext context, SettingsModel settings) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Measurement Units'),
          content: SizedBox(
            height: 120,
            child: Column(
              children: [
                RadioListTile(
                  title: const Text('Metric (g, kg)'),
                  value: 'Metric',
                  groupValue: settings.measurementUnit,
                  onChanged: (value) {
                    settings.measurementUnit = value.toString();
                    _settingsService.saveSettings(settings);
                    Navigator.of(context).pop();
                    setState(() {});
                  },
                ),
                RadioListTile(
                  title: const Text('Imperial (oz, lb)'),
                  value: 'Imperial',
                  groupValue: settings.measurementUnit,
                  onChanged: (value) {
                    settings.measurementUnit = value.toString();
                    _settingsService.saveSettings(settings);
                    Navigator.of(context).pop();
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Dialog für die Eingabe des API-Schlüssels
  void _showApiDialog(BuildContext context, SettingsModel settings) {
    final TextEditingController _controller = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('API-Schlüssel eingeben'),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(hintText: 'API-Schlüssel'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Abbrechen'),
            ),
            TextButton(
              onPressed: () async {
                settings.apiKey = _controller.text;
                final settingsBox = Hive.box<SettingsModel>('settingsBox');
                await settingsBox.put('settings', settings);
                Navigator.of(context).pop();
                setState(() {});
              },
              child: Text('Speichern'),
            ),
          ],
        );
      },
    );
  }
}
