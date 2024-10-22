import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cooking_compantion/services/interface.dart'; // Importiere deine SpoonacularService-Klasse
import 'package:cooking_compantion/screens/recipe_detail_screen.dart'; // Importiere die Rezeptdetailseite

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({super.key});

  @override
  _UploadImageScreenState createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;
  Map<String, dynamic>? _analysisResult; // Um das Analyseergebnis zu speichern

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _analysisResult = null; // Setze das Ergebnis zurück, wenn ein neues Bild ausgewählt wird
      });
    }
  }

  Future<void> _analyzeImage() async {
    if (_image == null) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Analysiere das Bild und speichere das Ergebnis
      var result = await SpoonacularService().analyzeRecipeImage(_image!.path);
      setState(() {
        _analysisResult = result; // Speichere das Ergebnis als Map
      });
    } catch (e) {
      // Fehlerbehandlung
      setState(() {
        _analysisResult = {'error': 'Error analyzing image: $e'};
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload & Analyze Image'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Bildvorschau
            _image == null
                ? Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(child: Text('No Image Selected')),
            )
                : ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.file(
                _image!,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),

            // Button zum Bild auswählen
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Select Image from Gallery'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Button zum Analysieren des Bildes
            ElevatedButton(
              onPressed: _isLoading ? null : _analyzeImage,
              child: _isLoading
                  ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
                  : const Text('Analyze Image'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Anzeige des Analyseergebnisses
            if (_analysisResult != null) ...[
              const SizedBox(height: 16),
              Text(
                'Analysis Result:',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              _analysisResult!.containsKey('error')
                  ? Text(
                _analysisResult!['error'],
                style: const TextStyle(color: Colors.red),
              )
                  : Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Kategorie
                      Text(
                        'Category: ${_analysisResult!['category']['name']}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Probability: ${(100 * _analysisResult!['category']['probability']).toStringAsFixed(2)}%',
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 16),

                      // Nährwertangaben
                      const Text(
                        'Nutrition:',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      _buildNutritionInfo('Calories', _analysisResult!['nutrition']['calories']),
                      _buildNutritionInfo('Fat', _analysisResult!['nutrition']['fat']),
                      _buildNutritionInfo('Protein', _analysisResult!['nutrition']['protein']),
                      _buildNutritionInfo('Carbs', _analysisResult!['nutrition']['carbs']),
                      const SizedBox(height: 16),

                      // Rezepte
                      const Text(
                        'Suggested Recipes:',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      ..._buildRecipeList(_analysisResult!['recipes']),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // Hilfsmethode zum Erstellen der Nährwertanzeige
  Widget _buildNutritionInfo(String label, Map<String, dynamic> info) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        '$label: ${info['value']} ${info['unit']}',
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  // Hilfsmethode zum Erstellen der Rezeptliste
  List<Widget> _buildRecipeList(List<dynamic> recipes) {
    return recipes.map<Widget>((recipe) {
      return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: ListTile(
          contentPadding: const EdgeInsets.all(10.0),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              'https://spoonacular.com/recipeImages/${recipe['id']}-90x90.${recipe['imageType']}',
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(
            recipe['title'],
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: const Text('Tap for details'),
          trailing: const Icon(Icons.arrow_forward_ios, color: Colors.deepPurple),
          onTap: () {
            // Navigiere zur Rezeptdetailseite
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => RecipeDetailScreen(
                  recipeId: recipe['id'],
                ),
              ),
            );
          },
        ),
      );
    }).toList();
  }
}
