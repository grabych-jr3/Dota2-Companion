// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hero_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HeroModelAdapter extends TypeAdapter<HeroModel> {
  @override
  final int typeId = 0;

  @override
  HeroModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HeroModel(
      id: fields[0] as int,
      name: fields[1] as String,
      localizedName: fields[2] as String,
      primaryAttr: fields[3] as String,
      attackType: fields[4] as String,
      img: fields[5] as String,
      baseHealth: fields[6] as int,
      baseMana: fields[7] as int,
      moveSpeed: fields[8] as int,
      roles: (fields[9] as List).cast<dynamic>(),
      baseAttackMin: fields[10] as int,
      baseAttackMax: fields[11] as int,
      baseArmor: fields[12] as double,
      attackRange: fields[13] as int,
      projectileSpeed: fields[14] as int,
    );
  }

  @override
  void write(BinaryWriter writer, HeroModel obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.localizedName)
      ..writeByte(3)
      ..write(obj.primaryAttr)
      ..writeByte(4)
      ..write(obj.attackType)
      ..writeByte(5)
      ..write(obj.img)
      ..writeByte(6)
      ..write(obj.baseHealth)
      ..writeByte(7)
      ..write(obj.baseMana)
      ..writeByte(8)
      ..write(obj.moveSpeed)
      ..writeByte(9)
      ..write(obj.roles)
      ..writeByte(10)
      ..write(obj.baseAttackMin)
      ..writeByte(11)
      ..write(obj.baseAttackMax)
      ..writeByte(12)
      ..write(obj.baseArmor)
      ..writeByte(13)
      ..write(obj.attackRange)
      ..writeByte(14)
      ..write(obj.projectileSpeed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HeroModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
