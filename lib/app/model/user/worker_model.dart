import 'user_model.dart';

class WorkerModel extends UserModel {
  // WorkerModel.instance() : super.instance(
  bool _isVisible = true;

  bool get getIsVisible => _isVisible;

  set setIsVisible(bool isVisible) => _isVisible = isVisible;

  WorkerModel({
    int? numTrabajador,
    required String nombre,
    required String apellido,
    required String curp,
    required int numImss,
    required String rfc,
    required String puesto,
    String? urlPhoto,
    required bool visible,
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
    _isVisible = visible;
  }

  @override
  WorkerModel copyWith(
          {int? numTrabajador,
          String? nombre,
          String? apellido,
          String? curp,
          int? numImss,
          String? rfc,
          String? puesto,
          String? urlPhoto,
          bool? visible}) =>
      WorkerModel(
        numTrabajador: numTrabajador ?? this.numTrabajador,
        nombre: nombre ?? this.nombre,
        apellido: apellido ?? this.apellido,
        curp: curp ?? this.curp!,
        numImss: numImss ?? this.numImss!,
        rfc: rfc ?? this.rfc!,
        puesto: puesto ?? this.puesto!,
        urlPhoto: urlPhoto ?? this.urlPhoto,
        visible: visible ?? _isVisible,
      );

  factory WorkerModel.fromMap(Map<String, dynamic> json) => WorkerModel(
      numTrabajador: json["numTrabajador"],
      nombre: json["nombre"],
      apellido: json["apellido"],
      curp: json["curp"],
      numImss: json["numIMSS"],
      rfc: json["RFC"],
      puesto: json["puesto"],
      urlPhoto: json["urlPhoto"] ?? "",
      visible: json["trabajando"] == "alta" ? true : false);

  @override
  Map<String, dynamic> toMap() => {
        "numTrabajador": numTrabajador,
        "nombre": nombre,
        "apellido": apellido,
        "curp": curp,
        "numIMSS": numImss,
        "RFC": rfc,
        "puesto": puesto,
        "urlPhoto": urlPhoto,
        "trabajando": _isVisible ? "alta" : "baja"
        // "idHuella": _idHuella,
      };
}
