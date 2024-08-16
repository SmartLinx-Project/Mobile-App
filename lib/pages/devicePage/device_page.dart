import 'package:flutter/material.dart';
import 'package:smartlinx/pages/sharedWidget/bottomnavbar_wid.dart';
import 'package:smartlinx/pages/devicePage/widget/havehub.dart';
import 'package:smartlinx/pages/devicePage/nothome.dart';
import 'package:smartlinx/services/hiveMethod/home_hive.dart';
import 'package:smartlinx/services/hiveMethod/room_hive.dart';

import '../../services/hive.dart';

class DevicePage extends StatefulWidget {
  const DevicePage({super.key});

  @override
  State<DevicePage> createState() => _DevicePageState();
}

class _DevicePageState extends State<DevicePage> {
  bool haveHome = false;

  void checkHome() {
    if (HomeHive.instance.getAllHomes().isNotEmpty) {
      haveHome = true;
      checkCurrentHome();
    } else {
      haveHome = false;
    }
  }

  void checkCurrentHome(){
    Home currentHome = HomeHive.instance.getHomeFromID(HomeHive.instance.getCurrentHome()!);
    List<Home> homes = HomeHive.instance.getAllHomes();
    bool findHome = false;

    for(int i = 0; i < homes.length; i++){
      if(homes[i].homeID == currentHome.homeID){
        findHome = true;
        break;
      }
    }
    if(!findHome){
      List<Room> newCurrentRoom = RoomHive.instance.getRoomsFromHomeID(homes[0].homeID);
      if(homes.isNotEmpty){
        HomeHive.instance.setCurrentHome(homes[0].homeID);
        RoomHive.instance.setCurrentRoom(newCurrentRoom[0].roomID);
      }
    }
  }

  void refreshPage(){
    setState(() {
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    checkHome();
    return Scaffold(
      bottomNavigationBar: const BotNavBarWidget(index: 3),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: (haveHome) ? HaveHUB(refreshPage: refreshPage,) : const NotHome(),
    );
  }
}
