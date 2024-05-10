import 'package:hive/hive.dart';
import 'package:smartlinx/services/local_storage.dart';
import '../getinfo.dart';
import '../hive.dart';

class RoomHive {
  static final RoomHive _instance = RoomHive._();
  List<Room> _rooms = [];
  late int? currentRoom;

  RoomHive._() {
    _rooms = [];
    //_init();
  }

  static RoomHive get instance {
    return _instance;
  }

  Future<void> insertRoom(Room newRoom) async {
    var box = await Hive.openBox<Room>('room');
    box.add(newRoom);
  }

  Future<void> fillDatabase() async {
    await clearDatabase();
    List<Room> netRooms = GetInfo().getRooms();
    for(int i = 0; i < netRooms.length; i++){
      insertRoom(netRooms[i]);
    }
  }

  Future<void> init() async {
    await fillDatabase();
    await updateList();
    currentRoom = await LocalStorage().getIntegerValue('selectedRoom');
    // Verifica se currentRoom è null o non è presente in _rooms.name
    if(_rooms.isNotEmpty){
      if (currentRoom == null ||
          !_rooms.any((room) => room.roomID == currentRoom)) {
        await setCurrentRoom(_rooms[0].roomID);
        currentRoom = await LocalStorage().getIntegerValue('selectedRoom');
      }
    }
  }

  Future<void> updateList() async{
    _rooms.clear();
    final Box<Room> roomBox = await Hive.openBox<Room>('room');

    for (int i = 0; i < roomBox.length; i++) {
      _rooms.add(roomBox.getAt(i)!);
    }
    await roomBox.close();
  }

  Future<void> setCurrentRoom(int newValue) async {
    currentRoom = newValue;
    await LocalStorage().setIntegerValue('selectedRoom', newValue);
  }

  int? getCurrentRoom() {
    return currentRoom;
  }

  List<Room> getAllRooms() {
    return _rooms;
  }

  Room getRoomFromID(int roomID) {
    return _rooms.firstWhere((room) => room.roomID == roomID);
  }

  List<Room> getRoomsFromHomeID(int homeID) {
    List<Room> rooms = [];

    for (int i = 0; i < _rooms.length; i++) {
      if (_rooms[i].homeID == homeID) {
        rooms.add(_rooms[i]);
      }
    }

    return rooms;
  }

  Future<void> removeRoom(int roomID) async {
    final Box<Room> roomBox = await Hive.openBox<Room>('room');
    int indexToRemove = _rooms.indexWhere((room) => room.roomID == roomID);
    if (indexToRemove != -1) {
      _rooms.removeAt(indexToRemove);
      await roomBox.deleteAt(indexToRemove);
    }
    await roomBox.close();
  }


  Future<void> clearDatabase() async {
    final Box<Room> roomBox = await Hive.openBox<Room>('room');
    await roomBox.clear();
  }
}
