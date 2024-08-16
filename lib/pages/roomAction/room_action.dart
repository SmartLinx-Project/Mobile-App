import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/pages/handleRooms/widget/delete_room_button.dart';
import 'package:smartlinx/pages/handleRooms/widget/save_room_button.dart';

class RoomAction extends StatelessWidget {
  final String roomName;
  final String home;
  final int nMember;

  const RoomAction({
    super.key,
    required this.roomName,
    required this.home,
    required this.nMember,
  });

  @override
  Widget build(BuildContext context) {
    final newRoomName = TextEditingController();
    newRoomName.text = roomName;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Gestisci stanza"),
        titleTextStyle: TextStyle(
          fontFamily: Theme.of(context).textTheme.displayMedium?.fontFamily,
          color: Theme.of(context).textTheme.displayMedium?.color,
          fontSize: 75.sp,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(50.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20.h),
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.r),
                color: Theme.of(context).colorScheme.onSurface,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: newRoomName,
                          decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).iconTheme.color!.withOpacity(0.8),
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).iconTheme.color!.withOpacity(0.8),
                              ),
                            ),
                            hintStyle: TextStyle(
                              fontFamily: Theme.of(context).textTheme.displayMedium?.fontFamily,
                              color: Theme.of(context).textTheme.displayLarge?.color!.withOpacity(0.9),
                              fontSize: 70.sp,
                            ),
                            labelStyle: TextStyle(
                              height: -0.5.h,

                              fontFamily: Theme.of(context).textTheme.displayMedium?.fontFamily,
                              color: Theme.of(context).textTheme.displayLarge?.color!.withOpacity(0.9),
                              fontSize: 70.sp,
                            ),
                            labelText: 'Nome Stanza',
                          ),
                          style: TextStyle(
                            fontFamily: Theme.of(context).textTheme.displayMedium?.fontFamily,
                            color: Theme.of(context).textTheme.displayLarge?.color!.withOpacity(0.9),
                            fontSize: 70.sp,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.edit),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    'Casa',
                    style: TextStyle(
                      fontFamily: Theme.of(context).textTheme.displayMedium?.fontFamily,
                      color: Theme.of(context).textTheme.displayMedium?.color,
                      fontSize: 70.sp,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    home,
                    style: TextStyle(
                      fontFamily: Theme.of(context).textTheme.displayMedium?.fontFamily,
                      color: Theme.of(context).textTheme.displayMedium?.color,
                      fontSize: 60.sp,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Divider(
                    thickness: 1.25,
                    color: Theme.of(context).iconTheme.color!.withOpacity(0.8),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            const Spacer(),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 150.h),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            EliminaStanzaButton(),
            SaveRoomButton(),
          ],
        ),
      ),
    );
  }
}
