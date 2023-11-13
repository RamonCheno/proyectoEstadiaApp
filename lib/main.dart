// import 'package:control_asistencia_app/app/packages/packagelocal_controller.dart';
import 'package:control_asistencia_app/app/packages/packages_pub.dart';
import 'package:control_asistencia_app/app/packages/packageslocal_view.dart';
import 'package:control_asistencia_app/app/view/provider/adminprovider.dart';
import 'package:control_asistencia_app/app/view/provider/attendande_provider.dart';
import 'package:control_asistencia_app/app/view/screen/admin_screens/crud_worker_screens/addworker_screen.dart';
import 'package:control_asistencia_app/app/view/screen/admin_screens/crud_worker_screens/listworker_screen.dart';
import 'package:control_asistencia_app/app/view/screen/admin_screens/crud_worker_screens/updateworker_screen.dart';
import 'package:control_asistencia_app/app/view/screen/admin_screens/home_admin_tabbar_screen.dart';
import 'package:control_asistencia_app/app/view/screen/admin_screens/listattendance_screen.dart';
import 'package:control_asistencia_app/app/view/screen/admin_screens/perfile_user_screen.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'app/view/provider/image_provider.dart';
import 'app/view/provider/worker_provider.dart';
import 'app/view/screen/camera_screen.dart';

void main() async {
  await ScreenUtil.ensureScreenSize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // ChangeNotifierProvider(
  //   create: (context) => BluetoothController(),
  //   child: ,
  // ),

  await Future.delayed(const Duration(seconds: 3));
  FlutterNativeSplash.remove();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AttendanceProvider()),
        ChangeNotifierProvider(create: (context) => ImageProviders()),
        ChangeNotifierProvider(create: (context) => WorkerProvider()),
        ChangeNotifierProvider(create: (context) => AdminProvider()),
      ],
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
    HomeAdminTabBarScreen.route: (_) => const HomeAdminTabBarScreen(),
    // CheckInFingerPrintScreen.route: (_) => const CheckInFingerPrintScreen(),
    MoreOptionsScreen.route: (_) => const MoreOptionsScreen(),
    ListWorkerScreen.route: (_) => const ListWorkerScreen(),
    ListAttendance.route: (_) => const ListAttendance(),
    AddWorkerScreen.route: (_) => const AddWorkerScreen(),
    SettingsScreen.route: (_) => const SettingsScreen(),
    CameraScreen.route: (_) => const CameraScreen(),
    UpdateWorkerScreen.route: (_) => const UpdateWorkerScreen(),
    PerfilUserScreen.route: (_) => const PerfilUserScreen(),
    // ScanDevicesBluetoothScreen.route: (_) => const ScanDevicesBluetoothScreen(),
    // FingerPrintRegisterScreen.route: (_) => const FingerPrintRegisterScreen()
  };

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('es', 'MX'),
        ],
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
