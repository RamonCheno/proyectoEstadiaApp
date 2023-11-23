import 'package:control_asistencia_app/app/controller/attendance_controllers/attendance_controller.dart';
import 'package:control_asistencia_app/app/model/attendance/ckeckin_model.dart';
import 'package:control_asistencia_app/app/view_models/attendance_viewmodel.dart';
import 'package:flutter/foundation.dart';

class AttendanceProvider with ChangeNotifier {
  final AttendanceController _attendanceController = AttendanceController();
  late String _dateNowText;

  String get dateNowText => _dateNowText;

  List<AttendanceViewModel> _attendanceViewModelList = [];
  List<AttendanceViewModel> get attendanceViewModelList =>
      _attendanceViewModelList;
  // Stream<List<AttendanceViewModel>> getListAttendanceStream() {
  //   return _attendanceController.getListAttendanceViewModel(_dateNowText);
  // }

  Future<void> getListAttendance(String dateNowText) async {
    _attendanceViewModelList =
        await _attendanceController.getListAttendanceViewModel(dateNowText);
    notifyListeners();
  }

  // void updateDateNowText(String value) {
  //   _dateNowText = value;
  //   notifyListeners();
  // }

  void addCheckInProvider(CheckInModel checkInModel, int numTrabajador) async {
    await _attendanceController.addCheckIn(checkInModel, numTrabajador);
    notifyListeners();
  }
}
