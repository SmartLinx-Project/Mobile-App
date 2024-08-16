import 'package:hive/hive.dart';
import '../getinfo.dart';
import '../hive.dart';

class RoutineHive {
  static final RoutineHive _instance = RoutineHive._();
  List<Routine> routines = [];

  RoutineHive._() {
    routines = [];
    //_init();
  }

  static RoutineHive get instance {
    return _instance;
  }

  Future<void> insertRoutine(Routine newRoutine) async {
    var box = await Hive.openBox<Routine>('routine');
    box.add(newRoutine);
    await loadFromInternalDB();
  }

  Future<void> fillDatabase() async {
    await clearDatabase();
    List<Routine> netRoutines = GetInfo().getRoutines();
    for (int i = 0; i < netRoutines.length; i++) {
      insertRoutine(netRoutines[i]);
    }
  }

  Future<void> init() async {
    await fillDatabase();
    await loadFromInternalDB();
  }

  Future<void> loadFromInternalDB() async {
    final Box<Routine> routineBox = await Hive.openBox<Routine>('routine');
    routines.clear();
    for (int i = 0; i < routineBox.length; i++) {
      routines.add(routineBox.getAt(i)!);
    }
  }

  List<Routine> getAllRoutines() {
    return routines;
  }

  Routine getRoutineFromID(int routineID) {
    return routines.firstWhere((routine) => routine.routineID == routineID);
  }

  Future<void> removeRoutine(int routineID) async {
    final Box<Routine> routineBox = await Hive.openBox<Routine>('routine');
    int index = routines.indexWhere((routine) => routine.routineID == routineID);

    if (index != -1) {
      await routineBox.deleteAt(index);
      routines.removeAt(index);
    }
    await routineBox.close();
  }

  Future<void> clearDatabase() async {
    final Box<Routine> routineID = await Hive.openBox<Routine>('routine');
    await routineID.clear();
  }

  Future<void> editRoutine(Routine updatedRoutine) async {
    final Box<Routine> routineBox = await Hive.openBox<Routine>('routine');
    int index = RoutineHive.instance.getAllRoutines().indexWhere((routine) => routine.routineID == updatedRoutine.routineID);
    print('index: ' + index.toString());
    await routineBox.putAt(index, updatedRoutine);
    await routineBox.close();
    await loadFromInternalDB();
  }

  int getNewID() {
    int maxID = 0;
    if (routines.isNotEmpty) {
      for (int i = 0; i < routines.length; i++) {
        if (routines[i].routineID > maxID) {
          maxID = routines[i].routineID;
        }
      }
      maxID = maxID + 1;
      return maxID;
    } else {
      return 0;
    }
  }
}
