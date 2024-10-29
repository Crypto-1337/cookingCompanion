// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SettingsModelAdapter extends TypeAdapter<SettingsModel> {
  @override
  final int typeId = 4;

  @override
  SettingsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SettingsModel(
      darkMode: fields[0] as bool,
      mealReminders: fields[1] as bool,
      newRecipeSuggestions: fields[2] as bool,
      confirmBeforeDelete: fields[3] as bool,
      language: fields[4] as String,
      measurementUnit: fields[5] as String,
      apiKey: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SettingsModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.darkMode)
      ..writeByte(1)
      ..write(obj.mealReminders)
      ..writeByte(2)
      ..write(obj.newRecipeSuggestions)
      ..writeByte(3)
      ..write(obj.confirmBeforeDelete)
      ..writeByte(4)
      ..write(obj.language)
      ..writeByte(5)
      ..write(obj.measurementUnit)
      ..writeByte(6)
      ..write(obj.apiKey);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
