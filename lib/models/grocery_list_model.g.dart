// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grocery_list_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GroceryListModelAdapter extends TypeAdapter<GroceryListModel> {
  @override
  final int typeId = 1;

  @override
  GroceryListModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GroceryListModel(
      itemName: fields[0] as String,
      checked: fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, GroceryListModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.itemName)
      ..writeByte(1)
      ..write(obj.checked);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GroceryListModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
