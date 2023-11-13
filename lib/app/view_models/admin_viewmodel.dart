import 'package:control_asistencia_app/app/model/user/admin_model.dart';

class AdminViewModel {
  String? _nombre;
  String? _apellido;
  String? urlPhoto;

  String get nombre => _nombre!;

  String get apellido => _apellido!;

  AdminViewModel(AdminModel adminModel) {
    List<String> firstNameAdminArray = adminModel.nombre.split(' ');
    List<String> lastNameAdminArray = adminModel.apellido.split(' ');
    _nombre = firstNameAdminArray[0];
    _apellido = lastNameAdminArray[0];
  }
}
