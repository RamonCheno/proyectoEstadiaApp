// import 'package:control_asistencia_app/app/controller/admin_controllers/worker_controller.dart';
// import 'package:control_asistencia_app/app/controller/settings_controllers/bluetooth_controller.dart';
import 'dart:io';

import 'package:control_asistencia_app/app/controller/worker_controllers/worker_controller.dart';
import 'package:control_asistencia_app/app/model/user/worker_model.dart';
import 'package:control_asistencia_app/app/packages/packages_pub.dart';
import 'package:control_asistencia_app/app/view/provider/image_provider.dart';
import 'package:control_asistencia_app/app/view/provider/worker_provider.dart';
import 'package:control_asistencia_app/app/view/screen/camera_screen.dart';
// import 'package:control_asistencia_app/app/view/screen/admin_screens/fingerprintregister.dart';
import 'package:control_asistencia_app/app/view/widget/customtextformfield_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class AddWorkerScreen extends StatefulWidget {
  const AddWorkerScreen({super.key});
  static const route = "/addWorkScreen";

  @override
  State<AddWorkerScreen> createState() => _AddWorkerScreenState();
}

class _AddWorkerScreenState extends State<AddWorkerScreen> {
  late TextEditingController _conNumWorker;
  late TextEditingController _conFirstNameWorker;
  late TextEditingController _conLastNameWorker;
  late TextEditingController _conRFCWorker;
  late TextEditingController _conCurpWorker;
  late TextEditingController _conIMSSWorker;
  late TextEditingController _conworkerPosition;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  WorkerController workerController = WorkerController();
  String? _imagePath;
  final picker = ImagePicker();
  // BluetoothController bluetoothController = BluetoothController();
  // int idWorker = 0;

  void addWorker() async {
    final FormState? form = _formKey.currentState;
    WorkerProvider workerProvider =
        Provider.of<WorkerProvider>(context, listen: false);
    if (form != null) {
      if (form.validate()) {
        if (_imagePath == null) {
          workerProvider.showResponseDialog(context, "Agregar una foto");
        } else {
          form.save();
          int numWorker = int.parse(_conNumWorker.text);
          String firstNameWorker = _conFirstNameWorker.text;
          String lastNameWorker = _conLastNameWorker.text;
          String rfcWorker = _conRFCWorker.text.toUpperCase();
          String curpWorker = _conCurpWorker.text.toUpperCase();
          int numIMSSWorker = int.parse(_conIMSSWorker.text);
          String workerPosition = _conworkerPosition.text;
          String? urlImage;
          urlImage = await workerProvider.getUrlImage(
              File(_imagePath!), firstNameWorker, lastNameWorker);
          WorkerModel workerModel = WorkerModel(
            numTrabajador: numWorker,
            nombre: firstNameWorker.trim(),
            apellido: lastNameWorker.trim(),
            curp: curpWorker.trim(),
            rfc: rfcWorker.trim(),
            numImss: numIMSSWorker,
            puesto: workerPosition.trim(),
            urlPhoto: urlImage,
            // idHuella: idWorker,
          );
          String response = await workerProvider.addWokerProvider(workerModel);
          if (!mounted) return;
          if (response == "Trabajador agregado") {
            workerProvider.showResponseDialog(context, response,
                addWorker: true);
          } else {
            workerProvider.showResponseDialog(context, response);
          }
        }
      }
    }
  }

