import 'package:control_asistencia_app/app/controller/admin_controllers/worker_controller.dart';
import 'package:control_asistencia_app/app/model/worker_model.dart';
import 'package:control_asistencia_app/app/view/screen/admin_screens/listworker_screen.dart';
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
  late TextEditingController _conNameWorker;
  late TextEditingController _conRFCWorker;
  late TextEditingController _conCurpWorker;
  late TextEditingController _conIMSSWorker;
  late TextEditingController _conworkerPosition;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late WorkerController workerController;

  void addWorker() async {
    final FormState? form = _formKey.currentState;

    String numWorker = _conNumWorker.text;
    String nameWorker = _conNameWorker.text;
    String rfcWorker = _conRFCWorker.text.toUpperCase();
    String curpWorker = _conCurpWorker.text.toUpperCase();
    String numIMSSWorker = _conIMSSWorker.text;
    String workerPosition = _conworkerPosition.text;

    if (form != null) {
      if (form.validate()) {
        WorkerModel workerModel = WorkerModel(
          numTrabajador: int.tryParse(numWorker),
          nombre: nameWorker.trim(),
          curp: curpWorker.trim(),
          rfc: rfcWorker.trim(),
          numImss: int.parse(numIMSSWorker),
          puesto: workerPosition.trim(),
        );
        String respuesta = await workerController.addWorker(workerModel).then(
          (workerController) {
            return workerController;
          },
        );
        if (!mounted) return;
        showDialog(
          context: context,
          builder: (context) {
            if (respuesta == "Trabajador agregado") {
              Future.delayed(
                const Duration(seconds: 2),
                () {
                  Navigator.of(context).pop();
                  Navigator.of(context)
                      .pushReplacementNamed(ListWorkerScreen.route);
                },
              );
              return SimpleDialog(
                title: const Column(
                  children: [
                    Icon(Icons.check_circle, size: 32, color: Colors.green),
                    Text("Trabajador registrado con exito"),
                  ],
                ),
                contentPadding: const EdgeInsets.fromLTRB(10, 12, 10, 16),
                children: [
                  Text(respuesta),
                ],
              );
            } else {
              Future.delayed(
                const Duration(seconds: 2),
                () {
                  Navigator.of(context).pop();
                },
              );
              return SimpleDialog(
                title: const Column(
                  children: [
                    Icon(Icons.cancel_outlined, size: 32, color: Colors.red),
                    Text("Error"),
                  ],
                ),
                contentPadding: const EdgeInsets.fromLTRB(10, 12, 10, 16),
                children: [
                  Text(respuesta),
                ],
              );
            }
          },
        );
        // Navigator.of(context).pushReplacementNamed(ListWorkerScreen.route);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    workerController = WorkerController();
    _conNumWorker = TextEditingController();
    _conNameWorker = TextEditingController();
    _conRFCWorker = TextEditingController();
    _conCurpWorker = TextEditingController();
    _conIMSSWorker = TextEditingController();
    _conworkerPosition = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _conNumWorker.dispose();
    _conNameWorker.dispose();
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
                  controller: _conNameWorker,
                  hintName: "Nombre Trabajador",
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
