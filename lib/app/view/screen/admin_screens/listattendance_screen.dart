import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:control_asistencia_app/app/controller/attendance_controllers/attendance_controller.dart';
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

class _ListAttendanceState extends State<ListAttendance>
    with AfterLayoutMixin<ListAttendance> {
  DateFormat dateFormat = DateFormat('dd-MM-yyyy');
  String dateNowText = '';
  int attendancelength = 0;
  final AttendanceController _attendanceController = AttendanceController();

  Future<List<AttendanceViewModel>> _getListAttendance() async {
    //TODO: Utilizar un datetime.now y con un calendario para seleccionar dias
    List<AttendanceViewModel> attendanceViewModelList =
        await _attendanceController.getListAttendanceViewModel(dateNowText);
    return attendanceViewModelList;
  }

  Future<DateTime?> _selectedInitialDay(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    return picked;
  }

  void selectDay() async {
    DateTime? selectedDate = await _selectedInitialDay(context);
    if (selectedDate != null) {
      setState(() {
        dateNowText = dateFormat.format(selectedDate);
      });
      _getListAttendance().then((listAttendance) => setState(() {
            attendancelength = listAttendance.length;
          }));
    }
  }

  @override
  void initState() {
    super.initState();
    dateNowText = dateFormat.format(DateTime.now());
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _getListAttendance().then(
      (listAttendance) => setState(
        () {
          attendancelength = listAttendance.length;
        },
      ),
    );
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
                return ListView.separated(
                  itemBuilder: (context, index) {
                    final AttendanceViewModel attendanceViewModel =
                        attendanceViewModelList[index];
                    String checkInHour = attendanceViewModel.checkInHour;
                    String firstNameWorker =
                        attendanceViewModel.firstNameWorker;
                    String lastNameWorker = attendanceViewModel.lastNameWorker;
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
