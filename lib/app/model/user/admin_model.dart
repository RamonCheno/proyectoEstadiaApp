import 'user_model.dart';

class AdminModel extends UserModel {
  late String _email;

  String get email => _email;

  AdminModel({
    int? numTrabajador,
    required String nombre,
    required String apellido,
    String? curp,
    int? numImss,
    String? rfc,
    String? puesto,
    required String email,
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
        ) {
    _email = email;
  }

  @override
  AdminModel copyWith(
          {int? numTrabajador,
          String? nombre,
          String? apellido,
          String? curp,
          int? numImss,
          String? rfc,
          String? puesto,
          String? email,
          String? urlPhoto}) =>
      AdminModel(
        numTrabajador: numTrabajador ?? this.numTrabajador,
        nombre: nombre ?? this.nombre,
        apellido: apellido ?? this.apellido,
        curp: curp ?? this.curp,
        numImss: numImss ?? this.numImss,
        rfc: rfc ?? this.rfc,
        puesto: puesto ?? this.puesto,
        email: email ?? _email,
        urlPhoto: urlPhoto ?? this.urlPhoto,
      );

  factory AdminModel.fromMap(Map<String, dynamic> json) => AdminModel(
      numTrabajador: json["numTrabajador"],
      nombre: json["nombre"],
      apellido: json["apellido"],
      curp: json["curp"],
      numImss: json["numIMSS"],
      rfc: json["RFC"],
      puesto: json["puesto"],
      email: json["email"],
      urlPhoto: json["urlPhoto"]);

  @override
  Map<String, dynamic> toMap() => {
        "numTrabajador": numTrabajador,
        "nombre": nombre,
        "apellido": apellido,
        "curp": curp,
        "numIMSS": numImss,
        "RFC": rfc,
        "puesto": puesto,
        "email": _email,
        "urlPhoto": urlPhoto
      };
}
