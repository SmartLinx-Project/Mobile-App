import 'package:smartlinx/services/hive.dart';
import 'dart:convert';
import 'package:smartlinx/services/http.dart';

class GetInfo {
  static final GetInfo _instance = GetInfo._internal();

  factory GetInfo() {
    return _instance;
  }

  GetInfo._internal();

  late Map<String, dynamic> fullJson;
  List<Home> homes = [];
  List<Room> rooms = [];
  List<DeviceLight> deviceLight = [];
  List<DevicePlug> devicePlug = [];
  List<DeviceThermostat> deviceThermostat = [];
  List<FamilyMember> familyMembers = [];
  List<Favourite> favourites = [];
  List<Routine> routines = [];

  Future<bool> manageJson() async {
    clearList();
    if (await getJsonFromAPI()) {
      handleHomes();
      handleFavourites();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> getJsonFromAPI() async {
    Map<String, dynamic>? jsonContent = await HttpService().getHomeInfo();
    if (jsonContent != null) {
      fullJson = jsonContent;
      return true;
    } else {
      return false;
    }
  }

  void handleHomes() {
    List<dynamic> homesList = fullJson['homes'];
    for (var home in homesList) {
      int homeID = home['homeID'];
      String homeName = home['name'];
      String homeAddress = home['address'];
      bool homeOwner = home['owner'];
      int hubID = home['hubID'];
      bool hubState = home['online'];
      Home filteredHome = Home(
          homeID: homeID,
          name: homeName,
          address: homeAddress,
          isOwner: homeOwner,
          hubID: hubID,
          hubState: hubState);
      homes.add(filteredHome);

      List<dynamic> familyMembersList = home['familyMembers'];
      for (var member in familyMembersList) {
        String firstName = member['firstName'];
        String lastName = member['lastName'];
        String email = member['mail'];
        String photoUrl =
            (member['profilePicture'] == null) ? '' : member['profilePicture'];

        FamilyMember filteredMember = FamilyMember(
            firstName: firstName,
            lastName: lastName,
            email: email,
            homeID: homeID,
            photoUri: photoUrl);
        familyMembers.add(filteredMember);
      }

      List<dynamic> roomsList = home['rooms'];
      for (var room in roomsList) {
        int roomID = room['roomID'];
        String roomName = room['name'];
        Room filteredRoom = Room(roomID: roomID, name: roomName, homeID: homeID);
        rooms.add(filteredRoom);

        List<dynamic> devicesList = room['devices'];
        for (var device in devicesList) {
          if (device['type'] == 'light') {
            parseLight(device, roomID);
          } else if (device['type'] == 'thermometer') {
            parseThermometer(device, roomID);
          } else if (device['type'] == 'switch') {
            parsePlug(device, roomID);
          }
        }
      }

      List<dynamic> routineList = home['routines'];
      for (var routine in routineList) {
        parseRoutine(routine, homeID);
      }
    }
  }

  void parseThermometer(device, int roomID) {
    int deviceID = device['deviceID'];
    String name = device['name'];
    String ieeeAddress = device['ieeeAddress'];

    String? statusString = device['status'];
    Map<String, dynamic> jsonData;
    bool isOnline = false;
    String temp;
    String hum;

    if (statusString != null) {
      jsonData = jsonDecode(statusString);
      temp = jsonData['temperature'].toString();
      hum = jsonData['humidity'].toString();
      isOnline = true;
    } else {
      temp = '0';
      hum = '0';
    }

    double temperature = double.parse(temp);
    double humidity = double.parse(hum);

    DeviceThermostat filteredThermostat = DeviceThermostat(
        deviceID: deviceID,
        name: name,
        ieeeAddress: ieeeAddress,
        roomID: roomID,
        isOnline: isOnline,
        temperature: temperature,
        humidity: humidity);
    deviceThermostat.add(filteredThermostat);
  }

  void parseLight(device, int roomID) {
    int deviceID = device['deviceID'];
    String name = device['name'];
    String ieeeAddress = device['ieeeAddress'];
    String model = device['model'];
    String? statusString = device['status'];

    int brightness = 0;
    bool state = false;
    int colorTemp = 0;
    bool enabled = false;

    if (statusString != null) {
      Map<String, dynamic> jsonData = jsonDecode(statusString);
      if (jsonData['color_mode'] == 'xy') {
        brightness = 200;
        colorTemp = 454;
      } else {
        brightness = jsonData['brightness'];
        colorTemp = jsonData['color_temp'];
      }
      state = true;
      enabled = (jsonData['state'] == 'OFF') ? false : true;
    }

    DeviceLight filteredLight = DeviceLight(
      deviceID: deviceID,
      name: name,
      ieeeAddress: ieeeAddress,
      enabled: enabled,
      brightness: brightness,
      roomID: roomID,
      isOnline: state,
      colorTemp: colorTemp,
      model: model,
    );
    deviceLight.add(filteredLight);
  }

  void parsePlug(device, int roomID) {
    int deviceID = device['deviceID'];
    String name = device['name'];
    String ieeeAddress = device['ieeeAddress'];
    int power = 0;
    double energy = 0;
    bool enabled = false;

    String? statusString = device['status'];
    bool state = false;

    if (statusString != null) {
      Map<String, dynamic> jsonData = jsonDecode(statusString);
      state = true;
      enabled = (jsonData['state'] == 'OFF') ? false : true;
      if (jsonData['power'] != null && jsonData['current'] != null) {
        power = jsonData['power'] as int;
        energy = double.parse(jsonData['current'].toString());
      } else {
        power = 0;
        energy = 0;
      }
    }

    DevicePlug filteredPlug = DevicePlug(
      deviceID: deviceID,
      name: name,
      ieeeAddress: ieeeAddress,
      enabled: enabled,
      roomID: roomID,
      isOnline: state,
      power: power,
      energy: energy,
    );
    devicePlug.add(filteredPlug);
  }

  void parseRoutine(dynamic routine, int homeID) {
    int routineID = routine['routineID'];
    String name = routine['name'];
    String icon = routine['icon'];
    bool enabled = routine['enabled'];
    List<String>? periodicity = parseDynamicToString(routine['periodicity']);
    String body = parseActionsBody(routine['actions']);
    DateTime? time = getRoutineTime(routine['time'].toString());
    Routine newRoutine = Routine(
        routineID: routineID,
        name: name,
        icon: icon,
        body: body,
        homeID: homeID,
        enabled: enabled,
        time: time,
        periodicity: periodicity);
    routines.add(newRoutine);
  }

  List<String>? parseDynamicToString(List<dynamic> week) {
    List<String> periodicity = [];
    for (int i = 0; i < week.length; i++) {
      if (week[i] != null && week[i].toString().isNotEmpty) {
        periodicity.add(week[i].toString());
      }
    }
    if (periodicity.isEmpty) {
      return null;
    } else {
      return periodicity;
    }
  }

  DateTime? getRoutineTime(String? timeString) {
    if (timeString == null ||
        timeString.isEmpty ||
        timeString.toLowerCase() == 'null') {
      return null;
    }
    List<String> timePart = timeString.split(':');
    if (timePart.length < 2) {
      return null;
    }
    try {
      DateTime now = DateTime.now();
      DateTime parsedTime = DateTime(now.year, now.month, now.day,
          int.parse(timePart[0]), int.parse(timePart[1]));
      return parsedTime;
    } catch (e) {
      print('Errore durante il parsing della data: $e');
      return null;
    }
  }

  String parseActionsBody(dynamic actions) {
    String jsonString = jsonEncode(actions);
    Map<String, dynamic> result = {"actions": jsonDecode(jsonString)};
    String finalJsonString = jsonEncode(result);
    return finalJsonString;
  }

  void handleFavourites() {
    List<dynamic> favouriteList = fullJson['favourites'];
    for (var favourite in favouriteList) {
      int deviceID = favourite;
      favourites.add(Favourite(deviceID: deviceID));
    }
  }

  List<Home> getHomes() {
    return homes;
  }

  List<Room> getRooms() {
    return rooms;
  }

  List<DeviceLight> getDeviceLight() {
    return deviceLight;
  }

  List<DevicePlug> getDevicePlug() {
    return devicePlug;
  }

  List<DeviceThermostat> getDeviceThermostat() {
    return deviceThermostat;
  }

  List<FamilyMember> getFamilyMembers() {
    return familyMembers;
  }

  List<Favourite> getFavourites() {
    return favourites;
  }

  List<Routine> getRoutines() {
    return routines;
  }

  void clearList() {
    homes.clear();
    rooms.clear();
    deviceLight.clear();
    devicePlug.clear();
    deviceThermostat.clear();
    familyMembers.clear();
    favourites.clear();
    routines.clear();
  }
}
