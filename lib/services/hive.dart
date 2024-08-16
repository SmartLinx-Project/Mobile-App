import 'package:hive/hive.dart';
part 'hive.g.dart';

@HiveType(typeId: 0)
class Home extends HiveObject {
  @HiveField(0)
  late int homeID;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late String address;

  @HiveField(3)
  late bool isOwner;

  @HiveField(4)
  late int hubID;

  @HiveField(5)
  late bool hubState;

  Home({
    required this.homeID,
    required this.name,
    required this.address,
    required this.isOwner,
    required this.hubID,
    required this.hubState,
  });
}

@HiveType(typeId: 1)
class Room extends HiveObject {
  @HiveField(0)
  late int roomID;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late int homeID;

  Room({
    required this.roomID,
    required this.name,
    required this.homeID,
  });
}

@HiveType(typeId: 2)
class DeviceLight extends HiveObject {
  @HiveField(0)
  late int deviceID;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late String ieeeAddress;

  @HiveField(3)
  late bool enabled;

  @HiveField(4)
  late int brightness;

  @HiveField(5)
  late int roomID;

  @HiveField(6)
  late bool isOnline;

  @HiveField(7)
  late int colorTemp;

  @HiveField(8)
  late String model;

  DeviceLight({
    required this.deviceID,
    required this.name,
    required this.ieeeAddress,
    required this.enabled,
    required this.brightness,
    required this.roomID,
    required this.isOnline,
    required this.colorTemp,
    required this.model,
  });
}

@HiveType(typeId: 3)
class DevicePlug extends HiveObject {
  @HiveField(0)
  late int deviceID;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late String ieeeAddress;

  @HiveField(3)
  late bool enabled;

  @HiveField(4)
  late int roomID;

  @HiveField(5)
  late bool isOnline;

  @HiveField(6)
  late int power;

  @HiveField(7)
  late double energy;

  DevicePlug({
    required this.deviceID,
    required this.name,
    required this.ieeeAddress,
    required this.enabled,
    required this.roomID,
    required this.isOnline,
    required this.power,
    required this.energy,
  });
}

@HiveType(typeId: 4)
class DeviceThermostat extends HiveObject {
  @HiveField(0)
  late int deviceID;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late String ieeeAddress;

  @HiveField(3)
  late int roomID;

  @HiveField(4)
  late bool isOnline;

  @HiveField(5)
  double temperature;

  @HiveField(6)
  double humidity;

  DeviceThermostat({
    required this.deviceID,
    required this.name,
    required this.ieeeAddress,
    required this.roomID,
    required this.isOnline,
    required this.temperature,
    required this.humidity,
  });
}

@HiveType(typeId: 5)
class Favourite extends HiveObject {
  @HiveField(0)
  late int deviceID;

  Favourite({required this.deviceID});
}

@HiveType(typeId: 6)
class FamilyMember extends HiveObject {
  @HiveField(0)
  late String firstName;

  @HiveField(1)
  late String lastName;

  @HiveField(2)
  late String email;

  @HiveField(3)
  late int homeID;

  @HiveField(4)
  late String photoUri;

  FamilyMember(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.homeID,
      required this.photoUri});
}

@HiveType(typeId: 7)
class Routine extends HiveObject {
  @HiveField(0)
  late int routineID;

  @HiveField(1)
  late String body;

  @HiveField(2)
  late String icon;

  @HiveField(3)
  late String name;

  @HiveField(4)
  late int homeID;

  @HiveField(5)
  late bool enabled;

  @HiveField(6)
  late List<dynamic>? periodicity;

  @HiveField(7)
  late DateTime? time;

  Routine({
    required this.routineID,
    required this.name,
    required this.icon,
    required this.body,
    required this.homeID,
    required this.enabled,
    this.periodicity,
    this.time,
  });
}
