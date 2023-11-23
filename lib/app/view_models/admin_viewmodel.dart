import 'package:control_asistencia_app/app/model/user/admin_model.dart';

class AdminViewModel {
  String? _nombre;
  String? _apellido;
  String? _networkPhoto;
  int? _numHumanR;

  String get nombre => _nombre!;

  String get apellido => _apellido!;

  String get networkPhoto => _networkPhoto ?? "";

  int get numHumanR => _numHumanR!;

  AdminViewModel(AdminModel adminModel) {
    List<String> firstNameAdminArray = adminModel.nombre.split(' ');
    List<String> lastNameAdminArray = adminModel.apellido.split(' ');
    _nombre = firstNameAdminArray[0];
    _apellido = lastNameAdminArray[0];
    _networkPhoto = adminModel.urlPhoto;
    _numHumanR = adminModel.numTrabajador;
  }
}
