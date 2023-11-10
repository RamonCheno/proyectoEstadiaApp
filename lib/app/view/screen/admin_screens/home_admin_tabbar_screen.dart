import 'package:control_asistencia_app/app/controller/admin_controllers/admin_controller.dart';
import 'package:control_asistencia_app/app/packages/packageslocal_view.dart';
import 'package:control_asistencia_app/app/view/widget/customdialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeAdminTabBarScreen extends StatefulWidget {
  const HomeAdminTabBarScreen({super.key});

  @override
  State<HomeAdminTabBarScreen> createState() => _HomeAdminTabBarScreenState();
}

class _HomeAdminTabBarScreenState extends State<HomeAdminTabBarScreen> {
  int _currentIndex = 0;
  final AdminController _adminController = AdminController();

  final List<Widget> _page = const [
    HomeAdminScreen(),
  ];

  @override
  Widget build(BuildContext context) {
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
                                Navigator.of(context).pop();
                                _adminController.signOut();
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
      body: _page[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled, color: Colors.black),
            label: "Inicio",
            activeIcon: Icon(Icons.home_filled, color: Colors.orange),
          )
        ],
      ),
    );
  }
}
