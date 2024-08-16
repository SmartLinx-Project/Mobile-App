import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_wear_os_connectivity/flutter_wear_os_connectivity.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:smartlinx/pages/splashScreen/splashscreen_page.dart';
import 'package:smartlinx/services/hive.dart';
import 'package:smartlinx/services/wearable/receiver.dart';
import 'firebase_options.dart';
import 'package:smartlinx/theme/dark_theme.dart';
import 'package:smartlinx/theme/light_theme.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Hive.initFlutter();
  Hive.registerAdapter(HomeAdapter());
  Hive.registerAdapter(RoomAdapter());
  Hive.registerAdapter(FavouriteAdapter());
  Hive.registerAdapter(FamilyMemberAdapter());
  Hive.registerAdapter(DeviceLightAdapter());
  Hive.registerAdapter(DevicePlugAdapter());
  Hive.registerAdapter(DeviceThermostatAdapter());
  Hive.registerAdapter(RoutineAdapter());

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
  await requestCameraPermission();
  checkWearable();
}

void checkWearable() async{
  FlutterWearOsConnectivity flutterWearOsConnectivity =
  FlutterWearOsConnectivity();
  flutterWearOsConnectivity.configureWearableAPI();
  List<WearOsDevice> connectedDevices = await flutterWearOsConnectivity.getConnectedDevices();
  flutterWearOsConnectivity.dispose();
  if(connectedDevices.isNotEmpty){
    WearableReceiver().startListen();
  }
}

Future<void> requestCameraPermission() async {
  // Verifica se il permesso è già stato concesso
  PermissionStatus status = await Permission.camera.status;

  if (!status.isGranted) {
    // Se il permesso non è stato concesso, richiedilo all'utente
    status = await Permission.camera.request();

    if (!status.isGranted) {
      // Se l'utente ha negato il permesso, gestisci di conseguenza
      // Puoi mostrare un messaggio di avviso o gestire la situazione di altro tipo
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartLinx',
      theme: lightTheme,
      darkTheme: darkTheme,
      home: ScreenUtilInit(
        designSize: const Size(1440, 3120),
        builder: (BuildContext context, Widget? child) {
          return const SplashScreen();
        },
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
