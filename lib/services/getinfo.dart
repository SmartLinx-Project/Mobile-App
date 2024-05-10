
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
        Room filteredRoom =
            Room(roomID: roomID, name: roomName, homeID: homeID);
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
    String startTime = device['startTime'];
    String endTime = device['endTime'];
    List<dynamic> periodicity = device['periodicity'];
    String model = device['model'];
    bool schedState = device['enabled'];
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
        startTime: startTime,
        endTime: endTime,
        periodicity: periodicity,
        roomID: roomID,
        isOnline: state,
        colorTemp: colorTemp,
        model: model,
        schedState: schedState);
    deviceLight.add(filteredLight);
  }

  void parsePlug(device, int roomID) {
    int deviceID = device['deviceID'];
    String name = device['name'];
    String ieeeAddress = device['ieeeAddress'];
    String startTime = device['startTime'];
    String endTime = device['endTime'];
    List<dynamic> periodicity = device['periodicity'];
    bool schedState = device['enabled'];
    int power = 0;
    double energy = 0;
    bool enabled = false;

    String? statusString = device['status'];
    bool state = false;

    if (statusString != null) {
      Map<String, dynamic> jsonData = jsonDecode(statusString);
      state = true;
      enabled = (jsonData['state'] == 'OFF') ? false : true;
      if(jsonData['power'] != null && jsonData['current'] != null){
        power = jsonData['power'] as int;
        energy = double.parse(jsonData['current'].toString());
      } else{
        power = 0;
        energy = 0;
      }
    }

    DevicePlug filteredPlug = DevicePlug(
      deviceID: deviceID,
      name: name,
      ieeeAddress: ieeeAddress,
      enabled: enabled,
      startTime: startTime,
      endTime: endTime,
      periodicity: periodicity,
      roomID: roomID,
      isOnline: state,
      power: power,
      energy: energy,
      schedState: schedState
    );
    devicePlug.add(filteredPlug);
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

  void clearList() {
    homes.clear();
    rooms.clear();
    deviceLight.clear();
    devicePlug.clear();
    deviceThermostat.clear();
    familyMembers.clear();
    favourites.clear();
  }
}
