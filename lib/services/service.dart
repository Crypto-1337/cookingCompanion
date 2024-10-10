import 'package:hive/hive.dart';
import 'package:cooking_compantion/models/grocery_list_model.dart';

class GroceryListService {
  final String _boxName = 'groceryListBox';

  // Öffne die Box
  Future<Box<GroceryListModel>> _openBox() async {
    return await Hive.openBox<GroceryListModel>(_boxName);
  }

  // Create: Füge einen neuen Eintrag hinzu
  Future<void> addGroceryItem(GroceryListModel item) async {
    final box = await _openBox();
    await box.add(item);
  }

  // Read: Hol alle Einträge
  Future<List<GroceryListModel>> getGroceryItems() async {
    final box = await _openBox();
    return box.values.toList();
  }

  // Update: Ändere einen bestehenden Eintrag
  Future<void> updateGroceryItem(int index, GroceryListModel updatedItem) async {
    final box = await _openBox();
    await box.putAt(index, updatedItem);
  }

  // Delete: Lösche einen Eintrag
  Future<void> deleteGroceryItem(int index) async {
    final box = await _openBox();
    await box.deleteAt(index);
  }

  // Delete All: Lösche alle Einträge
  Future<void> clearGroceryList() async {
    final box = await _openBox();
    await box.clear();
  }

  // Toggle: Wechsle den checked Status
  Future<void> toggleCheckedStatus(int index) async {
    final box = await _openBox();
    final item = box.getAt(index);
    if (item != null) {
      item.checked = !item.checked;
      await box.putAt(index, item);
    }
  }

  // Schließe die Box (bei Bedarf)
  Future<void> closeBox() async {
    final box = await _openBox();
    await box.close();
  }
}
