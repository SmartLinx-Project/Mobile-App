import 'package:hive/hive.dart';
import 'package:smartlinx/services/hiveMethod/favourite_hive.dart';
import '../getinfo.dart';
import '../hive.dart';

class DeviceLightHive {
  static final DeviceLightHive _instance = DeviceLightHive._();
  List<DeviceLight> _devices = [];

  DeviceLightHive._() {
    _devices = [];
    //_init();
  }

  static DeviceLightHive get instance {
    return _instance;
  }

  Future<void> insertDevice(DeviceLight newDevice) async {
    var box = await Hive.openBox<DeviceLight>('deviceLight');
    box.add(newDevice);
  }

  Future<void> fillDatabase() async {
    await clearDatabase();
    List<DeviceLight> netDevice = GetInfo().getDeviceLight();
    for(int i = 0; i < netDevice.length; i++){
      insertDevice(netDevice[i]);
    }
  }

  Future<void> init() async {
    await fillDatabase();
    final Box<DeviceLight> deviceBox = await Hive.openBox<DeviceLight>('deviceLight');
    _devices.clear();
    for (int i = 0; i < deviceBox.length; i++) {
      _devices.add(deviceBox.getAt(i)!);
    }
    await deviceBox.close();
  }

  List<DeviceLight> getAllDevices() {
    return _devices;
  }

  DeviceLight getDevicesFromID(int deviceID) {
    return _devices.firstWhere((device) => device.deviceID == deviceID);
  }

  List<DeviceLight> getDevicesFromRoomID(int roomID) {
    List<DeviceLight> filteredDevices = [];
    for (int i = 0; i < _devices.length; i++) {
      if (_devices[i].roomID == roomID) {
        filteredDevices.add(_devices[i]);
      }
    }
    return filteredDevices;
  }

   Future<void> removeDevice(int deviceID) async {
    final Box<DeviceLight> deviceBox = await Hive.openBox<DeviceLight>('deviceLight');

    int index = _devices.indexWhere((device) => device.deviceID == deviceID);

    if (index != -1) {
      await deviceBox.deleteAt(index);
      _devices.removeAt(index);
    }

    await deviceBox.close();
  }

  void clearRoomsDevice(int roomID) async{
    final Box<DeviceLight> deviceBox = await Hive.openBox<DeviceLight>('deviceLight');
    for(int i = 0; i < deviceBox.length; i++){
      if(deviceBox.getAt(i)?.roomID == roomID){
        await deviceBox.deleteAt(i);
        FavouriteHive.instance.deleteFavourite(deviceBox.getAt(i)!.deviceID);
      }
    }
    deviceBox.close();
  }

  Future<void> clearDatabase() async {
    final Box<DeviceLight> deviceBox = await Hive.openBox<DeviceLight>('deviceLight');
    await deviceBox.clear();
  }

  void setSchedState(int deviceID, bool schedState){
    for(int i = 0; i < _devices.length; i++){
      if(_devices[i].deviceID == deviceID){
        _devices[i].schedState = schedState;
      }
    }
  }

  void setStartTime(int deviceID, String startTime){
    for(int i = 0; i < _devices.length; i++){
      if(_devices[i].deviceID == deviceID){
        _devices[i].startTime = startTime;
      }
    }
  }

  void setEndTime(int deviceID, String endTime){
    for(int i = 0; i < _devices.length; i++){
      if(_devices[i].deviceID == deviceID){
        _devices[i].endTime = endTime;
      }
    }
  }

  void setPeriodicity(int deviceID, List<dynamic> periodicity){
    for(int i = 0; i < _devices.length; i++){
      if(_devices[i].deviceID == deviceID){
        _devices[i].periodicity = periodicity;
      }
    }
  }

  Future<void> editDevice(DeviceLight updatedDevice) async {
    for(int i = 0; i < _devices.length; i++){
      if(_devices[i].deviceID == updatedDevice.deviceID){
        _devices[i] = updatedDevice;
      }
    }
  }
}