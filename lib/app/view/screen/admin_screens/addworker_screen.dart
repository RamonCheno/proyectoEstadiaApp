// import 'package:control_asistencia_app/app/controller/admin_controllers/worker_controller.dart';
import 'package:control_asistencia_app/app/controller/settings_controllers/bluetooth_controller.dart';
import 'package:control_asistencia_app/app/controller/worker_controllers/worker_controller.dart';
import 'package:control_asistencia_app/app/model/worker_model.dart';
// import 'package:control_asistencia_app/app/view/screen/admin_screens/fingerprintregister.dart';
import 'package:control_asistencia_app/app/view/widget/customdialog_widget.dart';
import 'package:control_asistencia_app/app/view/widget/customtextformfield_widget.dart';
import 'package:flutter/material.dart';

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
  BluetoothController bluetoothController = BluetoothController();
  int idWorker = 0;

  void addWorker() async {
    final FormState? form = _formKey.currentState;

    int numWorker = int.parse(_conNumWorker.text);
    String firstNameWorker = _conFirstNameWorker.text;
    String lastNameWorker = _conLastNameWorker.text;
    String rfcWorker = _conRFCWorker.text.toUpperCase();
    String curpWorker = _conCurpWorker.text.toUpperCase();
    int numIMSSWorker = int.parse(_conIMSSWorker.text);
    String workerPosition = _conworkerPosition.text;

    if (form != null) {
      if (form.validate()) {
        form.save();
        WorkerModel workerModel = WorkerModel(
          numTrabajador: numWorker,
          nombre: firstNameWorker.trim(),
          apellido: lastNameWorker.trim(),
          curp: curpWorker.trim(),
          rfc: rfcWorker.trim(),
          numImss: numIMSSWorker,
          puesto: workerPosition.trim(),
          // idHuella: idWorker,
        );
        String response = await workerController.addWorker(workerModel).then(
          (methodResponse) {
            return methodResponse;
          },
        );
        if (!mounted) return;
        if (response == "Trabajador agregado") {
          showDialog(
            context: context,
            builder: (context) {
              Future.delayed(
                const Duration(seconds: 2),
                () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              );
              return CustomDialogWidget(
                messagge: Text(response),
                iconData: const Icon(Icons.check_circle, color: Colors.green),
              );
            },
          );
        } else {
          showDialog(
            context: context,
            builder: (context) {
              Future.delayed(
                const Duration(seconds: 2),
                () {
                  Navigator.of(context).pop();
                },
              );
              return CustomDialogWidget(
                messagge: Text(response),
                iconData: const Icon(Icons.cancel, color: Colors.red),
              );
            },
          );
        }
      }
    }
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
    loadMacAddress();
  }

  void loadMacAddress() async {
    await bluetoothController.loadDeviceMacAddress();
  }

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
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: [
                      Material(
                        color: Color(0xffE1E1E1),
                        shape: CircleBorder(),
                        child: Icon(
                          Icons.person_outline,
                          size: 70,
                        ),
                      ),
                    ],
                  ),
                ),
                CustomTextFormWidget(
                  controller: _conNumWorker,
                  hintName: "Num Trabajador",
                  icon: Icons.numbers,
                  isObscureText: false,
                  inputType: TextInputType.number,
                  action: TextInputAction.next,
                  soloLeer: false,
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
                ),
                CustomTextFormWidget(
                  controller: _conCurpWorker,
                  hintName: "Curp",
                  icon: Icons.person_outline,
                  isObscureText: false,
                  inputType: TextInputType.text,
                  action: TextInputAction.next,
                  soloLeer: false,
                ),
                CustomTextFormWidget(
                  controller: _conIMSSWorker,
                  hintName: "Num Imss",
                  icon: Icons.numbers,
                  isObscureText: false,
                  inputType: TextInputType.number,
                  action: TextInputAction.next,
                  soloLeer: false,
                ),
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
          )),
    );
  }
}
