import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Abstand zwischen den Widgets
        children: [
          // Begrüßungsnachricht oben
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Welcome to Cooking Companion!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Ein Icon in der Mitte als visuelles Element
          const Expanded(
            child: Center(
              child: Icon(
                Icons.restaurant_menu,
                size: 120,
                color: Colors.deepPurple,
              ),
            ),
          ),

          // Buttons am unteren Rand
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth < 768) {
                  // Zwei Reihen bei schmalerem Bildschirm
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 5.0), // Abstand nach rechts
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/grocery-list');
                                },
                                child: const Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.list),
                                    SizedBox(height: 4),
                                    Text('Grocery List'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 5.0), // Abstand nach rechts
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/recipe-suggestions');
                                },
                                child: const Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.book),
                                    SizedBox(height: 4),
                                    Text('Recipes'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10), // Abstand zwischen den Reihen
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 5.0), // Abstand nach rechts
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/meal-planner');
                                },
                                child: const Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.calendar_today),
                                    SizedBox(height: 4),
                                    Text('Meal Plan'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/settings');
                              },
                              child: const Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.settings),
                                  SizedBox(height: 4),
                                  Text('Settings'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                } else {
                  // Eine Reihe bei breiterem Bildschirm
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5.0), // Abstand nach rechts
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/grocery-list');
                            },
                            child: const Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.list),
                                SizedBox(height: 4),
                                Text('Grocery List'),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5.0), // Abstand nach rechts
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/recipe-suggestions');
                            },
                            child: const Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.book),
                                SizedBox(height: 4),
                                Text('Recipes'),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5.0), // Abstand nach rechts
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/meal-planner');
                            },
                            child: const Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.calendar_today),
                                SizedBox(height: 4),
                                Text('Meal Plan'),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/settings');
                          },
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.settings),
                              SizedBox(height: 4),
                              Text('Settings'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
