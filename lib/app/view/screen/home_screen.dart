// import 'package:control_asistencia_app/app/view/screen/admin_screens/login_admin_screen.dart';
import 'package:control_asistencia_app/app/view/screen/worker_screens/home_worker_screeen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'admin_screens/login_register_tabbar_screen.dart';
// import 'scan_devices_bluetooth_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const route = "/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffEBEBEB),
        // actions: [
        //   IconButton(
        //     onPressed: () =>
        //         Navigator.of(context).pushNamed(CameraScreen.route),
        //     icon: const Icon(Icons.camera, size: 34),
        //   ),
        // ],
      ),
      backgroundColor: const Color(0xffEBEBEB),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 14.h),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 65.r,
                    child: ClipOval(
                        child: Image(
                      image: const AssetImage(
                          "assets/images/logo_grupo_mexico.png"),
                      fit: BoxFit.cover,
                      width: 130.w,
                      height: 130.h,
                    )),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Text(
                    "Control de asistencia laboral",
                    style:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 60.h),
              child: Column(
                children: [
                  ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll<Color>(Color(0xffD9D9D9))),
                    onPressed: () {
                      Navigator.pushNamed(context, HomeWorkerScreen.route);
                    },
                    child: Text(
                      "Personal",
                      style: TextStyle(color: Colors.black, fontSize: 16.sp),
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll<Color>(Color(0xffD9D9D9))),
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(TabBarLoginRegisterScreen.route);
                    },
                    child: Text(
                      "Recursos Humanos",
                      style: TextStyle(color: Colors.black, fontSize: 16.sp),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
