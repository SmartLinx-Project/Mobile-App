// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HomeAdapter extends TypeAdapter<Home> {
  @override
  final int typeId = 0;

  @override
  Home read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Home(
      homeID: fields[0] as int,
      name: fields[1] as String,
      address: fields[2] as String,
      isOwner: fields[3] as bool,
      hubID: fields[4] as int,
      hubState: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Home obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.homeID)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.address)
      ..writeByte(3)
      ..write(obj.isOwner)
      ..writeByte(4)
      ..write(obj.hubID)
      ..writeByte(5)
      ..write(obj.hubState);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RoomAdapter extends TypeAdapter<Room> {
  @override
  final int typeId = 1;

  @override
  Room read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Room(
      roomID: fields[0] as int,
      name: fields[1] as String,
      homeID: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Room obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.roomID)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.homeID);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoomAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DeviceLightAdapter extends TypeAdapter<DeviceLight> {
  @override
  final int typeId = 2;

  @override
  DeviceLight read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DeviceLight(
      deviceID: fields[0] as int,
      name: fields[1] as String,
      ieeeAddress: fields[2] as String,
      enabled: fields[3] as bool,
      brightness: fields[4] as int,
      roomID: fields[5] as int,
      isOnline: fields[6] as bool,
      colorTemp: fields[7] as int,
      model: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DeviceLight obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.deviceID)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.ieeeAddress)
      ..writeByte(3)
      ..write(obj.enabled)
      ..writeByte(4)
      ..write(obj.brightness)
      ..writeByte(5)
      ..write(obj.roomID)
      ..writeByte(6)
      ..write(obj.isOnline)
      ..writeByte(7)
      ..write(obj.colorTemp)
      ..writeByte(8)
      ..write(obj.model);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeviceLightAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DevicePlugAdapter extends TypeAdapter<DevicePlug> {
  @override
  final int typeId = 3;

  @override
  DevicePlug read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DevicePlug(
      deviceID: fields[0] as int,
      name: fields[1] as String,
      ieeeAddress: fields[2] as String,
      enabled: fields[3] as bool,
      roomID: fields[4] as int,
      isOnline: fields[5] as bool,
      power: fields[6] as int,
      energy: fields[7] as double,
    );
  }

  @override
  void write(BinaryWriter writer, DevicePlug obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.deviceID)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.ieeeAddress)
      ..writeByte(3)
      ..write(obj.enabled)
      ..writeByte(4)
      ..write(obj.roomID)
      ..writeByte(5)
      ..write(obj.isOnline)
      ..writeByte(6)
      ..write(obj.power)
      ..writeByte(7)
      ..write(obj.energy);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DevicePlugAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DeviceThermostatAdapter extends TypeAdapter<DeviceThermostat> {
  @override
  final int typeId = 4;

  @override
  DeviceThermostat read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DeviceThermostat(
      deviceID: fields[0] as int,
      name: fields[1] as String,
      ieeeAddress: fields[2] as String,
      roomID: fields[3] as int,
      isOnline: fields[4] as bool,
      temperature: fields[5] as double,
      humidity: fields[6] as double,
    );
  }

  @override
  void write(BinaryWriter writer, DeviceThermostat obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.deviceID)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.ieeeAddress)
      ..writeByte(3)
      ..write(obj.roomID)
      ..writeByte(4)
      ..write(obj.isOnline)
      ..writeByte(5)
      ..write(obj.temperature)
      ..writeByte(6)
      ..write(obj.humidity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeviceThermostatAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FavouriteAdapter extends TypeAdapter<Favourite> {
  @override
  final int typeId = 5;

  @override
  Favourite read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Favourite(
      deviceID: fields[0] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Favourite obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.deviceID);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavouriteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FamilyMemberAdapter extends TypeAdapter<FamilyMember> {
  @override
  final int typeId = 6;

  @override
  FamilyMember read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FamilyMember(
      firstName: fields[0] as String,
      lastName: fields[1] as String,
      email: fields[2] as String,
      homeID: fields[3] as int,
      photoUri: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FamilyMember obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.firstName)
      ..writeByte(1)
      ..write(obj.lastName)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.homeID)
      ..writeByte(4)
      ..write(obj.photoUri);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FamilyMemberAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RoutineAdapter extends TypeAdapter<Routine> {
  @override
  final int typeId = 7;

  @override
  Routine read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Routine(
      routineID: fields[0] as int,
      name: fields[3] as String,
      icon: fields[2] as String,
      body: fields[1] as String,
      homeID: fields[4] as int,
      enabled: fields[5] as bool,
      periodicity: (fields[6] as List?)?.cast<dynamic>(),
      time: fields[7] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, Routine obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.routineID)
      ..writeByte(1)
      ..write(obj.body)
      ..writeByte(2)
      ..write(obj.icon)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.homeID)
      ..writeByte(5)
      ..write(obj.enabled)
      ..writeByte(6)
      ..write(obj.periodicity)
      ..writeByte(7)
      ..write(obj.time);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoutineAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
