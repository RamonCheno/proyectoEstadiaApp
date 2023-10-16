import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control_asistencia_app/app/model/worker_model.dart';
import 'package:control_asistencia_app/app/view_models/worker_viewmodel.dart';
import 'package:flutter/material.dart';

class WorkerController {
  //Metodos para guardar y obtener trabajados usando cloud firestore
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String> addWorker(WorkerModel workerModel) async {
    try {
      final workerMap = workerModel.toMap();
      await firestore.collection('Trabajador').add(workerMap);
      return "Trabajador agregado";
    } on FirebaseFirestore catch (e) {
      debugPrint(e.toString());
      return "Error en guardar trabajador, Verifique datos de guardado";
    }
  }

  Future<List<WorkerModel>> getListWokersModel() async {
    final QuerySnapshot querySnapshot =
        await firestore.collection('Trabajador').get();
    List<WorkerModel> workerList = [];
    if (querySnapshot.docs.isNotEmpty) {
      for (var worker in querySnapshot.docs) {
        WorkerModel workerModel =
            WorkerModel.fromMap(worker.data() as Map<String, dynamic>);
        workerList.add(workerModel);
      }
      return workerList;
    } else {
      return [];
    }
  }

  Future<List<WorkerViewModel>> getListWokersViewModel() async {
    final QuerySnapshot querySnapshot = await firestore
        .collection('Trabajador')
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
  }

  Future<WorkerModel> getWorkerData(int numWorker) async {
    QuerySnapshot userSnapshot = await firestore
        .collection("Trabajador")
        .where("numTrabajador", isEqualTo: numWorker)
        .get();
    Map<String, dynamic> userData =
        userSnapshot.docs.first.data() as Map<String, dynamic>;
    WorkerModel workerModel = WorkerModel.fromMap(userData);
    return workerModel;
  }
}
