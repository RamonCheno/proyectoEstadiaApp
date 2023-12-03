import 'package:control_asistencia_app/app/controller/attendance_controllers/attendance_controller.dart';
import 'package:control_asistencia_app/app/model/attendance/attendance_model.dart';
import 'package:control_asistencia_app/app/packages/packages_pub.dart';
import 'package:control_asistencia_app/app/view/widget/customdialog_widget.dart';
import 'package:control_asistencia_app/app/view_models/attendance_viewmodel.dart';

class AttendanceProvider with ChangeNotifier {
  final AttendanceController _attendanceController = AttendanceController();
  // late String _dateNowText;
  // String get dateNowText => _dateNowText;

  List<AttendanceViewModel> _attendanceViewModelList = [];
  List<AttendanceViewModel> get attendanceViewModelList =>
      _attendanceViewModelList;

  Future<void> getListAttendance(String dateNowText) async {
    _attendanceViewModelList =
        await _attendanceController.getListAttendanceViewModel(dateNowText);
    notifyListeners();
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
