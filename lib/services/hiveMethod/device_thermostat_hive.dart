import 'package:hive/hive.dart';
import 'package:smartlinx/services/hiveMethod/favourite_hive.dart';
import '../getinfo.dart';
import '../hive.dart';

class DeviceThermostatHive {
  static final DeviceThermostatHive _instance = DeviceThermostatHive._();
  List<DeviceThermostat> _devices = [];

  DeviceThermostatHive._() {
    _devices = [];
    //_init();
  }

  static DeviceThermostatHive get instance {
    return _instance;
  }

  Future<void> insertDevice(DeviceThermostat newDevice) async {
    var box = await Hive.openBox<DeviceThermostat>('deviceThermostat');

    box.add(newDevice);
  }

  Future<void> fillDatabase() async {
    await clearDatabase();
    List<DeviceThermostat> netDevice = GetInfo().getDeviceThermostat();
    for(int i = 0; i < netDevice.length; i++){
      insertDevice(netDevice[i]);
    }
  }

  Future<void> init() async {
    await fillDatabase();
    final Box<DeviceThermostat> deviceBox = await Hive.openBox<DeviceThermostat>('deviceThermostat');
    _devices.clear();
    for (int i = 0; i < deviceBox.length; i++) {
      _devices.add(deviceBox.getAt(i)!);
    }
    await deviceBox.close();
  }

  List<DeviceThermostat> getAllDevices() {
    return _devices;
  }

  DeviceThermostat getDevicesFromID(int deviceID) {
    return _devices.firstWhere((device) => device.deviceID == deviceID);
  }

  List<DeviceThermostat> getDevicesFromRoomID(int roomID) {
    List<DeviceThermostat> filtredDevices = [];
    for (int i = 0; i < _devices.length; i++) {
      if (_devices[i].roomID == roomID) {
        filtredDevices.add(_devices[i]);
      }
    }
    return filtredDevices;
  }

  Future<void> removeDevice(int deviceID) async {
    final Box<DeviceLight> deviceBox = await Hive.openBox<DeviceLight>('deviceThermostat');

    int index = _devices.indexWhere((device) => device.deviceID == deviceID);

    if (index != -1) {
      await deviceBox.deleteAt(index);
      _devices.removeAt(index);
    }

    await deviceBox.close();
  }

  void clearRoomsDevice(int roomID) async{
    final Box<DeviceThermostat> deviceBox = await Hive.openBox<DeviceThermostat>('deviceThermostat');
    for(int i = 0; i < deviceBox.length; i++){
      if(deviceBox.getAt(i)?.roomID == roomID){
        await deviceBox.deleteAt(i);
        FavouriteHive.instance.deleteFavourite(deviceBox.getAt(i)!.deviceID);
      }
    }
    deviceBox.close();
  }


  Future<void> clearDatabase() async {
    final Box<DeviceThermostat> deviceBox = await Hive.openBox<DeviceThermostat>('deviceThermostat');
    await deviceBox.clear();
  }
}
