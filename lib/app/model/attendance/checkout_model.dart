import 'package:control_asistencia_app/app/model/attendance/attendance_model.dart';

class CheckOutModel extends AttendanceModel {
  CheckOutModel.instance() : super.instance();

  CheckOutModel({required String hour, required String day})
      : super(hora: hour, fecha: day);

  @override
  CheckOutModel fromMap(Map<String, dynamic> json) => CheckOutModel(
        hour: json["hora"] ?? "",
        day: json["fecha"] ?? "",
      );

  @override
  Map<String, dynamic> toMap() => {
        "hora": hora,
        "fecha": fecha,
      };
}
