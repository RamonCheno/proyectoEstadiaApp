import 'package:control_asistencia_app/app/view/screen/worker_screens/checkin_method_screens/checkin_fingerprint_screen.dart';
import 'package:control_asistencia_app/app/view/widget/customtextformfield_widget.dart';
import 'package:flutter/material.dart';

class MoreOptionsScreen extends StatefulWidget {
  const MoreOptionsScreen({super.key});
  static const route = "moreOptionScreen";

  @override
  State<MoreOptionsScreen> createState() => _MoreOptionsScreenState();
}

class _MoreOptionsScreenState extends State<MoreOptionsScreen> {
  late TextEditingController _conNumWorker;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Asistencia Laboral"),
      ),
      body: Column(
        children: [
          const Text("Registrar Entrada"),
          Row(
            children: [
              CustomTextFormWidget(
                controller: _conNumWorker,
                hintName: "Numero de trabajador",
                icon: Icons.numbers,
                action: TextInputAction.done,
                inputType: TextInputType.number,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.check),
              )
            ],
          ),
          IconButton(
            onPressed: () => Navigator.of(context)
                .pushReplacementNamed(CheckInFingerPrintScreen.route),
            icon: const Icon(Icons.fingerprint),
          ),
        ],
      ),
    );
  }
}