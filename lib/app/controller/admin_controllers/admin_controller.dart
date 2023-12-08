import 'dart:io';
import 'package:control_asistencia_app/app/common/firebase_service_common.dart';
import 'package:control_asistencia_app/app/common/shared_preferences_common.dart';
import 'package:control_asistencia_app/app/packages/packagelocal_model.dart';
import 'package:control_asistencia_app/app/packages/packages_pub.dart';
import 'package:control_asistencia_app/app/packages/packageslocal_view.dart';

class AdminController {
  final SharedPreferencesCommon sharedPreferencesCommon =
      SharedPreferencesCommon();
  final FirebaseServiceCommon _firebaseServiceCommon = FirebaseServiceCommon();

  Future<String> registerAdmin(AdminModel adminModel, String password) async {
    try {
      final adminMap = adminModel.toMap();
      final emailAdmin = adminMap["email"];
      final userSignInMethod = await _firebaseServiceCommon.firebaseAuth
          .fetchSignInMethodsForEmail(emailAdmin);
      if (userSignInMethod.isNotEmpty) {
        return "El correo electrónico ya está registrado";
      } else {
        UserCredential userCredential = await _firebaseServiceCommon
            .firebaseAuth
            .createUserWithEmailAndPassword(
                email: emailAdmin, password: password);
        User user = userCredential.user!;
        await _firebaseServiceCommon.firestore
            .collection("Administrador")
            .doc(user.uid)
            .set(adminMap);
        return "Registro con exito";
      }
    } on FirebaseFirestore catch (e) {
      debugPrint(e.toString());
      return "Registro fallido";
    }
  }

  Future<String> loginAdmin(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseServiceCommon.firebaseAuth
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

  Future<String> uploadImageToStorage(
      File photoWorker, String name, String lastName) async {
    String response = "";
    List<String> firstNameAdminArray = name.split(' ');
    List<String> lastNameAdminArray = lastName.split(' ');
    String firstNameAdmin = firstNameAdminArray[0];
    String lastNameAdmin = lastNameAdminArray[0];
    String nameComplete = "${firstNameAdmin}_$lastNameAdmin";
    final storageReference = _firebaseServiceCommon.firebaseStorage
        .ref()
        .child("fotos/RecursosHumanos/$nameComplete.jpg");

    bool isExist = await checkIfFileExist(storageReference.fullPath);
    if (isExist) {
      await storageReference.delete();
    }
    UploadTask uploadTask = storageReference.putFile(photoWorker);
    await uploadTask.whenComplete(() {});
    response = await storageReference.getDownloadURL();
    return response;
  }

  Future<bool> checkIfFileExist(String filePath) async {
    try {
      final ref = _firebaseServiceCommon.firebaseStorage.ref(filePath);
      final isExistFile = (await ref.getMetadata()).fullPath.isNotEmpty;
      return isExistFile;
    } catch (e) {
      debugPrint("$e");
      return false;
    }
  }

  Future<String> updateAdmin(AdminModel adminModel) async {
    try {
      String uidAdmin = await SharedPreferencesCommon.loadString("uidAdmin");
      final adminMap = adminModel.toMap();
      final DocumentReference docRef = _firebaseServiceCommon.firestore
          .collection('Administrador')
          .doc(uidAdmin);
      await docRef.update(adminMap);
      return "Informacion actualizado";
    } catch (e) {
      return "Error en actualizar, Verifique datos de guardado";
    }
  }

  Future<dynamic> getDataAdmin({bool returnViewModel = false}) async {
    try {
      String uidAdmin = await SharedPreferencesCommon.loadString("uidAdmin");
      final adminFromMap = await _firebaseServiceCommon.firestore
          .collection("Administrador")
          .doc(uidAdmin)
          .get();
      AdminModel adminModel = AdminModel.fromMap(adminFromMap.data()!);
      if (returnViewModel) {
        AdminViewModel adminViewModel = AdminViewModel(adminModel);
        return adminViewModel;
      }
      return adminModel;
    } catch (e) {
      throw "Error: $e";
    }
  }

  void signOut() async {
    await _firebaseServiceCommon.firebaseAuth.signOut();
    await SharedPreferencesCommon.clearSheadPreferences("uidAdmin");
  }
}
