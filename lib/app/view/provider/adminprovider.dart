import 'package:control_asistencia_app/app/packages/packages_pub.dart';

class AdminProvider extends ChangeNotifier {
  String _firstNameProvider = "Nombre";
  String _lastNameProvider = "Apellido";
  String? _urlPhoto;

  String get firstNameProvider => _firstNameProvider;
  String get lastNameProvider => _lastNameProvider;
  String get urlPhoto => _urlPhoto ?? "";

  void updateValues(String newFirstName, String newLastName) {
    _firstNameProvider = newFirstName;
    _lastNameProvider = newLastName;
    notifyListeners();
  }

  // void clear() {
  //   _firstName = null;
  //   _lastName = null;
  //   notifyListeners();
  // }
}
