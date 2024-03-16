class UserModel {
  int? _numTrabajador;
  late String _nombre;
  late String _apellido;
  String? _curp;
  int? _numImss;
  String? _rfc;
  String? _puesto;
  String? _urlPhoto;

  int get numTrabajador => _numTrabajador!;

  String get nombre => _nombre;

  String get apellido => _apellido;

  String? get curp => _curp;

  int? get numImss => _numImss;

  String? get rfc => _rfc;

  String? get puesto => _puesto;

  String? get urlPhoto => _urlPhoto;

  UserModel({
    int? numTrabajador,
    required String nombre,
    required String apellido,
    String? curp,
    int? numImss,
    String? rfc,
    String? puesto,
    String? urlPhoto,
  }) {
    _numTrabajador = numTrabajador;
    _nombre = nombre;
    _apellido = apellido;
    _curp = curp;
    _numImss = numImss;
    _rfc = rfc;
    _puesto = puesto;
    _urlPhoto = urlPhoto;
  }

  UserModel copyWith({
    int? numTrabajador,
    String? nombre,
    String? apellido,
    String? curp,
    int? numImss,
    String? rfc,
    String? puesto,
    String? urlPhoto,
  }) =>
      UserModel(
        numTrabajador: numTrabajador ?? _numTrabajador,
        nombre: nombre ?? _nombre,
        apellido: apellido ?? _apellido,
        curp: curp ?? _curp,
        numImss: numImss ?? _numImss,
        rfc: rfc ?? _rfc,
        puesto: puesto ?? _puesto,
        urlPhoto: urlPhoto ?? _urlPhoto,
      );

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        numTrabajador: json["numTrabajador"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        curp: json["curp"],
        numImss: json["numIMSS"],
        rfc: json["RFC"],
        puesto: json["puesto"],
        urlPhoto: json["urlPhoto"],
      );

  Map<String, dynamic> toMap() => {
        "numTrabajador": _numTrabajador,
        "nombre": _nombre,
        "apellido": _apellido,
        "curp": _curp,
        "numIMSS": _numImss,
        "RFC": _rfc,
        "puesto": _puesto,
        "urlPhoto": _urlPhoto,
      };
}
