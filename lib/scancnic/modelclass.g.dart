// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modelclass.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TodoModelAdapter extends TypeAdapter<TodoModel> {
  @override
  final int typeId = 0;

  @override
  TodoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TodoModel(
      name: fields[0] as String,
      cnic: fields[1] as String,
      dob: fields[2] as String,
      doi: fields[3] as String,
      doe: fields[4] as String,
      imageUrl: fields[5] as String,
      imageUrl2: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TodoModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.cnic)
      ..writeByte(2)
      ..write(obj.dob)
      ..writeByte(3)
      ..write(obj.doi)
      ..writeByte(4)
      ..write(obj.doe)
      ..writeByte(5)
      ..write(obj.imageUrl)
      ..writeByte(6)
      ..write(obj.imageUrl2);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DocAdapter extends TypeAdapter<Doc> {
  @override
  final int typeId = 1;

  @override
  Doc read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Doc(
      imageU: fields[0] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Doc obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.imageU);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DocAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class QrAdapter extends TypeAdapter<Qr> {
  @override
  final int typeId = 2;

  @override
  Qr read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Qr(
      qrcode: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Qr obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.qrcode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QrAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
