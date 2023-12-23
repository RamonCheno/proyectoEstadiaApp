import 'package:control_asistencia_app/app/controller/worker_controllers/worker_controller.dart';
import 'package:control_asistencia_app/app/packages/packages_pub.dart';
import 'package:control_asistencia_app/dev/firebase_options_dev.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:control_asistencia_app/app/packages/packagelocal_common.dart'
    show FirebaseServiceCommon;
import 'package:control_asistencia_app/app/packages/packagelocal_model.dart'
    show WorkerModel;

class MockFirebaseCommon extends Mock implements FirebaseServiceCommon {}

@GenerateMocks([FirebaseServiceCommon, Firebase])
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptionsDev.currentPlatform);

  group('WorkerController - addWorker Tests', () {
    late final MockFirebaseCommon firebaseServiceCommon;
    late final WorkerController workerController;
    setUpAll(() {
      firebaseServiceCommon = MockFirebaseCommon();
      workerController = WorkerController();
    });
    test("Prueba de exito para agregar trabajador", () async {
      final workerModel = WorkerModel(
          numTrabajador: 12345678,
          nombre: "prueba",
          apellido: "1",
          curp: "41564856df4sa6d4",
          numImss: 12345678910,
          rfc: "4d54sa5d4sa56dsa",
          puesto: "ingeniero",
          visible: false);
      when(firebaseServiceCommon.firestore
              .collection('Trabajador')
              .doc('123')
              .set(workerModel.toMap()))
          .thenAnswer((_) async {});

      final result = await workerController.addWorker(workerModel);
      expect(result, "Trabajador agregado");
      verify(firebaseServiceCommon.firestore
          .collection('Trabajador')
          .doc('123')
          .set(workerModel.toMap()));
    });
  });
}
