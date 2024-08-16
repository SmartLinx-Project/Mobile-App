
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info/package_info.dart';
import 'package:smartlinx/services/http.dart';
import 'package:url_launcher/url_launcher.dart';

class Updater {
  Future<void> checkUpdate(context) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appVersion = packageInfo.version;
    Map<String, dynamic> json = await HttpService().getLatestVersion();
    String newVersion = json['version'];
    String titlePatch = json['title'];
    String notePatch = json['note'];
    if (newVersion != appVersion) {
      await showUpdatePopup(context, newVersion, titlePatch, notePatch);
    }
  }

  Future<bool?> showUpdatePopup(context, newVersion, titlePatch, notePatch) async {
    return await showDialog(
      context: context,
      builder: (context) => Material(
          type: MaterialType.transparency,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSurface,
                borderRadius: BorderRadius.circular(70.r),
              ),
              height: MediaQuery.of(context).size.height / 1.9,
              width: MediaQuery.of(context).size.width / 1.4,
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 8,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(70.r),
                            topLeft: Radius.circular(70.r))),
                    child: Icon(Icons.info_outline,
                        size: 200.sp,
                        color:
                            Theme.of(context).iconTheme.color?.withOpacity(0.8)),
                  ),
                  SizedBox(
                    height: 100.h,
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 60.w),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "UPDATE",
                                style: TextStyle(
                                  fontFamily: Theme.of(context)
                                      .textTheme
                                      .displayLarge
                                      ?.fontFamily,
                                  color: Theme.of(context)
                                      .textTheme
                                      .displayLarge
                                      ?.color,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 60.sp,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              const Spacer(),
                              Text(
                                "v$newVersion",
                                style: TextStyle(
                                  fontFamily: Theme.of(context)
                                      .textTheme
                                      .displayLarge
                                      ?.fontFamily,
                                  color: Theme.of(context)
                                      .textTheme
                                      .displayLarge
                                      ?.color,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 60.sp,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 150.h,
                          ),
                          Row(
                            children: [
                              Text(
                                titlePatch,
                                style: TextStyle(
                                  fontFamily: Theme.of(context)
                                      .textTheme
                                      .displayLarge
                                      ?.fontFamily,
                                  color: Theme.of(context)
                                      .textTheme
                                      .displayLarge
                                      ?.color,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 55.sp,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              const Spacer(),
                            ],
                          ),
                          SizedBox(
                            height: 40.h,
                          ),
                          Text(
                            notePatch,
                            style: TextStyle(
                              fontFamily: Theme.of(context)
                                  .textTheme
                                  .displayLarge
                                  ?.fontFamily,
                              color:
                                  Theme.of(context).textTheme.displayLarge?.color,
                              fontWeight: FontWeight.normal,
                              fontSize: 55.sp,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: 300.h,
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          width: 2)),
                                  height: 135.h,
                                  width: 400.w,
                                  child: Center(
                                    child: Text(
                                      "PIÙ TARDI",
                                      style: TextStyle(
                                        fontFamily: Theme.of(context)
                                            .textTheme
                                            .displayLarge
                                            ?.fontFamily,
                                        color:
                                            Theme.of(context).colorScheme.primary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 50.sp,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () async {
                                  final Uri url =
                                      Uri.parse('https://smartlinx.it#download');
                                  if (!await launchUrl(url)) {
                                    throw Exception('Could not launch $url');
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          width: 2)),
                                  height: 135.h,
                                  width: 400.w,
                                  child: Center(
                                    child: Text(
                                      "AGGIORNA",
                                      style: TextStyle(
                                        fontFamily: Theme.of(context)
                                            .textTheme
                                            .displayLarge
                                            ?.fontFamily,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .background,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 50.sp,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ))
                ],
              ),
            ),
          )),
    );
  }
}
