import 'package:flutter/material.dart';

class GroceryListScreen extends StatefulWidget {
  const GroceryListScreen({super.key});

  @override
  _GroceryListScreenState createState() => _GroceryListScreenState();
}

class _GroceryListScreenState extends State<GroceryListScreen> {
  List<Map<String, dynamic>> _groceryItems = [];

  final TextEditingController _textController = TextEditingController();

  void _addItem(String item) {
    if (item.isNotEmpty) {
      setState(() {
        _groceryItems.add({'name': item, 'isChecked': false});
      });
      _textController.clear();
    }
  }

  void _removeItem(int index) {
    setState(() {
      _groceryItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grocery List'),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: () {
              setState(() {
                _groceryItems.removeWhere((item) => item['isChecked']);
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            // Hintergrund-Icon
            _groceryItems.isEmpty
                ? Center(
              child: Opacity(
                opacity: 0.2, // Für ein dezentes Aussehen
                child: Icon(
                  Icons.shopping_cart_outlined,
                  size: 200, // Größe des Icons
                  color: Colors.deepPurple,
                ),
              ),
            )
                : SizedBox.shrink(), // Nichts anzeigen, wenn die Liste nicht leer ist

            Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: _groceryItems.length,
                    itemBuilder: (context, index) {
                      final item = _groceryItems[index];
                      return Dismissible(
                        key: UniqueKey(),
                        background: Container(
                          color: Colors.redAccent,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          _removeItem(index);
                        },
                        child: ListTile(
                          title: Text(
                            item['name'],
                            style: TextStyle(
                              fontSize: 18,
                              decoration: item['isChecked']
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                          trailing: Checkbox(
                            value: item['isChecked'],
                            onChanged: (bool? value) {
                              setState(() {
                                item['isChecked'] = value!;
                              });
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _textController,
                        decoration: InputDecoration(
                          hintText: 'Add a new item',
                          hintStyle: const TextStyle(color: Colors.grey), // Dunkelgrauer Text
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                        ),
                        style: const TextStyle(
                          color: Colors.black, // Sichtbare Textfarbe beim Eingeben
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        _addItem(_textController.text);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.deepPurple,
                      ),
                      child: const Text(
                        'Add',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
