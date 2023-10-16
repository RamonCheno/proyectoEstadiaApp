import 'package:control_asistencia_app/app/view/screen/worker_screens/checkin_method_screens/more_options_screen.dart';
import 'package:control_asistencia_app/app/view/widget/customdialog_widget.dart';
import 'package:flutter/material.dart';

class CheckInFingerPrintScreen extends StatefulWidget {
  const CheckInFingerPrintScreen({super.key});
  static const route = "/fingerprintCheckInScreen";

  @override
  State<CheckInFingerPrintScreen> createState() =>
      _CheckInFingerPrintScreenState();
}

class _CheckInFingerPrintScreenState extends State<CheckInFingerPrintScreen> {
  void messagge() {
    if (!mounted) return;
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        Future.delayed(
          const Duration(seconds: 2),
          () {
            Navigator.of(context).pop();
          },
        );
        return const CustomDialogWidget(
          messagge: Column(children: [
            Text("Nombre Trabajador"),
            Text("Hora de entrada: 12:00 pm"),
          ]),
          iconData: Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 42,
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Size media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Asistencia Laboral"),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
        child: Column(
          children: [
            IconButton(
                //Encender sensor ya implementado
                icon: const Icon(
                  Icons.fingerprint,
                  size: 96,
                ),
                onPressed: () {}),
            const SizedBox(
              height: 25,
            ),
            const Text(
              "toque el icono para activar el sensor de huella dactilar",
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 100,
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context)
                  .pushReplacementNamed(MoreOptionsScreen.route),
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(
                  Color(0xff990303),
                ),
              ),
              child: const Text(
                "Más opciones",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
