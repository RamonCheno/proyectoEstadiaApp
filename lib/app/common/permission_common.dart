import 'package:permission_handler/permission_handler.dart';

class PermissionCommon {
  static Future<bool> checkStoragePermissions(Permission permission) async {
    PermissionStatus status = await permission.status;
    if (status.isGranted) {
      return true;
    } else {
      await permission.request();
      status = await permission.status;
      return status.isGranted;
    }
  }
}
