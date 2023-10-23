import 'package:control_asistencia_app/app/model/attendance/attendance_model.dart';

class CheckInModel extends AttendanceModel {
  late String _horaEntrada;
  late String _fechaEntrada;

  String get fechaEntrada => _fechaEntrada;
  String get horaEntrada => _horaEntrada;

  CheckInModel({required String hour, required String day}) {
    _fechaEntrada = day;
    _horaEntrada = hour;
  }

  @override
  CheckInModel fromMap(Map<String, dynamic> json) => CheckInModel(
        day: _fechaEntrada,
        hour: _horaEntrada,
      );

  @override
  Map<String, dynamic> toMap() => {
        "hora": _horaEntrada,
        "fecha": _fechaEntrada,
      };
}