  void showBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.camera_alt_outlined),
                  onPressed: () async {
                    //Metodo para tomar foto por camara
                    Navigator.pop(context);
                    Navigator.of(context)
                        .pushNamed(CameraScreen.route)
                        .then((img) {
                      setState(() {
                        _imagePath = img as String;
                      });
                    });
                  },
                ),
                const Text("Tomar Foto"),
              ],
            ),
            Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.photo_library_outlined),
                  onPressed: () async {
                    //Metodo para tomar foto por galeria
                    final imageProvider =
                        Provider.of<ImageProviders>(context, listen: false);
                    imageProvider.pickImageFromGallery().then((value) {
                      setState(() {
                        _imagePath = value;
                      });
                      Navigator.pop(context);
                    });
                  },
                ),
                const Text("Subir Foto"),
              ],
            )
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _conNumWorker = TextEditingController();
    _conFirstNameWorker = TextEditingController();
    _conLastNameWorker = TextEditingController();
    _conRFCWorker = TextEditingController();
    _conCurpWorker = TextEditingController();
    _conIMSSWorker = TextEditingController();
    _conworkerPosition = TextEditingController();
    // loadMacAddress();
  }

  // void loadMacAddress() async {
  //   await bluetoothController.loadDeviceMacAddress();
  // }

  @override
  void dispose() {
    super.dispose();
    _conNumWorker.dispose();
    _conFirstNameWorker.dispose();
    _conLastNameWorker.dispose();
    _conRFCWorker.dispose();
    _conCurpWorker.dispose();
    _conIMSSWorker.dispose();
    _conworkerPosition.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registrar Trabajador"),
        centerTitle: true,
        backgroundColor: const Color(0xffEBEBEB),
      ),
      backgroundColor: const Color(0xffEBEBEB),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(alignment: Alignment.bottomRight, children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Stack(
                    children: [
                      CircleAvatar(
                          radius: 50.r,
                          backgroundColor: const Color(0xffE1E1E1),
                          foregroundImage: _imagePath != null
                              ? FileImage(File(_imagePath!))
                              : null,
                          backgroundImage: _imagePath != null
                              ? null
                              : const AssetImage("assets/images/usuario.png")),
                    ],
                  ),
                ),
                IconButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.grey.shade400),
                  ),
                  color: Colors.black,
                  iconSize: 30.r,
                  onPressed: () {
                    showBottomSheet();
                  },
                  icon: const Icon(Icons.add_a_photo_outlined),
                ),
              ]),

              CustomTextFormWidget(
                controller: _conNumWorker,
                hintName: "Num Trabajador",
                icon: Icons.numbers,
                isObscureText: false,
                inputType: TextInputType.number,
                action: TextInputAction.next,
                soloLeer: false,
                lengthChar: 8,
              ),
              CustomTextFormWidget(
                controller: _conFirstNameWorker,
                hintName: "Nombre",
                icon: Icons.person_outline,
                isObscureText: false,
                inputType: TextInputType.text,
                action: TextInputAction.next,
                soloLeer: false,
              ),
              CustomTextFormWidget(
                controller: _conLastNameWorker,
                hintName: "Apellido",
                icon: Icons.person_outline,
                isObscureText: false,
                inputType: TextInputType.text,
                action: TextInputAction.next,
                soloLeer: false,
              ),
              CustomTextFormWidget(
                  controller: _conRFCWorker,
                  hintName: "RFC",
                  icon: Icons.person_outline,
                  isObscureText: false,
                  inputType: TextInputType.text,
                  action: TextInputAction.next,
                  soloLeer: false,
                  lengthChar: 13),
              CustomTextFormWidget(
                  controller: _conCurpWorker,
                  hintName: "Curp",
                  icon: Icons.person_outline,
                  isObscureText: false,
                  inputType: TextInputType.text,
                  action: TextInputAction.next,
                  soloLeer: false,
                  lengthChar: 18),
              CustomTextFormWidget(
                  controller: _conIMSSWorker,
                  hintName: "Num Imss",
                  icon: Icons.numbers,
                  isObscureText: false,
                  inputType: TextInputType.number,
                  action: TextInputAction.next,
                  soloLeer: false,
                  lengthChar: 11),
              CustomTextFormWidget(
                controller: _conworkerPosition,
                hintName: "Puesto",
                icon: Icons.person_outline,
                isObscureText: false,
                inputType: TextInputType.text,
                action: TextInputAction.done,
                soloLeer: false,
              ),
              // Container(
              //   margin: const EdgeInsets.symmetric(vertical: 10),
              //   child: Center(
              //     child: ElevatedButton(
              //       style: ElevatedButton.styleFrom(
              //         elevation: 1,
              //         padding: const EdgeInsets.symmetric(horizontal: 24),
              //         textStyle: const TextStyle(fontSize: 18),
              //         backgroundColor: const Color(0xFFD9D9D9),
              //         foregroundColor: const Color(0xFF000000),
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(20),
              //         ),
              //       ),
              //       onPressed: () {
              //         // _showAlertDialog(context, data);
              //         //Ir a la pantalla FingerPrintRegisterScreen
              //         Navigator.of(context)
              //             .pushNamed(FingerPrintRegisterScreen.route)
              //             .then((value) {
              //           setState(() {
              //             if (value != null) {
              //               idWorker = value as int;
              //             }
              //             debugPrint("$idWorker");
              //           });
              //         });
              //       },
              //       child: const Text(
              //         'Registrar Huella Dactilar',
              //       ),
              //     ),
              //   ),
              // ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 1,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      textStyle: const TextStyle(fontSize: 18),
                      backgroundColor: const Color(0xFFD9D9D9),
                      foregroundColor: const Color(0xFF000000),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: addWorker,
                    child: const Text(
                      'Registrar',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
