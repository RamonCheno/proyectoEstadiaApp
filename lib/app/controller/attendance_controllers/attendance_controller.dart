import 'package:control_asistencia_app/app/common/firebase_service_common.dart';
import 'package:control_asistencia_app/app/packages/packagelocal_controller.dart';
import 'package:control_asistencia_app/app/packages/packagelocal_model.dart';
import 'package:control_asistencia_app/app/packages/packages_pub.dart';
import 'package:control_asistencia_app/app/packages/packageslocal_view.dart';

class AttendanceController {
  final FirebaseServiceCommon _firebaseServiceCommon = FirebaseServiceCommon();
  final WorkerController _workerController = WorkerController();

  Future<String> addCheckIn(
      AttendanceModel attendanceModel, int numWorker) async {
    WorkerModel? workerModel = await _workerController.getWorkerData(numWorker);
    if (workerModel == null) {
      debugPrint("Trabajador No encontrado");
      return "Trabajador";
    }
    try {
      final checkInMap = attendanceModel.toMap();
      final checkInDay = checkInMap["fecha"];
      await _firebaseServiceCommon.firebaseAuth.signInAnonymously();
      final CollectionReference subColleAttendance = _firebaseServiceCommon
          .firestore
          .collection("Trabajador/${workerModel.numTrabajador}/Asistencia");
      await subColleAttendance.doc(checkInDay).set({
        "Entrada": checkInMap,
        "Salida": {
          "fecha": null,
          "hora": null,
        }
      });
      await _firebaseServiceCommon.firebaseAuth.signOut();
      return "asistencia guardado";
    } catch (e) {
      debugPrint("Error: $e");
      return "error desconocido";
    }
  }

  Future<String> addCheckOut(AttendanceModel attendanceModel, int numWorker,
      String fechaEntrada) async {
    WorkerModel? workerModel = await _workerController.getWorkerData(numWorker);
    if (workerModel == null) {
      debugPrint("Trabajador No encontrado");
      return "Trabajador";
    }
    try {
      final checkOutMap = attendanceModel.toMap();
      await _firebaseServiceCommon.firebaseAuth.signInAnonymously();
      final CollectionReference subColleAttendance = _firebaseServiceCommon
          .firestore
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
        await _firebaseServiceCommon.firebaseAuth.signOut();
        return "asistencia guardado";
      }
    } catch (e) {
      debugPrint("Error: $e");
      return "error desconocido";
    }
  }

  Future<List<AttendanceViewModel>> getListAttendanceViewModel(
      String fecha) async {
    final checkInstance = CheckInModel.instance();
    final checkOutInstance = CheckOutModel.instance();
    try {
      final QuerySnapshot querySnapshotWorker = await _firebaseServiceCommon
          .firestore
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
                checkInstance.fromMap(attendanceData["Entrada"]);
            final CheckOutModel checkOutModel =
                checkOutInstance.fromMap(attendanceData["Salida"]);
            AttendanceViewModel attendanceViewModel = AttendanceViewModel(
                checkInModel: checkInModel,
                workerModel: workerModel,
                checkOutModel: checkOutModel);
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
