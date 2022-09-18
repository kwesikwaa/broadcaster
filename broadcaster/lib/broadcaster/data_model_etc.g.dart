// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_model_etc.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DraftAdapter extends TypeAdapter<Draft> {
  @override
  final int typeId = 0;

  @override
  Draft read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Draft(
      id: fields[0] as String,
      message: fields[1] as String,
      contactlists: (fields[2] as List)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Draft obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.message)
      ..writeByte(2)
      ..write(obj.contactlists);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DraftAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HistoryAdapter extends TypeAdapter<History> {
  @override
  final int typeId = 1;

  @override
  History read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return History(
      message: fields[0] as String,
      totalsent: fields[1] as int,
      date: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, History obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.message)
      ..writeByte(1)
      ..write(obj.totalsent)
      ..writeByte(2)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HistoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PhoneContactAdapter extends TypeAdapter<PhoneContact> {
  @override
  final int typeId = 2;

  @override
  PhoneContact read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PhoneContact(
      contact: fields[0] as String,
      selected: fields[1] as bool,
      name: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PhoneContact obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.contact)
      ..writeByte(1)
      ..write(obj.selected)
      ..writeByte(2)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PhoneContactAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BroadcastContactAdapter extends TypeAdapter<BroadcastContact> {
  @override
  final int typeId = 3;

  @override
  BroadcastContact read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BroadcastContact(
      contact: fields[0] as PhoneContact,
      nametocall: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BroadcastContact obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.contact)
      ..writeByte(1)
      ..write(obj.nametocall);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BroadcastContactAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BroadcastGroupAdapter extends TypeAdapter<BroadcastGroup> {
  @override
  final int typeId = 4;

  @override
  BroadcastGroup read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BroadcastGroup(
      groupname: fields[0] as String,
      groupselected: fields[1] as bool,
      contactlist: (fields[2] as List)?.cast<BroadcastContact>(),
    );
  }

  @override
  void write(BinaryWriter writer, BroadcastGroup obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.groupname)
      ..writeByte(1)
      ..write(obj.groupselected)
      ..writeByte(2)
      ..write(obj.contactlist);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BroadcastGroupAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
