import 'package:hive/hive.dart';

part 'grocery_list_model.g.dart';

@HiveType(typeId: 1)
class GroceryListModel {
  @HiveField(0)
  String itemName;

  @HiveField(1)
  bool checked;

  GroceryListModel({
    required this.itemName,
    this.checked = false,
  });
}
