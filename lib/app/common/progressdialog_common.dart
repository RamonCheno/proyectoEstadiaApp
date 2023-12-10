import 'package:control_asistencia_app/app/packages/packages_pub.dart';

class ProgresseDialogCommon {
  static late ProgressDialog progressDialog;

  static void initProgressDialog(BuildContext context) {
    progressDialog = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    progressDialog.style(
      message: 'Espere un momento...',
      progressWidget: const CircularProgressIndicator(),
      maxProgress: 100.0,
    );
  }
}
