import 'package:control_asistencia_app/view/screen/admin_screens/home_admin_screen.dart';
import 'package:control_asistencia_app/view/screen/admin_screens/login_admin_screen.dart';
import 'package:control_asistencia_app/view/screen/home_screen.dart';
import 'package:control_asistencia_app/view/screen/worker_screens/checkin_complete_screen.dart';
import 'package:control_asistencia_app/view/screen/worker_screens/checkin_method_screens/checkin_fingerprint_screen.dart';
import 'package:control_asistencia_app/view/screen/worker_screens/home_worker_screeen.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _router = {
    HomeScreen.route: (_) => const HomeScreen(),
    HomeWorkerScreen.route: (_) => const HomeWorkerScreen(),
    LoginAdminScreen.route: (_) => const LoginAdminScreen(),
    HomeAdminScreen.route: (_) => const HomeAdminScreen(),
    CheckInFingerPrintScreen.route: (_) => const CheckInFingerPrintScreen(),
    CheckInComplete.route: (_) => const CheckInComplete()
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
      initialRoute: LoginAdminScreen.route,
    );
  }
}
