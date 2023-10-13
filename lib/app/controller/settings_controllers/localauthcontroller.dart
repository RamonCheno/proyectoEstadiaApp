// ignore_for_file: depend_on_referenced_packages

import 'package:control_asistencia_app/app/packages/packages_pub.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart'
    show AndroidAuthMessages, AuthMessages, AuthenticationOptions;

class LocalAuthController {
  final LocalAuthentication _auth = LocalAuthentication();

  Future<bool> checkBiometric() async {
    bool canCheckBiometric = false;
    try {
      canCheckBiometric = await _auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      debugPrint("$e");
    }
    return canCheckBiometric;
  }

  Future<List<BiometricType>> getAvailableBiometric() async {
    List<BiometricType> availableBiometric = [];

    try {
      availableBiometric = await _auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      debugPrint('$e');
    }

    return availableBiometric;
  }

  Future<bool> authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await _auth.authenticate(
        localizedReason: 'Escanee su huella para continuar',
        options: const AuthenticationOptions(
            useErrorDialogs: true, stickyAuth: true, biometricOnly: true),
        authMessages: const <AuthMessages>[
          AndroidAuthMessages(
            signInTitle: 'Lector biometrico para Lista de asistencia ISC',
            cancelButton: 'Cancelar',
          )
        ],
      );
    } on PlatformException catch (e) {
      debugPrint('$e');
    }
    return authenticated;
  }
}
