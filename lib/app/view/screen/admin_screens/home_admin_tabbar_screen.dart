import 'package:control_asistencia_app/app/controller/admin_controllers/admin_controller.dart';
import 'package:control_asistencia_app/app/packages/packages_pub.dart';
import 'package:control_asistencia_app/app/packages/packageslocal_view.dart';
import 'package:control_asistencia_app/app/view/screen/admin_screens/perfile_user_screen.dart';
import 'package:control_asistencia_app/app/view/widget/customdialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeAdminTabBarScreen extends StatefulWidget {
  const HomeAdminTabBarScreen({super.key});
  static const String route = "/tabHomeAdminScreen";

  @override
  State<HomeAdminTabBarScreen> createState() => _HomeAdminTabBarScreenState();
}

class _HomeAdminTabBarScreenState extends State<HomeAdminTabBarScreen> {
  int _currentIndex = 0;
  final AdminController _adminController = AdminController();

  final List<Widget> _page = const [HomeAdminScreen(), PerfilUserScreen()];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Asistencia Laboral",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xffD9D9D9),
      ),
      drawer: Drawer(
        width: 0.8.sw,
        child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0X00990303), Color(0xff990303)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                Container(
                  height: 0.18.sh,
                  margin: EdgeInsets.only(top: 30.h),
                  child: DrawerHeader(
                    child: Text(
                      maxLines: 2,
                      'Control de asistencia Laboral'.toUpperCase(),
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                          fontSize: 16.sp),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.settings_outlined,
                            size: 26.r, color: Colors.black),
                        title: Text(
                          'Configuracion',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500),
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed(SettingsScreen.route);
                        },
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.exit_to_app_outlined,
                      size: 26.r, color: Colors.white),
                  title: Text(
                    'Cerrar Sesión',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return CustomDialogWidget(
                          title: 'Cerrar Sesión',
                          messagge: Text('¿Seguro que quiere Cerrar sesión?',
                              style: TextStyle(fontSize: 16.sp)),
                          iconData:
                              Icon(Icons.exit_to_app_outlined, size: 26.r),
                          actions: [
                            TextButton(
                              child: Text('Aceptar',
                                  style: TextStyle(fontSize: 14.sp)),
                              onPressed: () {
                                // final provider = Provider.of<AdminProvider>(
                                //     context,
                                //     listen: false);
                                Navigator.of(context).pop();
                                _adminController.signOut();
                                // provider.clear();
                                Navigator.of(context).pushReplacementNamed(
                                    TabBarLoginRegisterScreen.route);
                              },
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancelar',
                                  style: TextStyle(fontSize: 14.sp)),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            )),
      ),
      body: Stack(
        children: [
          Container(
            width: media.width,
            height: media.height,
            color: const Color(0xffD9D9D9),
          ),
          _page[_currentIndex]
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey.shade600,
        selectedFontSize: 14.0.sp,
        unselectedFontSize: 12.0.sp,
        iconSize: 24.0.r,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, color: Colors.black),
            label: "Inicio",
            activeIcon: Icon(Icons.home, color: Colors.orange),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline, color: Colors.black),
            label: "Perfil",
            activeIcon: Icon(Icons.person, color: Colors.orange),
          )
        ],
      ),
    );
  }
}
