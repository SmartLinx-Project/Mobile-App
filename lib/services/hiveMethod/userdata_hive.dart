import 'package:hive/hive.dart';
import 'package:smartlinx/services/userdata.dart';
import '../getinfo.dart';
import '../hive.dart';

class FamilyMembersHive {
  static final FamilyMembersHive _instance = FamilyMembersHive._();
  late Box<FamilyMember> _userBox;
  late List<FamilyMember> _userList;

  FamilyMembersHive._() {
    _userList = [];
    //_init();
  }

  static FamilyMembersHive get instance {
    return _instance;
  }

  Future<void> fillDatabase() async {
    await clearDatabase();
    List<FamilyMember> netFamilyMembers = GetInfo().getFamilyMembers();
    for(int i = 0; i < netFamilyMembers.length; i++){
      if(netFamilyMembers[i].email != UserData().getEmail()){
        insertUser(netFamilyMembers[i]);
      }
    }
  }

  Future<void> init() async {
    await fillDatabase();
    _userBox = await Hive.openBox<FamilyMember>('familyMembers');
    _userList = _userBox.values.toList();
  }

  Future<void> insertUser(FamilyMember newUser) async {
    final Box<FamilyMember> userBox = await Hive.openBox<FamilyMember>('familyMembers');

    await userBox.add(newUser);
  }

  List<FamilyMember> getFamilyMembersFromHomeID(int homeID) {
    List<FamilyMember> filteredMembers = [];
    for (var member in _userList) {
      if (member.homeID == homeID) {
        filteredMembers.add(member);
      }
    }
    return filteredMembers;
  }

  Future<void> deleteUser(String email) async {
    var box = await Hive.openBox<FamilyMember>('familyMembers');
    var indexToDelete = -1;

    for (int i = 0; i < box.length; i++) {
      if (box.getAt(i)!.email == email) {
        indexToDelete = i;
        break;
      }
    }

    if (indexToDelete != -1) {
      await box.deleteAt(indexToDelete);
      _userList = _userBox.values.toList(); // Update the list after deletion
    }

    await box.close();
  }


  Future<void> editUser(FamilyMember user) async {
    var box = await Hive.openBox<FamilyMember>('familyMembers');
    for (int i = 0; i < box.length; i++) {
      if (user.email == box.getAt(i)!.email) {
        box.putAt(i, user);
      }
    }
    await box.close();
    await init();
  }

  Future<void> clearDatabase() async {
    final Box<FamilyMember> userBox = await Hive.openBox<FamilyMember>('familyMembers');
    await userBox.clear();
  }
}
