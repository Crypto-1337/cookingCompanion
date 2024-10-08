import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome to Cooking Companion!'),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/grocery-list');
              },
              child: Text('Go to Grocery List'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/recipe-suggestions');
              },
              child: Text('Go to Recipe Suggestions'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/meal-planner');
              },
              child: Text('Go to Meal Planner'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
              },
              child: Text('Go to Settings'),
            ),
          ],
        ),
      ),
    );
  }
}

