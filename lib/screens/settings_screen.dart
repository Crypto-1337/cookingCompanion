import 'package:flutter/material.dart';
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
    _settingsFuture = _settingsService.getSettings(); // Hol die Einstellungen beim Start
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

          final settings = snapshot.data!; // Entpacke die SettingsModel

          return SettingsList(
            sections: [
              // Allgemein
              SettingsSection(
                title: const Text('General'),
                tiles: [
                  SettingsTile.navigation(
                    leading: const Icon(Icons.language),
                    title: const Text('Language'),
                    value: Text(settings.language), // Aktuelle Sprache anzeigen
                    onPressed: (context) {
                      _showLanguageDialog(context, settings);
                    },
                  ),
                  SettingsTile.navigation(
                    leading: const Icon(Icons.straighten),
                    title: const Text('Measurement Units'),
                    value: Text(settings.measurementUnit), // Aktuelle Einheit anzeigen
                    onPressed: (context) {
                      _showUnitsDialog(context, settings);
                    },
                  ),
                  SettingsTile.switchTile(
                    onToggle: (value) async {
                      settings.darkMode = value; // Lokale Einstellungen aktualisieren
                      await _settingsService.saveSettings(settings); // Aktualisierte Einstellungen speichern
                      setState(() {}); // UI aktualisieren
                    },
                    initialValue: settings.darkMode,
                    leading: const Icon(Icons.dark_mode),
                    title: const Text('Dark Mode'),
                  ),
                ],
              ),
              // Benachrichtigungen
              SettingsSection(
                title: const Text('Notifications'),
                tiles: [
                  SettingsTile.switchTile(
                    onToggle: (value) async {
                      settings.mealReminders = value; // Lokale Einstellungen aktualisieren
                      await _settingsService.saveSettings(settings); // Aktualisierte Einstellungen speichern
                      setState(() {}); // UI aktualisieren
                    },
                    initialValue: settings.mealReminders,
                    leading: const Icon(Icons.notifications),
                    title: const Text('Meal Reminders'),
                  ),
                  SettingsTile.switchTile(
                    onToggle: (value) async {
                      settings.newRecipeSuggestions = value; // Lokale Einstellungen aktualisieren
                      await _settingsService.saveSettings(settings); // Aktualisierte Einstellungen speichern
                      setState(() {}); // UI aktualisieren
                    },
                    initialValue: settings.newRecipeSuggestions,
                    leading: const Icon(Icons.new_releases),
                    title: const Text('New Recipe Suggestions'),
                  ),
                ],
              ),
              // Einkaufsliste
              SettingsSection(
                title: const Text('Shopping List'),
                tiles: [
                  SettingsTile.switchTile(
                    onToggle: (value) async {
                      settings.confirmBeforeDelete = value; // Lokale Einstellungen aktualisieren
                      await _settingsService.saveSettings(settings); // Aktualisierte Einstellungen speichern
                      setState(() {}); // UI aktualisieren
                    },
                    initialValue: settings.confirmBeforeDelete,
                    leading: const Icon(Icons.delete),
                    title: const Text('Confirm Before Deleting Items'),
                  ),
                ],
              ),
              // Datenschutz
              SettingsSection(
                title: const Text('Privacy'),
                tiles: [
                  SettingsTile.navigation(
                    leading: const Icon(Icons.privacy_tip),
                    title: const Text('Privacy Policy'),
                    onPressed: (context) {
                      // Datenschutzerklärung anzeigen
                    },
                  ),
                  SettingsTile.navigation(
                    leading: const Icon(Icons.feedback),
                    title: const Text('Send Feedback'),
                    onPressed: (context) {
                      // Feedbackformular öffnen
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

  // Dialog für die Sprachauswahl
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
                  groupValue: settings.language, // Aktuelle Sprache
                  onChanged: (value) {
                    settings.language = value.toString(); // Sprache ändern
                    _settingsService.saveSettings(settings); // Aktualisierte Einstellungen speichern
                    Navigator.of(context).pop();
                    setState(() {}); // UI aktualisieren
                  },
                ),
                RadioListTile(
                  title: const Text('German'),
                  value: 'German',
                  groupValue: settings.language,
                  onChanged: (value) {
                    settings.language = value.toString(); // Sprache ändern
                    _settingsService.saveSettings(settings); // Aktualisierte Einstellungen speichern
                    Navigator.of(context).pop();
                    setState(() {}); // UI aktualisieren
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Dialog für die Einheiten-Auswahl
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
                  groupValue: settings.measurementUnit, // Standardwert
                  onChanged: (value) {
                    settings.measurementUnit = value.toString(); // Einheiten ändern
                    _settingsService.saveSettings(settings); // Aktualisierte Einstellungen speichern
                    Navigator.of(context).pop();
                    setState(() {}); // UI aktualisieren
                  },
                ),
                RadioListTile(
                  title: const Text('Imperial (oz, lb)'),
                  value: 'Imperial',
                  groupValue: settings.measurementUnit,
                  onChanged: (value) {
                    settings.measurementUnit = value.toString(); // Einheiten ändern
                    _settingsService.saveSettings(settings); // Aktualisierte Einstellungen speichern
                    Navigator.of(context).pop();
                    setState(() {}); // UI aktualisieren
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
