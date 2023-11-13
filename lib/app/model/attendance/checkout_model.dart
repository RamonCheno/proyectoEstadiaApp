import 'package:control_asistencia_app/app/model/attendance/attendance_model.dart';

class CheckOutModel extends AttendanceModel {
  late String _horaSalida;
  late String _fechaSalida;

  //Propiedades
  String get fechaSalida => _fechaSalida;
  String get horaSalida => _horaSalida;

  CheckOutModel({required String hour, required String day}) {
    _horaSalida = hour;
    _fechaSalida = day;
  }

  static CheckOutModel fromMap(Map<String, dynamic> json) => CheckOutModel(
        hour: json["hora"],
        day: json["fecha"],
      );

  @override
  Map<String, dynamic> toMap() => {
        "hora": _horaSalida,
        "fecha": _fechaSalida,
      };
}
