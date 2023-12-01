import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control_asistencia_app/app/model/user/worker_model.dart';
import 'package:control_asistencia_app/app/view_models/worker_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class WorkerController {
  //Metodos para guardar y obtener trabajados usando cloud firestore
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future<String> uploadImageToStorage(
      File photoWorker, String nameWorker, String lastNameW) async {
    String response = "";
    if (firebaseAuth.currentUser != null) {
      List<String> firstNameWorkerArray = nameWorker.split(' ');
      List<String> lastNameWorkerArray = lastNameW.split(' ');
      String firstNameWorker = firstNameWorkerArray[0];
      String lastNameWorker = lastNameWorkerArray[0];
      String nameWorkerComplete = "${firstNameWorker}_$lastNameWorker";
      try {
        final storageReference = firebaseStorage
            .ref()
            .child("fotos/trabajadores/$nameWorkerComplete.jpg");

        bool isExist = await checkIfFileExist(storageReference.fullPath);
        if (isExist) {
          await storageReference.delete();
        }
        UploadTask uploadTask = storageReference.putFile(photoWorker);
        await uploadTask.whenComplete(() {});
        response = await storageReference.getDownloadURL();
      } catch (e) {
        response = "$e";
      }
    } else {
      response = "Usuario no autorizado";
    }
    return response;
  }

  Future<void> deleteSubColeccionWorker(
      String nameCollection, int numWorker) async {
    String idDocumentWorker = numWorker.toString();
    try {
      DocumentReference documentWorker =
          firestore.collection("Trabajador").doc(idDocumentWorker);
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
      final ref = firebaseStorage.ref(filePath);
      final FullMetadata result = await ref.getMetadata();
      String isExistFile = result.fullPath;
      if (isExistFile.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint("Error: $e");
      return false;
    }
  }

  Future<String> addWorker(WorkerModel workerModel) async {
    try {
      final Map<String, dynamic> workerMap = workerModel.toMap();
      final String workerId = workerMap["numTrabajador"].toString();
      await firestore.collection('Trabajador').doc(workerId).set(workerMap);
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
      final DocumentReference docRef =
          firestore.collection('Trabajador').doc('$numWorker');
      await docRef.update(workeUpdateMap);
      return "Trabajador actualizado";
    } catch (e) {
      debugPrint("Error: $e");
      return "Error en actualizar trabajador, Verifique datos de guardado";
    }
  }

  // Future<List<WorkerModel>> getListWokersModel() async {
  //   final QuerySnapshot querySnapshot = await firestore
  //       .collection('Trabajador')
  //       .orderBy("apellido", descending: false)
  //       .get();
  //   List<WorkerModel> workerList = [];
  //   if (querySnapshot.docs.isNotEmpty) {
  //     for (var worker in querySnapshot.docs) {
  //       WorkerModel workerModel =
  //           WorkerModel.fromMap(worker.data() as Map<String, dynamic>);
  //       workerList.add(workerModel);
  //     }
  //     return workerList;
  //   } else {
  //     return [];
  //   }
  // }

  // Future<List<dynamic>> getListDataWorkers(
  //     {bool returnViewModel = false}) async {
  //   final QuerySnapshot querySnapshot = await firestore
  //       .collection('Trabajador')
  //       .orderBy("apellido", descending: false)
  //       .get();
  //   List<dynamic> workerList = [];
  //   if (querySnapshot.docs.isNotEmpty) {
  //     for (var worker in querySnapshot.docs) {
  //       WorkerModel workerModel =
  //           WorkerModel.fromMap(worker.data() as Map<String, dynamic>);
  //       if (returnViewModel) {
  //         WorkerViewModel workerViewModel = WorkerViewModel(workerModel);
  //         workerList.add(workerViewModel);
  //       } else {
  //         workerList.add(workerModel);
  //       }
  //     }
  //     return workerList;
  //   } else {
  //     return [];
  //   }
  // }

  Future<List<WorkerViewModel>> getListWokersViewModel(String isWorking) async {
    try {
      final QuerySnapshot querySnapshot = await firestore
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
        await firebaseAuth.signInAnonymously();
      }
      QuerySnapshot userSnapshot = await firestore
          .collection("Trabajador")
          .where("numTrabajador", isEqualTo: numWorker)
          .get();
      if (userSnapshot.docs.isEmpty) {
        return null;
      } else {
        Map<String, dynamic> workerData =
            userSnapshot.docs.first.data() as Map<String, dynamic>;
        if (useAnonymousAuth) {
          await firebaseAuth.signOut();
        }
        WorkerModel workerModel = WorkerModel.fromMap(workerData);
        return workerModel;
      }
    } catch (e) {
      throw "Error: $e";
    }
  }
}
