import 'package:control_asistencia_app/app/packages/packages_pub.dart';
import 'package:control_asistencia_app/app/view/provider/adminprovider.dart';

class UpdatePerfilProvider extends ChangeNotifier {
  String? _imagePath;
  String? _email;

  ImageProvider<Object>? _image;
  final TextEditingController _conNumWorker = TextEditingController();
  final TextEditingController _conFirstNameWorker = TextEditingController();
  final TextEditingController _conLastNameWorker = TextEditingController();
  final TextEditingController _conRFCWorker = TextEditingController();
  final TextEditingController _conCurpWorker = TextEditingController();
  final TextEditingController _conIMSSWorker = TextEditingController();
  final TextEditingController _conAdminPosition = TextEditingController();

  TextEditingController get conNumWorker => _conNumWorker;

  TextEditingController get conFirstNameWorker => _conFirstNameWorker;

  TextEditingController get conLastNameWorker => _conLastNameWorker;

  TextEditingController get conRFCWorker => _conRFCWorker;

  TextEditingController get conCurpWorker => _conCurpWorker;

  TextEditingController get conIMSSWorker => _conIMSSWorker;

  TextEditingController get conAdminPosition => _conAdminPosition;

  String get email => _email!;

  String? get imagePath => _imagePath ?? "";

  ImageProvider<Object>? get image => _image;

  Future<void> getDataPerfil(BuildContext context) async {
    final provider = Provider.of<AdminProvider>(context, listen: false);
    final adminProvider = await provider.getDataAdminProvider();
    _conNumWorker.text = adminProvider.numTrabajador.toString();
    _conFirstNameWorker.text = adminProvider.nombre;
    _conLastNameWorker.text = adminProvider.apellido;
    _conRFCWorker.text = adminProvider.rfc ?? "";
    _conCurpWorker.text = adminProvider.curp ?? "";
    _conIMSSWorker.text =
        (adminProvider.numImss is int) ? adminProvider.numImss.toString() : "";
    _conAdminPosition.text = adminProvider.puesto ?? "";
    _email = adminProvider.email;
    if (adminProvider.urlPhoto != null) {
      setNewImagePath(adminProvider.urlPhoto!);
    }
    // else {
    //   setNewImagePath("assets/images/usuario.png");
    // }
    notifyListeners();
  }

  void setNewImagePath(String newImagePath) {
    _imagePath = newImagePath;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _conNumWorker.dispose();
    _conFirstNameWorker.dispose();
    _conLastNameWorker.dispose();
    _conAdminPosition.dispose();
    _conCurpWorker.dispose();
    _conRFCWorker.dispose();
    _conIMSSWorker.dispose();
  }
}
