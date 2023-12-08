import 'package:control_asistencia_app/app/packages/packagelocal_provider.dart';
import 'package:control_asistencia_app/app/packages/packages_pub.dart';
import 'package:control_asistencia_app/app/packages/packageslocal_view.dart';
import 'package:control_asistencia_app/app/routers.dart';
import 'package:control_asistencia_app/dev/firebase_options_dev.dart';
import 'package:control_asistencia_app/prod/firebase_options_prod.dart';

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
        ChangeNotifierProvider(create: (_) => AttendanceProvider()),
        ChangeNotifierProvider(create: (_) => ImageProviders()),
        ChangeNotifierProvider(create: (_) => WorkerProvider()),
        ChangeNotifierProvider(create: (_) => AdminProvider()),
        ChangeNotifierProvider(create: (_) => UpdatePerfilProvider()),
        ChangeNotifierProvider(create: (_) => ServiceFoodProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final Routers routers = Routers();

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
        routes: routers.router,
        initialRoute: HomeScreen.route,
      ),
      designSize: const Size(360, 640),
    );
  }
}
