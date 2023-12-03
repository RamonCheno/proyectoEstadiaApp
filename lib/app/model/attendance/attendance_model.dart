abstract class AttendanceModel {
  String? _hora;
  String? _fecha;

  String get hora => _hora!;
  String get fecha => _fecha!;

  AttendanceModel.instance();

  AttendanceModel({required String hora, required String fecha}) {
    _hora = hora;
    _fecha = fecha;
  }

  AttendanceModel fromMap(Map<String, dynamic> json);

  Map<String, dynamic> toMap();
}
