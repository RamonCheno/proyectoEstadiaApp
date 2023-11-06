import 'package:control_asistencia_app/app/controller/admin_controllers/admin_controller.dart';
import 'package:control_asistencia_app/app/view/screen/admin_screens/crud_worker_screens/listworker_screen.dart';
import 'package:control_asistencia_app/app/view/screen/admin_screens/listattendance_screen.dart';
import 'package:control_asistencia_app/app/view/screen/admin_screens/login_register_tabbar_screen.dart';
import 'package:control_asistencia_app/app/view/screen/settings_screen.dart';
import 'package:control_asistencia_app/app/view/widget/customdialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeAdminScreen extends StatefulWidget {
  const HomeAdminScreen({super.key});
  static const route = "/homeAdminScreen";

  @override
  State<HomeAdminScreen> createState() => _HomeAdminScreenState();
}

class _HomeAdminScreenState extends State<HomeAdminScreen> {
  AdminController adminController = AdminController();

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
        width: 0.5.sh,
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
                  height: 120.h,
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
                                adminController.signOut();
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
          Column(
            children: [
              Container(
                margin: EdgeInsets.all(15.w),
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                width: media.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15).w,
                  color: const Color(0XFFF4F4F4),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0.0, 4.0),
                        blurRadius: 5.0),
                  ],
                ),
                child: Row(
                  children: [
                    Material(
                      color: const Color(0xffE1E1E1),
                      shape: const CircleBorder(),
                      child: Icon(
                        Icons.person_outline,
                        size: 60.r,
                      ),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Text("Admin Prueba", style: TextStyle(fontSize: 18.sp)),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    height: 145.h,
                    width: 145.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15).w,
                      color: const Color(0XFFF4F4F4),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0.0, 4.0),
                            blurRadius: 5.0),
                      ],
                    ),
                    margin:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                    child: Column(
                      children: [
                        IconButton(
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(
                              Color(0xff990303),
                            ),
                          ),
                          icon:
                              Icon(Icons.list, size: 70.r, color: Colors.white),
                          onPressed: () => Navigator.of(context)
                              .pushNamed(ListAttendance.route),
                        ),
                        Text("Asistencia", style: TextStyle(fontSize: 14.sp)),
                      ],
                    ),
                  ),
                  Container(
                    height: 145.h,
                    width: 145.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15).w,
                      color: const Color(0XFFF4F4F4),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0.0, 4.0),
                            blurRadius: 5.0),
                      ],
                    ),
                    margin:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                    child: Column(
                      children: [
                        IconButton(
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(
                              Color(0xff990303),
                            ),
                          ),
                          icon: Icon(Icons.description_outlined,
                              size: 70.r, color: Colors.white),
                          onPressed: () =>
                              debugPrint("Boton reportes presionado"),
                        ),
                        Text("Reportes", style: TextStyle(fontSize: 14.sp)),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    height: 145.h,
                    width: 145.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15).w,
                      color: const Color(0XFFF4F4F4),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0.0, 4.0),
                            blurRadius: 5.0),
                      ],
                    ),
                    margin:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                    child: Column(
                      children: [
                        IconButton(
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(
                              Color(0xff990303),
                            ),
                          ),
                          icon: Icon(Icons.groups_outlined,
                              size: 70.r, color: Colors.white),
                          onPressed: () => Navigator.of(context)
                              .pushNamed(ListWorkerScreen.route),
                        ),
                        Text("Trabajadores", style: TextStyle(fontSize: 14.sp)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
