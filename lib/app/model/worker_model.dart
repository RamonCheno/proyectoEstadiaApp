class WorkerModel {
  final int numTrabajador;
  final String nombre;
  final String curp;
  final String rfc;
  final String puesto;

  WorkerModel({
    required this.numTrabajador,
    required this.nombre,
    required this.curp,
    required this.rfc,
    required this.puesto,
  });

  WorkerModel copyWith({
    int? numTrabajador,
    String? nombre,
    String? curp,
    String? rfc,
    String? puesto,
  }) =>
      WorkerModel(
        numTrabajador: numTrabajador ?? this.numTrabajador,
        nombre: nombre ?? this.nombre,
        curp: curp ?? this.curp,
        rfc: rfc ?? this.rfc,
        puesto: puesto ?? this.puesto,
      );

  factory WorkerModel.fromMap(Map<String, dynamic> json) => WorkerModel(
        numTrabajador: json["numTrabajador"],
        nombre: json["nombre"],
        curp: json["curp"],
        rfc: json["RFC"],
        puesto: json["puesto"],
      );

  Map<String, dynamic> toMap() => {
        "numTrabajador": numTrabajador,
        "nombre": nombre,
        "curp": curp,
        "RFC": rfc,
        "puesto": puesto,
      };
}
