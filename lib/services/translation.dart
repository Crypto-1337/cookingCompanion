import 'dart:convert';
import 'package:http/http.dart' as http;

class TranslationService {
  final String apiUrl = 'https://translate.kreativesvombodensee.de/translate';

  Future<String> translate(String text, String sourceLang, String targetLang) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'q': text,
        'source': sourceLang,
        'target': targetLang,
        'format': 'text',
      }),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return responseData['translatedText'] ?? text; // Falls keine Übersetzung zurückkommt, den Originaltext zurückgeben
    } else {
      throw Exception('Failed to translate');
    }
  }
}
