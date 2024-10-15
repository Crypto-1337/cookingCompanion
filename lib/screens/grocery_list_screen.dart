import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:cooking_compantion/models/grocery_list_model.dart';

class GroceryListScreen extends StatefulWidget {
  const GroceryListScreen({super.key});

  @override
  _GroceryListScreenState createState() => _GroceryListScreenState();
}

class _GroceryListScreenState extends State<GroceryListScreen> {
  List<GroceryListModel> _groceryItems = [];
  final TextEditingController _textController = TextEditingController();
  late Box<GroceryListModel> _groceryBox;

  @override
  void initState() {
    super.initState();
    _initHive();
  }

  Future<void> _initHive() async {
    _groceryBox = await Hive.openBox<GroceryListModel>('groceryListBox');
    setState(() {
      _groceryItems = _groceryBox.values.toList();
    });
  }

  // Add Item to Hive
  void _addItem(String item) {
    if (item.isNotEmpty) {
      final groceryItem = GroceryListModel(itemName: item);
      setState(() {
        _groceryItems.add(groceryItem);
        _groceryBox.add(groceryItem); // Speichere den Eintrag in der Hive-Box
      });
      _textController.clear();
    }
  }

  // Remove Item from Hive
  void _removeItem(int index) {
    setState(() {
      _groceryBox.deleteAt(index); // Entferne den Eintrag aus der Hive-Box
      _groceryItems.removeAt(index);
    });
  }

  // Toggle Checkbox Status
  void _toggleItemChecked(int index) {
    setState(() {
      final currentItem = _groceryItems[index];
      final updatedItem = GroceryListModel(
        itemName: currentItem.itemName,
        checked: !currentItem.checked,
      );
      _groceryItems[index] = updatedItem;
      _groceryBox.putAt(index, updatedItem); // Aktualisiere den Eintrag in der Hive-Box
    });
  }

  // Remove all checked items from Hive
  void _removeCheckedItems() {
    setState(() {
      _groceryItems.removeWhere((item) => item.checked);
      _groceryBox.values
          .where((item) => item.checked)
          .forEach((item) {
        final index = _groceryBox.values.toList().indexOf(item);
        _groceryBox.deleteAt(index);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grocery List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: _removeCheckedItems,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            // Hintergrund-Icon, wenn die Liste leer ist
            _groceryItems.isEmpty
                ? Center(
              child: Opacity(
                opacity: 0.2,
                child: Icon(
                  Icons.shopping_cart_outlined,
                  size: 200,
                  color: Colors.deepPurple,
                ),
              ),
            )
                : const SizedBox.shrink(),
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
                            item.itemName,
                            style: TextStyle(
                              fontSize: 18,
                              decoration: item.checked
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                          trailing: Checkbox(
                            value: item.checked,
                            onChanged: (bool? value) {
                              _toggleItemChecked(index);
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
                          hintStyle: const TextStyle(color: Colors.grey),
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
