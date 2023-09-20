import 'package:flutter/material.dart';

class CheckInComplete extends StatelessWidget {
  const CheckInComplete({super.key});

  static const route = "/checkinComplete";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Asistencia Laboral"),
          centerTitle: true,
        ),
        body: const Center(child: Text("Bienvenido (nombre del trabajador)")));
  }
}
