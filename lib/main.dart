import 'package:control_asistencia_app/app/packages/packages_pub.dart';
import 'package:control_asistencia_app/app/packages/packageslocal_view.dart';
import 'package:control_asistencia_app/app/view/provider/perfil_provide.dart';
import 'package:control_asistencia_app/app/view/screen/admin_screens/crud_admin/edit_info_admin_screen.dart';
import 'package:control_asistencia_app/app/view/screen/worker_screens/checkin_method_screens/registerattendance_screen.dart';
import 'package:control_asistencia_app/dev/firebase_options_dev.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:control_asistencia_app/app/view/provider/image_provider.dart';
import 'package:control_asistencia_app/app/view/provider/worker_provider.dart';
import 'package:control_asistencia_app/app/view/screen/camera_screen.dart';
import 'package:flutter/foundation.dart';

void main() async {
  await ScreenUtil.ensureScreenSize();
  if (kDebugMode || kProfileMode) {
    debugPrint("Aplicacion ejecutado en depuracion");
    await Firebase.initializeApp(
      options: DefaultFirebaseOptionsDev.currentPlatform,
    );
  } else {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptionsProd.currentPlatform,
    );
    debugPrint("Aplicacion ejecutado en produccion");
  }
  debugPrint("Depuracion: $kDebugMode");

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Future.delayed(const Duration(seconds: 3));
  FlutterNativeSplash.remove();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AttendanceProvider()),
        ChangeNotifierProvider(create: (context) => ImageProviders()),
        ChangeNotifierProvider(create: (context) => WorkerProvider()),
        ChangeNotifierProvider(create: (context) => AdminProvider()),
        ChangeNotifierProvider(create: (context) => UpdatePerfilProvider()),
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
    HomeAdminScreen.route: (_) => HomeAdminScreen(),
    ListWorkerScreen.route: (_) => const ListWorkerScreen(),
    ListAttendance.route: (_) => const ListAttendance(),
    AddWorkerScreen.route: (_) => const AddWorkerScreen(),
    SettingsScreen.route: (_) => const SettingsScreen(),
    CameraScreen.route: (_) => const CameraScreen(),
    UpdateWorkerScreen.route: (_) => const UpdateWorkerScreen(),
    PerfilUserScreen.route: (_) => PerfilUserScreen(),
    EditInfoAdminScreen.route: (_) => const EditInfoAdminScreen(),
    RegisterAttendanceScreen.route: (_) => const RegisterAttendanceScreen(),
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
