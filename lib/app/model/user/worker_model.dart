import 'user_model.dart';

class WorkerModel extends UserModel {
  // WorkerModel.instance() : super.instance();
  WorkerModel({
    int? numTrabajador,
    required String nombre,
    required String apellido,
    required String curp,
    required int numImss,
    required String rfc,
    required String puesto,
    String? urlPhoto,
  }) : super(
          numTrabajador: numTrabajador,
          nombre: nombre,
          apellido: apellido,
          curp: curp,
          numImss: numImss,
          puesto: puesto,
          rfc: rfc,
          urlPhoto: urlPhoto,
        );

  @override
  WorkerModel copyWith(
          {int? numTrabajador,
          String? nombre,
          String? apellido,
          String? curp,
          int? numImss,
          String? rfc,
          String? puesto,
          String? urlPhoto}) =>
      WorkerModel(
        numTrabajador: numTrabajador ?? this.numTrabajador,
        nombre: nombre ?? this.nombre,
        apellido: apellido ?? this.apellido,
        curp: curp ?? this.curp!,
        numImss: numImss ?? this.numImss!,
        rfc: rfc ?? this.rfc!,
        puesto: puesto ?? this.puesto!,
        urlPhoto: urlPhoto ?? this.urlPhoto,
      );

  factory WorkerModel.fromMap(Map<String, dynamic> json) => WorkerModel(
      numTrabajador: json["numTrabajador"],
      nombre: json["nombre"],
      apellido: json["apellido"],
      curp: json["curp"],
      numImss: json["numIMSS"],
      rfc: json["RFC"],
      puesto: json["puesto"],
      urlPhoto: json["urlPhoto"] ?? ""
      // idHuella: json["idHuella"],
      );

  @override
  Map<String, dynamic> toMap() => {
        "numTrabajador": numTrabajador,
        "nombre": nombre,
        "apellido": apellido,
        "curp": curp,
        "numIMSS": numImss,
        "RFC": rfc,
        "puesto": puesto,
        "urlPhoto": urlPhoto
        // "idHuella": _idHuella,
      };
}
