import 'package:control_asistencia_app/app/controller/admin_controllers/admin_controller.dart';
import 'package:control_asistencia_app/app/view/screen/admin_screens/crud_worker_screens/listworker_screen.dart';
import 'package:control_asistencia_app/app/view/screen/admin_screens/listattendance_screen.dart';
import 'package:control_asistencia_app/app/view/screen/admin_screens/login_register_tabbar_screen.dart';
import 'package:control_asistencia_app/app/view/screen/settings_screen.dart';
import 'package:control_asistencia_app/app/view/widget/customdialog_widget.dart';
import 'package:control_asistencia_app/app/view_models/admin_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeAdminScreen extends StatefulWidget {
  const HomeAdminScreen({super.key});

  static const route = "/homeAdminScreen";

  @override
  State<HomeAdminScreen> createState() => _HomeAdminScreenState();
}

class _HomeAdminScreenState extends State<HomeAdminScreen> {
  final AdminController _adminController = AdminController();
  String? _nombre;
  String? _apellido;

  Future<AdminViewModel> getViewModelAdmin() async {
    AdminViewModel adminViewModel = await _adminController.getDataAdmin();
    return adminViewModel;
  }

  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getViewModelAdmin().then(
      (adminViewModel) {
        setState(() {
          _nombre = adminViewModel.nombre;
          _apellido = adminViewModel.apellido;
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Stack(
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
                  Text("$_nombre $_apellido",
                      style: TextStyle(fontSize: 18.sp)),
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
                        icon: Icon(Icons.list, size: 70.r, color: Colors.white),
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
                  margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
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
    );
  }
}
