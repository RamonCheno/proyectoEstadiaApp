import 'package:control_asistencia_app/app/packages/packagelocal_controller.dart';
import 'package:control_asistencia_app/app/packages/packages_pub.dart';
import 'package:control_asistencia_app/app/packages/packageslocal_view.dart';
import 'package:control_asistencia_app/app/view/screen/admin_screens/listattendance_screen.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  await ScreenUtil.ensureScreenSize();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
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
    TabBarLoginRegisterScreen.route: (_) => const TabBarLoginRegisterScreen(),
    LoginAdminScreen.route: (_) => const LoginAdminScreen(),
    RegisterAdminScreen.route: (_) => const RegisterAdminScreen(),
    HomeAdminScreen.route: (_) => const HomeAdminScreen(),
    // CheckInFingerPrintScreen.route: (_) => const CheckInFingerPrintScreen(),
    MoreOptionsScreen.route: (_) => const MoreOptionsScreen(),
    ListWorkerScreen.route: (_) => const ListWorkerScreen(),
    ListAttendance.route: (_) => const ListAttendance(),
    AddWorkerScreen.route: (_) => const AddWorkerScreen(),
    SettingsScreen.route: (_) => const SettingsScreen(),
    // ScanDevicesBluetoothScreen.route: (_) => const ScanDevicesBluetoothScreen(),
    // FingerPrintRegisterScreen.route: (_) => const FingerPrintRegisterScreen()
  };

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => MaterialApp(
        title: 'Asistencia Laboral',
        theme: ThemeData(
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        routes: _router,
        initialRoute: HomeScreen.route,
      ),
      designSize: const Size(360, 640),
    );
  }
}
