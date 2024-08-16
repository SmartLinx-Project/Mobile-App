import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:smartlinx/pages/devicePage/widget/addDevicePopup/modalpopup_wid.dart';
import 'package:smartlinx/pages/devicePage/widget/hub-offline_wid.dart';
import 'package:smartlinx/pages/devicePage/widget/nothub.dart';
import 'package:smartlinx/pages/devicePage/widget/pageview_wid.dart';
import 'package:smartlinx/pages/devicePage/widget/room_dropdownmenu_wid.dart';
import 'package:smartlinx/pages/handleHomes/handle_homes.dart';
import 'package:smartlinx/pages/handleRooms/handle_room.dart';
import 'package:smartlinx/services/hiveMethod/home_hive.dart';
import 'package:smartlinx/services/hiveMethod/room_hive.dart';
import 'package:smartlinx/services/init_app.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:vibration/vibration.dart';
import '../../../services/hive.dart';
import 'home_dropdownmenu_wid.dart';

class HaveHUB extends StatefulWidget {
  final Function refreshPage;
  const HaveHUB({super.key, required this.refreshPage});
  @override
  HaveHUBState createState() => HaveHUBState();
}

class HaveHUBState extends State<HaveHUB> {
  PageController pageController = PageController();
  List<Home> homes = [];
  List<Room> rooms = [];
  late Home currentHome;
  late Room currentRoom;

  void init() {
    homes = HomeHive.instance.getAllHomes();
    currentHome =
        HomeHive.instance.getHomeFromID(HomeHive.instance.getCurrentHome()!);
    rooms = RoomHive.instance.getRoomsFromHomeID(currentHome.homeID);
    if (rooms.isNotEmpty) {
      currentRoom =
          RoomHive.instance.getRoomFromID(RoomHive.instance.getCurrentRoom()!);
      setInitialPage();
    }
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  Future<void> changeRoom(Room newRoom) async {
    List<Room> rooms = RoomHive.instance.getRoomsFromHomeID(newRoom.homeID);
    int pageIndex = rooms.indexWhere((room) => room.roomID == newRoom.roomID);

    if (pageIndex == -1) {
      return;
    }
    /*
    pageController.animateToPage(
      pageIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.bounceInOut,
    );
     */

    pageController.jumpToPage(pageIndex);

    setState(() {
      currentRoom = newRoom;
      currentHome = currentHome;
    });
  }

  void setInitialPage() {
    List<Room> rooms = RoomHive.instance.getRoomsFromHomeID(currentRoom.homeID);
    int pageIndex =
        rooms.indexWhere((room) => room.roomID == currentRoom.roomID);
    if (pageIndex == -1) {
      return;
    }
    pageController = PageController(initialPage: pageIndex);
  }

  void changeHome() {
    setState(() {});
  }

  void refreshPage() {
    widget.refreshPage();
  }

  Future<void> reloadPage() async {
    await InitApp().startInit();
    refreshPage();
  }

  @override
  Widget build(BuildContext context) {
    init();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 200.h, left: 110.w, right: 110.w),
            child: Row(
              children: [
                HomeDropDownMenuWidget(
                  refreshPageCallback: changeHome,
                ),
                const Spacer(),
                (currentHome.hubID != 0 &&
                        currentHome.hubState == true &&
                        rooms.isNotEmpty)
                    ? IconButton(
                        onPressed: () async {
                          AddDeviceModalPopup.show(context, refreshPage);
                          setState(() {
                            refreshPage();
                          });
                        },
                        icon: Icon(
                          Icons.add,
                          size: 120.sp,
                        ))
                    : Container(),
                PopupMenuButton<String>(
                  offset: const Offset(0, 50),
                  onSelected: (String result) {
                    if (result == "gestisci_stanze") {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              HandleRoom(
                                  home: HomeHive.instance.getHomeFromID(
                                      HomeHive.instance.getCurrentHome()!)),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        ),
                      );
                    } else if (result == "gestisci_case") {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              const HandleHomes(),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        ),
                      );
                    }
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      value: "gestisci_stanze",
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Text(
                          "Gestisci stanze",
                          style: TextStyle(
                            fontFamily: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.fontFamily,
                            color:
                                Theme.of(context).textTheme.displayLarge?.color,
                            fontWeight: FontWeight.w500,
                            fontSize: 50.sp,
                          ),
                        ),
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: "gestisci_case",
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Text(
                          "Gestisci case",
                          style: TextStyle(
                            fontFamily: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.fontFamily,
                            color:
                                Theme.of(context).textTheme.displayLarge?.color,
                            fontWeight: FontWeight.w500,
                            fontSize: 50.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50.h,
          ),
          if (currentHome.hubState == true)
            Padding(
              padding: EdgeInsets.only(left: 110.w),
              child: (rooms.isNotEmpty)
                  ? RoomDropDownMenuWidget(
                      refreshpageCallback: changeRoom,
                    )
                  : Container(),
            ),
          (currentHome.hubID != 0)
              ? Expanded(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 100.h,
                      ),
                      (currentHome.hubState == true)
                          ? Expanded(
                              child: (rooms.isNotEmpty)
                                  ? LiquidPullToRefresh(
                                      springAnimationDurationInMilliseconds:
                                          300,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                      backgroundColor:
                                          Theme.of(context).colorScheme.primary,
                                      onRefresh: () async {
                                        Vibration.vibrate(duration: 10);
                                        await reloadPage();
                                      },
                                      child: PageViewWidget(
                                        pageController: pageController,
                                        refreshPage: refreshPage,
                                      ),
                                    )
                                  : Center(
                                      child: Text(
                                        "Non hai ancora stanze",
                                        style: TextStyle(
                                          fontFamily: Theme.of(context)
                                              .textTheme
                                              .displayLarge
                                              ?.fontFamily,
                                          color: Theme.of(context)
                                              .textTheme
                                              .displayLarge
                                              ?.color,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 70.sp,
                                        ),
                                      ),
                                    ),
                            )
                          : Center(
                              child: HubOfflineWidget(
                                refreshPage: refreshPage,
                              ),
                            ),
                      (currentHome.hubState == true)
                          ? Center(
                              child: SmoothPageIndicator(
                                count: RoomHive.instance
                                    .getRoomsFromHomeID(currentHome.homeID)
                                    .length,
                                controller: pageController,
                                effect: ExpandingDotsEffect(
                                  activeDotColor:
                                      Theme.of(context).colorScheme.primary,
                                  dotColor:
                                      Theme.of(context).colorScheme.secondary,
                                  dotHeight: 30.h,
                                  dotWidth: 30.w,
                                ),
                              ),
                            )
                          : Container(),
                      SizedBox(
                        height: 100.h,
                      ),
                    ],
                  ),
                )
              : NotHub(
                  homeID: currentHome.homeID,
                  refreshPage: refreshPage,
                ),
        ],
      ),
    );
  }
}
