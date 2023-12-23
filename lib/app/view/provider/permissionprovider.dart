import 'package:control_asistencia_app/app/common/permission_common.dart';
import 'package:control_asistencia_app/app/packages/packagelocal_widgets.dart';
import 'package:control_asistencia_app/app/packages/packages_pub.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionProvider extends ChangeNotifier {
  bool _status = false;
  bool get statusPermision => _status;
  Future<void> permissionCheckProvider(Permission permission) async {
    _status = await PermissionCommon.checkStoragePermissions(permission);
    notifyListeners();
  }

  void showStoragePermissionErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CustomDialogWidget(
        title: 'Error de permisos',
        iconData: const Icon(Icons.cancel, color: Colors.red),
        messagge: const ListBody(
          children: <Widget>[
            Text('Los permisos de almacenamiento fueron denegados.'),
            Text('Por favor, otorgue los permisos para continuar.'),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Aceptar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
