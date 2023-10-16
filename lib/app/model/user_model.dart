class UserModel {
  int? _numTrabajador;
  late String _nombre;
  late String _apellido;
  String? _curp;
  int? _numImss;
  String? _rfc;
  String? _puesto;

  int? get numTrabajador => _numTrabajador;

  String get nombre => _nombre;

  String get apellido => _apellido;

  String? get curp => _curp;

  int? get numImss => _numImss;

  String? get rfc => _rfc;

  String? get puesto => _puesto;

  UserModel({
    int? numTrabajador,
    required String nombre,
    required String apellido,
    String? curp,
    int? numImss,
    String? rfc,
    String? puesto,
  }) {
    _numTrabajador = numTrabajador;
    _nombre = nombre;
    _apellido = apellido;
    _curp = curp;
    _numImss = numImss;
    _rfc = rfc;
    _puesto = puesto;
  }

  UserModel copyWith({
    int? numTrabajador,
    String? nombre,
    String? apellido,
    String? curp,
    int? numImss,
    String? rfc,
    String? puesto,
  }) =>
      UserModel(
        numTrabajador: numTrabajador ?? _numTrabajador,
        nombre: nombre ?? _nombre,
        apellido: apellido ?? _apellido,
        curp: curp ?? _curp,
        numImss: numImss ?? _numImss,
        rfc: rfc ?? _rfc,
        puesto: puesto ?? _puesto,
      );

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        numTrabajador: json["numTrabajador"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        curp: json["curp"],
        numImss: json["numIMSS"],
        rfc: json["RFC"],
        puesto: json["puesto"],
      );

  Map<String, dynamic> toMap() => {
        "numTrabajador": _numTrabajador,
        "nombre": _nombre,
        "apellido": _apellido,
        "curp": _curp,
        "numIMSS": _numImss,
        "RFC": _rfc,
        "puesto": _puesto,
      };
}
