import 'package:control_asistencia_app/app/packages/packagelocal_controller.dart';
import 'package:control_asistencia_app/app/packages/packagelocal_model.dart';
import 'package:control_asistencia_app/app/packages/packagelocal_widgets.dart';
import 'package:control_asistencia_app/app/packages/packages_pub.dart';
import 'package:control_asistencia_app/app/packages/packageslocal_view.dart';

class AttendanceProvider with ChangeNotifier {
  final AttendanceController _attendanceController = AttendanceController();

  List<AttendanceViewModel> _attendanceViewModelList = [];
  List<AttendanceViewModel> get attendanceViewModelList =>
      _attendanceViewModelList;
  int _attendanceCount = 0;
  int get attendanceCount => _attendanceCount;

  Future<void> getListAttendance(String dateNowText) async {
    _attendanceViewModelList =
        await _attendanceController.getListAttendanceViewModel(dateNowText);
    _attendanceCount = _attendanceViewModelList.length;
    notifyListeners();
  }

  Future<void> getListAttendanceForRangeDay(
      String initDay, String finishDay) async {
    _attendanceViewModelList = await _attendanceController
        .getListAttendanceVMDayRange(initDay, finishDay);
  }

  Future<String> addCheckInProvider(
      AttendanceModel attendanceModel, int numTrabajador) async {
    AttendanceModel checkInModel = attendanceModel;
    String response =
        await _attendanceController.addCheckIn(checkInModel, numTrabajador);
    notifyListeners();
    return response;
  }

  Future<String> addCheckOutProvider(AttendanceModel attendanceModel,
      int numWorker, String fechaEntrada) async {
    String response = await _attendanceController.addCheckOut(
        attendanceModel, numWorker, fechaEntrada);
    notifyListeners();
    return response;
  }

  void showResponseDialog(BuildContext context, List<Widget> response,
      TextEditingController conTextFormField,
      {bool addWorker = false, String? titleDialog}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.of(context).pop();
          conTextFormField.clear();
        });
        return CustomDialogWidget(
          title: titleDialog,
          messagge: Column(
            children: response,
          ),
          iconData: addWorker
              ? const Icon(Icons.check_circle, color: Colors.green)
              : const Icon(Icons.cancel, color: Colors.red),
        );
      },
    );
  }
}
