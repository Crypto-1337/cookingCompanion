import 'package:flutter/material.dart';

class UploadImageScreen extends StatelessWidget {
  const UploadImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload & Analyze Image'),
      ),
      body: Center(
        child: Text('Here you can upload an image to analyze.'),
      ),
    );
  }
}
