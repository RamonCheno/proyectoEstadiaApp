import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control_asistencia_app/app/common/shared_preferences_common.dart';
import 'package:control_asistencia_app/app/model/user/admin_model.dart';
import 'package:control_asistencia_app/app/packages/packages_pub.dart';
import 'package:control_asistencia_app/app/view_models/admin_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  SharedPreferencesCommon sharedPreferencesCommon = SharedPreferencesCommon();

  Future<String> registerAdmin(AdminModel adminModel, String password) async {
    try {
      final adminMap = adminModel.toMap();
      final emailAdmin = adminMap["email"];
      final userSignInMethod =
          await firebaseAuth.fetchSignInMethodsForEmail(emailAdmin);
      if (userSignInMethod.isNotEmpty) {
        return "El correo electrónico ya está registrado";
      } else {
        UserCredential userCredential =
            await firebaseAuth.createUserWithEmailAndPassword(
                email: emailAdmin, password: password);
        User user = userCredential.user!;
        await firestore.collection("Administrador").doc(user.uid).set(adminMap);
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
      String uidAdmin = user.uid;
      debugPrint("Usuario $uidAdmin ha iniciado sesion.");
      await SharedPreferencesCommon.saveString("uidAdmin", uidAdmin);
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

  Future<AdminViewModel> getDataAdmin() async {
    try {
      String? uidAdmin = await SharedPreferencesCommon.loadString("uidAdmin");
      final adminFromMap =
          await firestore.collection("Administrador").doc(uidAdmin).get();
      AdminModel adminModel = AdminModel.fromMap(adminFromMap.data()!);
      AdminViewModel adminViewModel = AdminViewModel(adminModel);
      return adminViewModel;
    } catch (e) {
      throw "Error: $e";
    }
  }

  void signOut() async {
    await firebaseAuth.signOut();
    await SharedPreferencesCommon.clearSheadPreferences("uidAdmin");
  }
}
