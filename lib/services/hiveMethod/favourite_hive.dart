import 'package:hive/hive.dart';
import '../getinfo.dart';
import '../hive.dart';

class FavouriteHive {
  static final FavouriteHive _instance = FavouriteHive._();
  List<Favourite> _favourite = [];

  FavouriteHive._() {
    _favourite = [];
    //_init();
  }

  static FavouriteHive get instance {
    return _instance;
  }

  Future<void> insertFavourite(Favourite newFavourite) async {
    var box = await Hive.openBox<Favourite>('favourite');
    box.add(newFavourite);

  }

  Future<void> newFavourite(Favourite newFavourite) async {
    bool find = false;
    for(int i = 0; i < _favourite.length; i++){
      if(_favourite[i].deviceID == newFavourite.deviceID){
        find = true;
      }
    }
    if(!find){
      var box = await Hive.openBox<Favourite>('favourite');
      box.add(newFavourite);
      _favourite.clear();
      for (int i = 0; i < box.length; i++) {
        _favourite.add(box.getAt(i)!);
      }
      box.close();
    }
  }

  Future<void> fillDatabase() async {
    await clearDatabase();
    List<Favourite> netFavourites = GetInfo().getFavourites();
    for(int i = 0; i < netFavourites.length; i++){
      insertFavourite(netFavourites[i]);
    }
  }

  Future<void> init() async {
    await fillDatabase();
    final Box<Favourite> favouriteBox =
        await Hive.openBox<Favourite>('favourite');
    _favourite.clear();
    for (int i = 0; i < favouriteBox.length; i++) {
      _favourite.add(favouriteBox.getAt(i)!);
    }
    await favouriteBox.close();
  }

  List<Favourite> getAllFavourite() {
    return _favourite;
  }

  Future<void> deleteFavourite(int deviceID) async {
    final Box<Favourite> favouriteBox =
        await Hive.openBox<Favourite>('favourite');

    for (int i = 0; i < favouriteBox.length; i++) {
      if (favouriteBox.getAt(i)?.deviceID == deviceID) {
        await favouriteBox.deleteAt(i);
        _favourite.removeAt(i);
      }
    }
    favouriteBox.clear();
  }

  Future<void> clearDatabase() async {
    final Box<Favourite> favouriteBox = await Hive.openBox<Favourite>('favourite');
    await favouriteBox.clear();
  }
}
