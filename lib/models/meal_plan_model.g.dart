// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_plan_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MealPlanModelAdapter extends TypeAdapter<MealPlanModel> {
  @override
  final int typeId = 2;

  @override
  MealPlanModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MealPlanModel(
      day: fields[0] as String,
      meal: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MealPlanModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.day)
      ..writeByte(1)
      ..write(obj.meal);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MealPlanModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
