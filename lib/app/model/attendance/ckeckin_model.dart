import 'package:control_asistencia_app/app/model/attendance/attendance_model.dart';

class CheckInModel extends AttendanceModel {
  CheckInModel.instance() : super.instance();

  CheckInModel({required String hour, required String day})
      : super(hora: hour, fecha: day);

  @override
  CheckInModel fromMap(Map<String, dynamic> json) => CheckInModel(
        day: json["fecha"],
        hour: json["hora"],
      );

  @override
  Map<String, dynamic> toMap() => {
        "hora": hora,
        "fecha": fecha,
      };
}
