import 'dart:io';
import 'package:control_asistencia_app/app/packages/packagelocal_controller.dart';
import 'package:control_asistencia_app/app/packages/packagelocal_model.dart';
import 'package:control_asistencia_app/app/packages/packagelocal_widgets.dart';
import 'package:control_asistencia_app/app/packages/packages_pub.dart';
import 'package:control_asistencia_app/app/packages/packageslocal_view.dart';

class AdminProvider extends ChangeNotifier {
  final AdminController _adminController = AdminController();
  String _firstNameProvider = "nombre";
  String _lastNameProvider = "apellido";
  int _numHumanResource = 0;
  String? _urlPhoto;
  bool get isLoading => _isLoading;
  bool _isLoading = true;

  int get numHumanResource => _numHumanResource;
  String get firstNameProvider => _firstNameProvider;
  String get lastNameProvider => _lastNameProvider;
  String? get urlPhoto => _urlPhoto;

  void updateValues(
      String newFirstName, String newLastName, int numRH, String imgUrl) {
    _firstNameProvider = newFirstName;
    _lastNameProvider = newLastName;
    _numHumanResource = numRH;
    _urlPhoto = imgUrl;
  }

  Future<void> getAdminViewModel() async {
    final AdminViewModel dataAdminModel =
        await _adminController.getDataAdmin(returnViewModel: true);
    updateValues(dataAdminModel.nombre, dataAdminModel.apellido,
        dataAdminModel.numHumanR, dataAdminModel.networkPhoto);
    _isLoading = false;
    notifyListeners();
  }

  Future<AdminModel> getDataAdminProvider() async {
    AdminModel dataAdmin = await _adminController.getDataAdmin();
    return dataAdmin;
  }

  Future<void> getUrlImage(File image, String numWorker) async {
    _urlPhoto = await _adminController.uploadImageToStorage(image, numWorker);
  }

  Future<String> updateInfoProvider(AdminModel adminModel) async {
    String response = await _adminController.updateAdmin(adminModel);
    return response;
  }

  void showResponseDialog(BuildContext context, String response,
      {bool updateInfo = false}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.of(context).pop();
          if (updateInfo) {
            Navigator.of(context).pop();
          }
        });
        return CustomDialogWidget(
          messagge: Text(response),
          iconData: updateInfo
              ? const Icon(Icons.check_circle, color: Colors.green)
              : const Icon(Icons.cancel, color: Colors.red),
        );
      },
    );
  }
}
