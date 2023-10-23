import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control_asistencia_app/app/model/user/admin_model.dart';
import 'package:control_asistencia_app/app/packages/packages_pub.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<String> registerAdmin(AdminModel adminModel, String password) async {
    try {
      final adminMap = adminModel.toMap();
      final emailAdmin = adminMap["email"];
      final userSignInMethod =
          await firebaseAuth.fetchSignInMethodsForEmail(emailAdmin);
      if (userSignInMethod.isNotEmpty) {
        return "El correo electrónico ya está registrado";
      } else {
        await firestore.collection("Administrador").add(adminMap);
        await firebaseAuth.createUserWithEmailAndPassword(
            email: emailAdmin, password: password);
        return "Registro con exito";
      }
    } on FirebaseFirestore catch (e) {
      debugPrint(e.toString());
      return "Registro fallido";
    }
  }

  Future<String> loginAdmin(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user!;
      debugPrint("Usuario ${user.uid} ha iniciado sesion.");
      return "Sesion iniciada";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No se encontro nungun usuario con ese correo electronico.';
      } else if (e.code == 'wrong-password') {
        return "Contraseña incorrecta.";
      } else {
        debugPrint("$e");
        return 'Ocurrió un error al iniciar sesión';
      }
    }
  }

  void signOut() async {
    await firebaseAuth.signOut();
  }
}
