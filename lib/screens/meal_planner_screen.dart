import 'package:flutter/material.dart';
import 'package:cooking_compantion/services/service.dart';

class MealPlannerScreen extends StatefulWidget {
  const MealPlannerScreen({super.key});

  @override
  _MealPlannerScreenState createState() => _MealPlannerScreenState();
}

class _MealPlannerScreenState extends State<MealPlannerScreen> {
  final MealPlannerService _mealPlannerService = MealPlannerService();

  @override
  void initState() {
    super.initState();
  }

  // Method to retrieve meals from the service
  Future<String> _getMeal(String day) async {
    return await _mealPlannerService.getMeal(day);
  }

  // Method to save meal using the service
  Future<void> _saveMeal(String day, String meal) async {
    await _mealPlannerService.saveMeal(day, meal);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meal Planner'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'].map((day) {
                  return FutureBuilder<String>(
                    future: _getMeal(day),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Card(
                          elevation: 3,
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            title: Text(day),
                            subtitle: Text('No meal planned'),
                            trailing: IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                _editMealDialog(context, day);
                              },
                            ),
                          ),
                        );
                      }

                      return Card(
                        elevation: 3,
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          title: Text(day),
                          subtitle: Text(
                            snapshot.data!.isEmpty ? 'No meal planned' : snapshot.data!,
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              _editMealDialog(context, day);
                            },
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await _mealPlannerService.clearPlan();
                setState(() {});
              },
              child: Text('Clear Plan'),
            ),
          ],
        ),
      ),
    );
  }

  // Method to show a dialog to edit meals
  void _editMealDialog(BuildContext context, String day) {
    TextEditingController _mealController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FutureBuilder<String>(
          future: _getMeal(day),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              _mealController.text = snapshot.data!;
            }

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
                  onPressed: () async {
                    await _saveMeal(day, _mealController.text);
                    Navigator.of(context).pop();
                  },
                  child: Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
