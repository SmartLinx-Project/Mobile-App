import 'package:flutter/material.dart';
import 'package:smartlinx/pages/homePage/widget/ishome.dart';
import 'package:smartlinx/pages/homePage/widget/nothome.dart';
import 'package:smartlinx/pages/sharedWidget/bottomnavbar_wid.dart';
import 'package:smartlinx/services/hiveMethod/home_hive.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late bool haveHome;

  @override
  void initState() {
    if(HomeHive.instance.getAllHomes().isNotEmpty){
      haveHome = true;
    }else{
      haveHome = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: (haveHome)
            ? Theme.of(context).colorScheme.onSurface
            : Theme.of(context).colorScheme.background,
        bottomNavigationBar: const BotNavBarWidget(
          index: 0,
        ),
        body: (haveHome) ? const IsHomeWidget() : NotHome());
  }
}
