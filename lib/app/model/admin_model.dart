import 'user_model.dart';

class AdminModel extends UserModel {
  late String _email;
  late String _password;

  String get password => _password;
  String get email => _email;

  AdminModel(
      {int? numTrabajador,
      required String nombre,
      required String apellido,
      String? curp,
      int? numImss,
      String? rfc,
      String? puesto,
      required String email})
      : super(
            numTrabajador: numTrabajador,
            nombre: nombre,
            apellido: apellido,
            curp: curp,
            numImss: numImss,
            puesto: puesto,
            rfc: rfc) {
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
          String? password}) =>
      AdminModel(
          numTrabajador: numTrabajador ?? this.numTrabajador,
          nombre: nombre ?? this.nombre,
          apellido: apellido ?? this.apellido,
          curp: curp ?? this.curp,
          numImss: numImss ?? this.numImss,
          rfc: rfc ?? this.rfc,
          puesto: puesto ?? this.puesto,
          email: email ?? _email);

  factory AdminModel.fromMap(Map<String, dynamic> json) => AdminModel(
      numTrabajador: json["numTrabajador"],
      nombre: json["nombre"],
      apellido: json["apellido"],
      curp: json["curp"],
      numImss: json["numIMSS"],
      rfc: json["RFC"],
      puesto: json["puesto"],
      email: json["email"]);

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
      };
}
