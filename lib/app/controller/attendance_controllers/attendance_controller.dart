import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control_asistencia_app/app/controller/worker_controllers/worker_controller.dart';
import 'package:control_asistencia_app/app/model/attendance/checkout_model.dart';
import 'package:control_asistencia_app/app/model/attendance/ckeckin_model.dart';
import 'package:control_asistencia_app/app/model/user/worker_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AttendanceController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Map<int, String> docAttendance = {};
  String? id;
  WorkerController workerController = WorkerController();
  Future<bool> addCheckIn(CheckInModel checkInModel, int numWorker) async {
    //TODO:Añadir docuemento asistencia dontro de la coleccion Trabajador
    WorkerModel? workerModel = await workerController.getWorkerData(numWorker);
    if (workerModel == null) {
      debugPrint("Trabajador No encontrado");
      return false;
    }
    try {
      final checkInMap = checkInModel.toMap();
      final checkInDay = checkInMap["fecha"];
      await firebaseAuth.signInAnonymously();
      final CollectionReference subColleAttendance = firestore
          .collection("Trabajador/${workerModel.numTrabajador}/Asistencia");
      await subColleAttendance.doc(checkInDay).set({"Entrada": checkInMap});
      await firebaseAuth.signOut();
      return true;
    } catch (e) {
      debugPrint("Error: $e");
      return false;
    }
  }

  Future<String> addCheckOut(
      CheckOutModel attendanceModel, int numWorker, String fechaEntrada) async {
    //TODO:Actualizar docuemento asistencia dontro de la coleccion Trabajador
    WorkerModel? workerModel = await workerController.getWorkerData(numWorker);
    if (workerModel == null) {
      debugPrint("Trabajador No encontrado");
      return "Trabajador";
    }
    try {
      final checkOutMap = attendanceModel.toMap();
      await firebaseAuth.signInAnonymously();
      final CollectionReference subColleAttendance = firestore
          .collection("Trabajador/${workerModel.numTrabajador}/Asistencia");
      // final QuerySnapshot querySnapshot = await subColleAttendance
      //     .where("Entrada.fecha", isEqualTo: fechaEntrada)
      //     .get();
      // DocumentReference documentReference = querySnapshot.docs.first.reference;
      DocumentReference documentReference =
          subColleAttendance.doc(fechaEntrada);
      final DocumentSnapshot document = await documentReference.get();
      if (!document.exists) {
        debugPrint("Error: fecha no encontrado");
        return "fecha";
      } else {
        await documentReference.update({"Salida": checkOutMap});
        debugPrint(documentReference.id);
        await firebaseAuth.signOut();
        return "asistencia guardado";
      }
    } catch (e) {
      debugPrint("Error: $e");
      return "error desconocido";
    }
  }
}
