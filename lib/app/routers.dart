import 'package:control_asistencia_app/app/packages/packageslocal_view.dart';

class Routers {
  get router => {
        HomeScreen.route: (_) => const HomeScreen(),
        HomeWorkerScreen.route: (_) => const HomeWorkerScreen(),
        TabBarLoginRegisterScreen.route: (_) =>
            const TabBarLoginRegisterScreen(),
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
        ReportsScreen.route: (_) => const ReportsScreen(),
      };
}
