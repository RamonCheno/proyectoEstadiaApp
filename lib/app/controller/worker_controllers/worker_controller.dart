import 'dart:io';

import 'package:control_asistencia_app/app/packages/packagelocal_common.dart' show FirebaseServiceCommon;
import 'package:control_asistencia_app/app/packages/packagelocal_model.dart' show WorkerModel;
import 'package:control_asistencia_app/app/packages/packages_pub.dart' show CollectionReference, DocumentReference, FirebaseFirestore, QueryDocumentSnapshot, QuerySnapshot, UploadTask, debugPrint;
import 'package:control_asistencia_app/app/packages/packageslocal_view.dart';

class WorkerController {
  final FirebaseServiceCommon _firebaseServiceCommon = FirebaseServiceCommon();

  Future<String> uploadImageToStorage(
      File photoWorker, String numWorker) async {
    String response = "";
    final storageReference = _firebaseServiceCommon.firebaseStorage
        .ref()
        .child("fotos/trabajadores/$numWorker.jpg");
    bool isExist = await checkIfFileExist(storageReference.fullPath);
    if (isExist) {
      await storageReference.delete();
    }
    UploadTask uploadTask = storageReference.putFile(photoWorker);
    await uploadTask.whenComplete(() {});
    response = await storageReference.getDownloadURL();
    return response;
  }

  Future<void> deleteSubColeccionWorker(
      String nameCollection, int numWorker) async {
    String idDocumentWorker = numWorker.toString();
    try {
      DocumentReference documentWorker = _firebaseServiceCommon.firestore
          .collection("Trabajador")
          .doc(idDocumentWorker);
      CollectionReference subColectionWorker =
          documentWorker.collection(nameCollection);
      QuerySnapshot querySnapshot = await subColectionWorker.get();
      for (QueryDocumentSnapshot<Object?> document in querySnapshot.docs) {
        await subColectionWorker.doc(document.id).delete();
      }
    } catch (error) {
      debugPrint("Error al eliminar documentos de la subcolección: $error");
    }
  }

  Future<bool> checkIfFileExist(String filePath) async {
    try {
      final ref = _firebaseServiceCommon.firebaseStorage.ref(filePath);
      final metadata = await ref.getMetadata();
      return metadata.fullPath
          .isNotEmpty; // El archivo existe si los metadatos tienen una ruta no vacía
    } catch (e) {
      debugPrint("$e");
      return false;
    }
  }

  Future<String> addWorker(WorkerModel workerModel) async {
    try {
      final Map<String, dynamic> workerMap = workerModel.toMap();
      final String workerId = workerMap["numTrabajador"].toString();
      await _firebaseServiceCommon.firestore
          .collection('Trabajador')
          .doc(workerId)
          .set(workerMap);
      return "Trabajador agregado";
    } on FirebaseFirestore catch (e) {
      debugPrint(e.toString());
      return "Error en guardar trabajador, Verifique datos de guardado";
    }
  }

  Future<void> setVisibleWorker(
      int idWorkerDoc, bool isVisible, WorkerModel workerModel) async {
    workerModel.setIsVisible = isVisible;
    updateWorker(idWorkerDoc, workerModel);
  }

  Future<String> updateWorker(int numWorker, WorkerModel workerModel) async {
    try {
      final workeUpdateMap = workerModel.toMap();
      final DocumentReference docRef = _firebaseServiceCommon.firestore
          .collection('Trabajador')
          .doc('$numWorker');
      await docRef.update(workeUpdateMap);
      return "Trabajador actualizado";
    } catch (e) {
      debugPrint("Error: $e");
      return "Error en actualizar trabajador, Verifique datos de guardado";
    }
  }

  Future<List<WorkerViewModel>> getListWokersViewModel(String isWorking) async {
    try {
      final QuerySnapshot querySnapshot = await _firebaseServiceCommon.firestore
          .collection('Trabajador')
          .where("trabajando", isEqualTo: isWorking)
          .orderBy("apellido", descending: false)
          .get();
      List<WorkerViewModel> workerViewModelList = [];
      if (querySnapshot.docs.isNotEmpty) {
        for (var worker in querySnapshot.docs) {
          WorkerModel workerModel =
              WorkerModel.fromMap(worker.data() as Map<String, dynamic>);
          WorkerViewModel workerViewModel = WorkerViewModel(workerModel);
          workerViewModelList.add(workerViewModel);
        }
        return workerViewModelList;
      } else {
        return [];
      }
    } catch (e) {
      debugPrint("Error: $e");
      return [];
    }
  }

  Future<WorkerModel?> getWorkerData(int numWorker,
      {bool useAnonymousAuth = true}) async {
    try {
      if (useAnonymousAuth) {
        await _firebaseServiceCommon.firebaseAuth.signInAnonymously();
      }
      QuerySnapshot userSnapshot = await _firebaseServiceCommon.firestore
          .collection("Trabajador")
          .where("numTrabajador", isEqualTo: numWorker)
          .get();
      if (userSnapshot.docs.isEmpty) {
        return null;
      } else {
        Map<String, dynamic> workerData =
            userSnapshot.docs.first.data() as Map<String, dynamic>;
        if (useAnonymousAuth) {
          await _firebaseServiceCommon.firebaseAuth.signOut();
        }
        WorkerModel workerModel = WorkerModel.fromMap(workerData);
        return workerModel;
      }
    } catch (e) {
      throw "Error: $e";
    }
  }
}
