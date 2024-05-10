import 'package:hive/hive.dart';
import 'package:smartlinx/services/getinfo.dart';
import 'package:smartlinx/services/local_storage.dart';
import 'package:smartlinx/services/weather.dart';
import '../hive.dart';

class HomeHive {
  static final HomeHive _instance = HomeHive._();
  List<Home> _homes = [];
  late int? currentHome;

  HomeHive._() {
    _homes = [];
    //_init();
  }

  static HomeHive get instance {
    return _instance;
  }

  Future<void> insertHome(Home newHome) async {
    var box = await Hive.openBox<Home>('home');
    box.add(newHome);
  }

  Future<void> fillDatabase() async {
    await clearDatabase();
    List<Home> netHomes = GetInfo().getHomes();
    for(int i = 0; i < netHomes.length; i++){
      insertHome(netHomes[i]);
    }
  }

  Future<void> init() async {
    await fillDatabase();
    await updateList();
    currentHome = await LocalStorage().getIntegerValue('selectedHome');

    // Verifica se currentHome è null o non è presente in _homes.name
    if(_homes.isNotEmpty){
      if (currentHome == null ||
          !_homes.any((home) => home.homeID == currentHome)) {
        await setCurrentHome(_homes[0].homeID);
        currentHome = await LocalStorage().getIntegerValue('selectedHome');
      }
    }
  }

  Future<void> updateList() async{
    final Box<Home> homeBox = await Hive.openBox<Home>('home');
    _homes.clear();
    for (int i = 0; i < homeBox.length; i++) {
      _homes.add(homeBox.getAt(i)!);
    }
    await homeBox.close();
  }

  Future<void> setCurrentHome(int newValue) async {
    currentHome = newValue;
    await LocalStorage().setIntegerValue('selectedHome', newValue);
    await WeatherService.instance.initWeather();
  }

  int? getCurrentHome() {
    return currentHome;
  }

  List<Home> getAllHomes() {
    return _homes;
  }

  Home getHomeFromID(int homeID) {
    return _homes.firstWhere((home) => home.homeID == homeID);
  }

  void removeHome(int homeID) async {
    final Box<Home> homeBox = await Hive.openBox<Home>('home');
    int indexToRemove = _homes.indexWhere((home) => home.homeID == homeID);
    if (indexToRemove != -1) {
      _homes.removeAt(indexToRemove);
      await homeBox.deleteAt(indexToRemove);
    }
    await homeBox.close();
  }

  Future<void> clearDatabase() async {
    final Box<Home> homeBox = await Hive.openBox<Home>('home');
    await homeBox.clear();
  }
}
