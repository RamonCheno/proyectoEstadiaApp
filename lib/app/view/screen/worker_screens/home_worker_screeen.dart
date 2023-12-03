import 'package:control_asistencia_app/app/view/screen/worker_screens/checkin_method_screens/registerattendance_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeWorkerScreen extends StatelessWidget {
  const HomeWorkerScreen({super.key});
  static const route = "/homeWorkScreen";

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Asistencia laboral",
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xffEBEBEB),
        ),
        backgroundColor: const Color(0xffEBEBEB),
        body: SizedBox(
          height: media.height,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 100.h),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        IconButton(
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(
                              Color(0xff28C925),
                            ),
                          ),
                          onPressed: () => Navigator.of(context).pushNamed(
                              RegisterAttendanceScreen.route,
                              arguments: <String, dynamic>{"title": "entrada"}),
                          icon: Icon(Icons.check,
                              color: Colors.white, size: 50.r),
                        ),
                        Text(
                          "Entrada",
                          style: TextStyle(
                            fontSize: 16.sp,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 50.w),
                    ),
                    Column(
                      children: [
                        IconButton(
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(
                              Color(0xff990303),
                            ),
                          ),
                          onPressed: () => Navigator.of(context).pushNamed(
                              RegisterAttendanceScreen.route,
                              arguments: <String, dynamic>{"title": "salida"}),
                          icon: Icon(Icons.close,
                              color: Colors.white, size: 50.r),
                        ),
                        Text(
                          "Salida",
                          style: TextStyle(
                            fontSize: 16.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 60.h),
                ),
                IconButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(
                      Color(0xffC99B25),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                        RegisterAttendanceScreen.route,
                        arguments: <String, dynamic>{"title": "comida"});
                  },
                  icon: Icon(Icons.fastfood_outlined,
                      color: Colors.white, size: 50.r),
                ),
                Text(
                  "Comida",
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
