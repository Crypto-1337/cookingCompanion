import 'package:flutter/material.dart';

class RecipeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildRecipeOption(
              context,
              title: 'Find Recipes by Ingredients',
              icon: Icons.kitchen,
              onTap: () {
                Navigator.pushNamed(context, '/find-by-ingredients');
              },
            ),
            _buildRecipeOption(
              context,
              title: 'Search Recipes',
              icon: Icons.search,
              onTap: () {
                Navigator.pushNamed(context, '/search-recipes');
              },
            ),
            _buildRecipeOption(
              context,
              title: 'Upload & Analyze Image',
              icon: Icons.camera_alt,
              onTap: () {
                Navigator.pushNamed(context, '/analyze-image');
              },
            ),
            _buildRecipeOption(
              context,
              title: 'View Saved Recipes',
              icon: Icons.bookmark,
              onTap: () {
                Navigator.pushNamed(context, '/saved-recipes');
              },
            ),
            _buildRecipeOption(
              context,
              title: 'Random Recipe Suggestions',
              icon: Icons.shuffle,
              onTap: () {
                Navigator.pushNamed(context, '/random-recipes');
              },
            ),
            _buildRecipeOption(
              context,
              title: 'Healthy Recipes',
              icon: Icons.health_and_safety,
              onTap: () {
                Navigator.pushNamed(context, '/healthy-recipes');
              },
            ),
            _buildRecipeOption(
              context,
              title: 'Trending Recipes',
              icon: Icons.trending_up,
              onTap: () {
                Navigator.pushNamed(context, '/trending-recipes');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecipeOption(BuildContext context, {required String title, required IconData icon, required VoidCallback onTap}) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: Icon(Icons.arrow_forward),
        onTap: onTap,
      ),
    );
  }
}
