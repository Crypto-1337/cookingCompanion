import 'package:flutter/material.dart';
import 'package:cooking_compantion/services/translation.dart'; // Dein TranslationService

class TranslatableText extends StatelessWidget {
  final String text;
  final String from;
  final String to;

  TranslatableText(this.text, {this.from = 'en', this.to = 'de'});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: TranslationService().translate(text, from, to),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Text(snapshot.data ?? 'Translation failed');
        }
      },
    );
  }
}

