import 'package:control_asistencia_app/app/packages/packagelocal_common.dart';
import 'package:control_asistencia_app/app/packages/packagelocal_controller.dart';
import 'package:control_asistencia_app/app/packages/packagelocal_model.dart';
import 'package:control_asistencia_app/app/packages/packages_pub.dart';

class ServicesFoodController {
  final FirebaseServiceCommon _firebaseServiceCommon = FirebaseServiceCommon();
  final WorkerController _workerController = WorkerController();

  Future<String> addServiceFoodController(
      FoodServicesModel foodServiceModel, int numWorker) async {
    WorkerModel? workerModel = await _workerController.getWorkerData(numWorker);
    if (workerModel == null) {
      debugPrint("Trabajador No encontrado");
      return "Trabajador";
    }
    try {
      final foodServiceMap = foodServiceModel.toMap();
      final foodServiceDay = foodServiceMap["fecha"];
      await _firebaseServiceCommon.firebaseAuth.signInAnonymously();
      final CollectionReference subCollecServiceFood = _firebaseServiceCommon
          .firestore
          .collection("Trabajador/${workerModel.numTrabajador}/Comedor");
      await subCollecServiceFood
          .doc(foodServiceDay)
          .set(foodServiceMap, SetOptions(merge: true));
      await getListFoodService();
      await _firebaseServiceCommon.firebaseAuth.signOut();
      return "comida guardado";
    } catch (e) {
      debugPrint("Error: $e");
      return "error desconocido";
    }
  }

  Future<void> getListFoodService() async {
    final breakFastInstance = BreakFastModel.instance();
    Map<String, dynamic> diningRoomMap = {};
    try {
      final QuerySnapshot querySnapshot =
          await _firebaseServiceCommon.firestore.collection("Trabajador").get();

      final workerDocs = querySnapshot.docs;
      List<FoodServicesModel> breakFastModelList = [];
      if (workerDocs.isNotEmpty) {
        for (var workerDoc in workerDocs) {
          // WorkerModel workerModel =
          //     WorkerModel.fromMap(workerDoc.data() as Map<String, dynamic>);
          final diningRoomCollection =
              workerDoc.reference.collection("Comedor");
          QuerySnapshot diningRoomQuery = await diningRoomCollection.get();
          if (diningRoomQuery.docs.isNotEmpty) {
            final Map<String, dynamic> diningRoomData =
                diningRoomQuery.docs.first.data() as Map<String, dynamic>;
            final Map<String, dynamic> desayunoData =
                diningRoomData["Desayuno"];
            final String horaDesayuno = desayunoData["hora"];
            diningRoomMap = {
              "hora": horaDesayuno,
              "fecha": diningRoomData["fecha"],
            };
            final breakFastModel = breakFastInstance.fromMap(diningRoomMap);
            breakFastModelList.add(breakFastModel);
            diningRoomData.forEach((key, value) {
              if (value is Map) {
                debugPrint("Campo: $key");
                value.forEach((innerKey, innerValue) {
                  debugPrint(" $innerKey: $innerValue");
                });
              } else {
                debugPrint("Campo: $key, Valor: $value");
              }
            });
          }
        }
        debugPrint("----------");
        debugPrint("${breakFastModelList.toList()}");
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
  }
}
