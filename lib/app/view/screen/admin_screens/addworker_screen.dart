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

  void addWorker() async {
    final FormState? form = _formKey.currentState;

    String numWorker = _conNumWorker.text;
    String nameWorker = _conNameWorker.text;
    String rfcWorker = _conRFCWorker.text.toUpperCase();
    String curpWorker = _conCurpWorker.text.toUpperCase();
    String numIMSSWorker = _conIMSSWorker.text;
    String workerPosition = _conworkerPosition.text;
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
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Trabajador agregado'),
                          content: const Text(
                              'Trabajador (Nombre) fue agregado correctamente'),
                          actions: [
                            TextButton(
                              child: const Text('Aceptar'),
                              onPressed: () async {
                                Navigator.of(context).pop();
                                Navigator.of(context).pushReplacementNamed(
                                    ListWorkerScreen.route);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
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
