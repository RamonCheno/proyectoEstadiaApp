import 'package:control_asistencia_app/app/model/api/http_request.dart';
import 'package:control_asistencia_app/app/packages/packageslocal.dart';
import 'package:flutter/material.dart';

void main() async {
  HttpRequest.configureDio();
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
    CheckInComplete.route: (_) => const CheckInComplete(),
    MoreOptionsScreen.route: (_) => const MoreOptionsScreen(),
    ListWorkerScreen.route: (_) => const ListWorkerScreen(),
    AddWorkerScreen.route: (_) => const AddWorkerScreen(),
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
