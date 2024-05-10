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
  late String startTime;

  @HiveField(6)
  late String endTime;

  @HiveField(7)
  late List<dynamic> periodicity;

  @HiveField(8)
  late int roomID;

  @HiveField(9)
  late bool isOnline;

  @HiveField(10)
  late int colorTemp;

  @HiveField(11)
  late String model;

  @HiveField(12)
  late bool schedState;

  DeviceLight({
    required this.deviceID,
    required this.name,
    required this.ieeeAddress,
    required this.enabled,
    required this.brightness,
    required this.startTime,
    required this.endTime,
    required this.periodicity,
    required this.roomID,
    required this.isOnline,
    required this.colorTemp,
    required this.model,
    required this.schedState,
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
  late String startTime;

  @HiveField(5)
  late String endTime;

  @HiveField(6)
  late List<dynamic> periodicity;

  @HiveField(7)
  late int roomID;

  @HiveField(8)
  late bool isOnline;

  @HiveField(9)
  late int power;

  @HiveField(10)
  late double energy;

  @HiveField(11)
  late bool schedState;

  DevicePlug({
    required this.deviceID,
    required this.name,
    required this.ieeeAddress,
    required this.enabled,
    required this.startTime,
    required this.endTime,
    required this.periodicity,
    required this.roomID,
    required this.isOnline,
    required this.power,
    required this.energy,
    required this.schedState,
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
