import 'package:control_asistencia_app/app/controller/settings_controllers/bluetooth_controller.dart';
// import 'package:control_asistencia_app/app/model/api/http_request.dart';
import 'package:control_asistencia_app/app/packages/packageslocal.dart';
import 'package:control_asistencia_app/app/view/screen/admin_screens/fingerprintregister.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app/view/screen/scan_devices_bluetooth_screen.dart';
import 'app/view/screen/settings_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // HttpRequest.configureDio();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => BluetoothController(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _router = {
    HomeScreen.route: (_) => const HomeScreen(),
    HomeWorkerScreen.route: (_) => const HomeWorkerScreen(),
    LoginAdminScreen.route: (_) => const LoginAdminScreen(),
    HomeAdminScreen.route: (_) => const HomeAdminScreen(),
    CheckInFingerPrintScreen.route: (_) => const CheckInFingerPrintScreen(),
    CheckInComplete.route: (_) => const CheckInComplete(),
    MoreOptionsScreen.route: (_) => const MoreOptionsScreen(),
    ListWorkerScreen.route: (_) => const ListWorkerScreen(),
    AddWorkerScreen.route: (_) => const AddWorkerScreen(),
    SettingsScreen.route: (_) => const SettingsScreen(),
    // DevicesBluetoothSearchScreen.route: (_) =>
    //     const DevicesBluetoothSearchScreen(),
    ScanDevicesBluetoothScreen.route: (_) => const ScanDevicesBluetoothScreen(),
    FingerPrintRegisterScreen.route: (_) => const FingerPrintRegisterScreen()
  };

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Asistencia Laboral',
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      routes: _router,
      initialRoute: HomeScreen.route,
    );
  }
}
