import 'package:hive/hive.dart';
import 'package:smartlinx/services/hiveMethod/favourite_hive.dart';
import '../getinfo.dart';
import '../hive.dart';

class DevicePlugHive {
  static final DevicePlugHive _instance = DevicePlugHive._();
  List<DevicePlug> _devices = [];

  DevicePlugHive._() {
    _devices = [];
    //_init();
  }

  static DevicePlugHive get instance {
    return _instance;
  }

  Future<void> insertDevice(DevicePlug newDevice) async {
    var box = await Hive.openBox<DevicePlug>('devicePlug');

    box.add(newDevice);
  }

  Future<void> fillDatabase() async {
    await clearDatabase();
    List<DevicePlug> netDevice = GetInfo().getDevicePlug();
    for(int i = 0; i < netDevice.length; i++){
      insertDevice(netDevice[i]);
    }
  }

  Future<void> init() async {
    await fillDatabase();
    final Box<DevicePlug> deviceBox = await Hive.openBox<DevicePlug>('devicePlug');
    _devices.clear();
    for (int i = 0; i < deviceBox.length; i++) {
      _devices.add(deviceBox.getAt(i)!);
    }
    await deviceBox.close();
  }

  List<DevicePlug> getAllDevices() {
    return _devices;
  }

  DevicePlug getDevicesFromID(int deviceID) {
    return _devices.firstWhere((device) => device.deviceID == deviceID);
  }

  List<DevicePlug> getDevicesFromRoomID(int roomID) {
    List<DevicePlug> filteredDevices = [];
    for (int i = 0; i < _devices.length; i++) {
      if (_devices[i].roomID == roomID) {
        filteredDevices.add(_devices[i]);
      }
    }
    return filteredDevices;
  }

  Future<void> removeDevice(int deviceID) async {
    final Box<DeviceLight> deviceBox = await Hive.openBox<DeviceLight>('devicePlug');

    int index = _devices.indexWhere((device) => device.deviceID == deviceID);

    if (index != -1) {
      await deviceBox.deleteAt(index);
      _devices.removeAt(index);
    }

    await deviceBox.close();
  }

  void clearRoomsDevice(int roomID) async{
    final Box<DevicePlug> deviceBox = await Hive.openBox<DevicePlug>('devicePlug');
    for(int i = 0; i < deviceBox.length; i++){
      if(deviceBox.getAt(i)?.roomID == roomID){
        await deviceBox.deleteAt(i);
        FavouriteHive.instance.deleteFavourite(deviceBox.getAt(i)!.deviceID);
      }
    }
    deviceBox.close();
  }

  void editDevice(DevicePlug device){
    int deviceID = device.deviceID;
    for(int i = 0; i < _devices.length; i++){
      if(deviceID == _devices[i].deviceID){
        _devices[i] = device;
      }
    }
  }

  Future<void> clearDatabase() async {
    final Box<DevicePlug> deviceBox = await Hive.openBox<DevicePlug>('devicePlug');
    await deviceBox.clear();
  }
}
