import 'package:control_asistencia_app/view/screen/worker_screens/checkin_complete_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
// ignore: depend_on_referenced_packages
import 'package:local_auth_android/local_auth_android.dart'
    show AndroidAuthMessages, AuthMessages, AuthenticationOptions;

class CheckInFingerPrintScreen extends StatefulWidget {
  const CheckInFingerPrintScreen({super.key});
  static const route = "/fingerprintCheckInScreen";

  @override
  State<CheckInFingerPrintScreen> createState() =>
      _CheckInFingerPrintScreenState();
}

class _CheckInFingerPrintScreenState extends State<CheckInFingerPrintScreen> {
  LocalAuthentication auth = LocalAuthentication();
  bool canCheckBiometric = false;
  List<BiometricType>? availableBiometric;

  @override
  void initState() {
    super.initState();
    _checkBiometric();
    _getAvailableBiometric();
  }

  Future<void> _checkBiometric() async {
    bool canCheckBiometric = false;

    try {
      canCheckBiometric = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      debugPrint('$e');
    }

    if (!mounted) return;
    setState(() => canCheckBiometric = canCheckBiometric);
  }

  Future<void> _getAvailableBiometric() async {
    List<BiometricType> availableBiometric = [];

    try {
      availableBiometric = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      debugPrint('$e');
    }

    setState(() => availableBiometric = availableBiometric);
  }

  Future<bool> _authenticate() async {
    bool autenticated = false;
    try {
      autenticated = await auth.authenticate(
        localizedReason: 'Escanee su huella para continuar',
        options: const AuthenticationOptions(
            useErrorDialogs: true, stickyAuth: true, biometricOnly: true),
        authMessages: const <AuthMessages>[
          AndroidAuthMessages(
            signInTitle: 'Lector biometrico para registrar entrada',
            cancelButton: 'Cancelar',
          )
        ],
      );
    } on PlatformException catch (e) {
      debugPrint('$e');
    }
    return autenticated;
  }

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Asistencia Laboral"),
        centerTitle: true,
      ),
      body: Container(
        width: media.width,
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
        child: Column(
          children: [
            IconButton(
                icon: const Icon(
                  Icons.fingerprint,
                  size: 96,
                ),
                onPressed: () async {
                  bool registrado = await _authenticate();
                  if (registrado) {
                    if (!mounted) return;
                    Navigator.pushReplacementNamed(
                        context, CheckInComplete.route);
                  }
                }),
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
            const ElevatedButton(
              onPressed: null,
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(
                  Color(0xff990303),
                ),
              ),
              child:
                  Text("Más opciones", style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}
