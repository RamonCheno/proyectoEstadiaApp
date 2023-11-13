import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control_asistencia_app/app/controller/worker_controllers/worker_controller.dart';
import 'package:control_asistencia_app/app/model/attendance/checkout_model.dart';
import 'package:control_asistencia_app/app/model/attendance/ckeckin_model.dart';
import 'package:control_asistencia_app/app/model/user/worker_model.dart';
import 'package:control_asistencia_app/app/view_models/attendance_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AttendanceController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final WorkerController _workerController = WorkerController();

  Future<bool> addCheckIn(CheckInModel checkInModel, int numWorker) async {
    //TODO:Añadir docuemento asistencia dontro de la coleccion Trabajador
    WorkerModel? workerModel = await _workerController.getWorkerData(numWorker);
    if (workerModel == null) {
      debugPrint("Trabajador No encontrado");
      return false;
    }
    try {
      final checkInMap = checkInModel.toMap();
      final checkInDay = checkInMap["fecha"];
      await _firebaseAuth.signInAnonymously();
      final CollectionReference subColleAttendance = _firestore
          .collection("Trabajador/${workerModel.numTrabajador}/Asistencia");
      await subColleAttendance
          .doc(checkInDay)
          .set({"Entrada": checkInMap, "Salida": null});
      await _firebaseAuth.signOut();
      return true;
    } catch (e) {
      debugPrint("Error: $e");
      return false;
    }
  }

  Future<String> addCheckOut(
      CheckOutModel attendanceModel, int numWorker, String fechaEntrada) async {
    //TODO:Actualizar docuemento asistencia dontro de la coleccion Trabajador
    WorkerModel? workerModel = await _workerController.getWorkerData(numWorker);
    if (workerModel == null) {
      debugPrint("Trabajador No encontrado");
      return "Trabajador";
    }
    try {
      final checkOutMap = attendanceModel.toMap();
      await _firebaseAuth.signInAnonymously();
      final CollectionReference subColleAttendance = _firestore
          .collection("Trabajador/${workerModel.numTrabajador}/Asistencia");

      DocumentReference documentReference =
          subColleAttendance.doc(fechaEntrada);
      final DocumentSnapshot document = await documentReference.get();
      if (!document.exists) {
        debugPrint("Error: fecha no encontrado");
        return "fecha";
      } else {
        await documentReference.update({"Salida": checkOutMap});
        debugPrint(documentReference.id);
        await _firebaseAuth.signOut();
        return "asistencia guardado";
      }
    } catch (e) {
      debugPrint("Error: $e");
      return "error desconocido";
    }
  }

  Future<List<AttendanceViewModel>> getListAttendanceViewModel(
      String fecha) async {
    try {
      final QuerySnapshot querySnapshotWorker = await _firestore
          .collection('Trabajador')
          .orderBy("apellido", descending: false)
          .get();

      final workersDocs = querySnapshotWorker.docs;

      List<AttendanceViewModel> attendanceViewModelList = [];
      if (workersDocs.isNotEmpty) {
        for (var workerDoc in workersDocs) {
          WorkerModel workerModel =
              WorkerModel.fromMap(workerDoc.data() as Map<String, dynamic>);
          final attendanceCollection =
              workerDoc.reference.collection("Asistencia");
          QuerySnapshot attendanceQuery = await attendanceCollection
              .where("Entrada.fecha", isEqualTo: fecha)
              .get();
          if (attendanceQuery.docs.isNotEmpty) {
            final Map<String, dynamic> attendanceData =
                attendanceQuery.docs.first.data() as Map<String, dynamic>;
            final CheckInModel checkInModel =
                CheckInModel.fromMap(attendanceData["Entrada"]);
            // final CheckOutModel checkOutModel =
            //     CheckOutModel.fromMap(attendanceData["Salida"]);
            AttendanceViewModel attendanceViewModel = AttendanceViewModel(
                checkInModel: checkInModel, workerModel: workerModel);
            attendanceViewModelList.add(attendanceViewModel);
          }
        }
        return attendanceViewModelList;
      } else {
        debugPrint("No hay trabajador con asistecia");
        return [];
      }
    } catch (e) {
      debugPrint("$e");

      return [];
    }
  }
}
