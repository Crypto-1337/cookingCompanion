import 'package:flutter/material.dart';

class MealPlannerScreen extends StatefulWidget {
  @override
  _MealPlannerScreenState createState() => _MealPlannerScreenState();
}

class _MealPlannerScreenState extends State<MealPlannerScreen> {
  // Example meal data for the week
  Map<String, String> _mealPlan = {
    'Monday': '',
    'Tuesday': '',
    'Wednesday': '',
    'Thursday': '',
    'Friday': '',
    'Saturday': '',
    'Sunday': '',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meal Planner'),
      ),
      body: Stack(
        children: [
          // Background icon
          Positioned.fill(
            child: Opacity(
              opacity: 0.1, // Set opacity for the background image
              child: Center(
                child: Icon(
                  Icons.restaurant_menu,
                  size: 300, // Size of the icon
                  color: Colors.deepPurple, // Color of the icon
                ),
              ),
            ),
          ),
          // Main content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: _mealPlan.keys.map((day) {
                      return Card(
                        elevation: 3,
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          title: Text(day),
                          subtitle: Text(
                            _mealPlan[day]!.isEmpty
                                ? 'No meal planned'
                                : _mealPlan[day]!,
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              _editMealDialog(context, day);
                            },
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Optionally add functionality to clear the weekly plan
                    setState(() {
                      _mealPlan.updateAll((key, value) => '');
                    });
                  },
                  child: Text('Clear Plan'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Function to show a dialog to edit meals
  void _editMealDialog(BuildContext context, String day) {
    TextEditingController _mealController = TextEditingController();
    _mealController.text = _mealPlan[day]!;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit meal for $day'),
          content: TextField(
            controller: _mealController,
            decoration: InputDecoration(hintText: "Enter meal"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _mealPlan[day] = _mealController.text;
                });
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
