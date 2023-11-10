import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:control_asistencia_app/app/controller/attendance_controllers/attendance_controller.dart';
import 'package:control_asistencia_app/app/view/provider/attendande_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:control_asistencia_app/app/view_models/attendance_viewmodel.dart';
import 'package:intl/intl.dart';

class ListAttendance extends StatefulWidget {
  const ListAttendance({super.key});
  static const route = "/listAttendanceWorker";

  @override
  State<ListAttendance> createState() => _ListAttendanceState();
}

class _ListAttendanceState extends State<ListAttendance> {
  AttendanceProvider attendanceProvider = AttendanceProvider();
  final AttendanceController _attendanceController = AttendanceController();

  DateFormat dateFormat = DateFormat('dd-MM-yyyy');
  String dateNowText = '';
  int attendancelength = 0;

  Future<DateTime?> _selectedInitialDay(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      locale: const Locale("es", "MX"),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023, 10, 15),
      lastDate: DateTime(2099),
    );
    return picked;
  }

  void selectDay() async {
    DateTime? selectedDate = await _selectedInitialDay(context);
    if (selectedDate != null) {
      setState(() {
        dateNowText = dateFormat.format(selectedDate);
      });
      _getListAttendance().then(
        (listAttendance) => setState(
          () {
            attendancelength = listAttendance.length;
          },
        ),
      );
    }
  }

  Future<List<AttendanceViewModel>> _getListAttendance() async {
    List<AttendanceViewModel> attendanceViewModelList =
        await _attendanceController.getListAttendanceViewModel(dateNowText);
    return attendanceViewModelList;
  }

  @override
  void initState() {
    super.initState();
    dateNowText = dateFormat.format(DateTime.now());
    _getListAttendance().then((attendanceList) {
      setState(() {
        attendancelength = attendanceList.length;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Asistencia",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xffEBEBEB),
        actions: [
          IconButton(
              onPressed: () {
                _getListAttendance().then((attendanceList) {
                  setState(() {
                    attendancelength = attendanceList.length;
                  });
                });
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      backgroundColor: const Color(0xffEBEBEB),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15).r,
              color: const Color(0XFFF4F4F4),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0.0, 4.0),
                  blurRadius: 5.0,
                ),
              ],
            ),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 10.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: selectDay,
                        icon: const Icon(Icons.date_range),
                        iconSize: 20.h,
                      ),
                      Text(
                        dateNowText,
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.groups_2,
                          color: const Color(0xff757575), size: 20.h),
                      10.horizontalSpace,
                      Text(
                        "$attendancelength",
                        style: TextStyle(fontSize: 14.sp),
                      ),
                      10.horizontalSpace,
                    ],
                  ),
                ],
              ),
            ),
          ),
          10.verticalSpace,
          Expanded(
              child: FutureBuilder(
            future: _getListAttendance(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(color: Color(0xffF69100)),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                List<AttendanceViewModel> attendanceViewModelList =
                    snapshot.data as List<AttendanceViewModel>;
                return attendanceViewModelList.isEmpty
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(
                              color: Color(0xffF69100),
                            ),
                            Text("No hay asistencias registradas"),
                          ],
                        ),
                      )
                    : ListView.separated(
                        itemBuilder: (context, index) {
                          final AttendanceViewModel attendanceViewModel =
                              attendanceViewModelList[index];
                          String checkInHour = attendanceViewModel.checkInHour;
                          String firstNameWorker =
                              attendanceViewModel.firstNameWorker;
                          String lastNameWorker =
                              attendanceViewModel.lastNameWorker;
                          String urlImage = attendanceViewModel.urlPhoto;
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 10.w),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15).r,
                                color: const Color(0XFFF4F4F4),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(0.0, 3.0),
                                      blurRadius: 1),
                                ]),
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 25.r,
                                backgroundColor: const Color(0xffE1E1E1),
                                foregroundImage: urlImage.isNotEmpty
                                    ? CachedNetworkImageProvider(urlImage)
                                    : null,
                                backgroundImage: urlImage.isNotEmpty
                                    ? null
                                    : const AssetImage(
                                        "assets/images/usuario.png"),
                              ),
                              title: Text("$firstNameWorker $lastNameWorker"),
                              subtitle: Text(checkInHour),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            10.verticalSpace,
                        itemCount: attendanceViewModelList.length,
                      );
              }
            },
          )),
        ],
      ),
    );
  }
}
