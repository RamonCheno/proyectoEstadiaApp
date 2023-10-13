class AttendanceModel {
  late String _horaEntrada;
  late String _horaSalida;
  late String _fechaEntrada;
  late String _fechaSalida;

  //Propiedades
  String get fechaSalida => _fechaSalida;
  String get fechaEntrada => _fechaEntrada;
  String get horaEntrada => _horaEntrada;
  String get horaSalida => _horaSalida;

  AttendanceModel({
    String? horaEntrada = "",
    String? horaSalida = "",
    String? fechaEntrada = "",
    String? fechaSalida = "",
  }) {
    _horaEntrada = horaEntrada!;
    _horaSalida = horaSalida!;
    _fechaEntrada = fechaEntrada!;
    _fechaSalida = fechaSalida!;
  }

  factory AttendanceModel.fromMap(Map<String, dynamic> json) => AttendanceModel(
        horaEntrada: json['horaEntrada'],
        fechaEntrada: json['fechaEntrada'],
        horaSalida: json['horaSalida'],
        fechaSalida: json['fechaSalida'],
      );

  Map<String, dynamic> toMap() => {
        "fechaEntrada": _fechaEntrada,
        "fechaSalida": _fechaSalida,
        "horaEntrada": _horaEntrada,
        "horaSalida": _horaSalida,
      };
}
