import 'package:control_asistencia_app/app/model/user/worker_model.dart';

class WorkerViewModel {
  String? _numWorker;

  String? _firstNameWorker;

  String? _lastNameWorker;

  WorkerViewModel(WorkerModel workerModel) {
    _numWorker = workerModel.numTrabajador.toString().trim();
    List<String> firstNameWorkerArray = workerModel.nombre.split(' ');
    List<String> lastNameWorkerArray = workerModel.apellido.split(' ');
    _firstNameWorker = firstNameWorkerArray[0];
    _lastNameWorker = lastNameWorkerArray[0];
  }

  String get numWorker => _numWorker!;

  String get firstNameWorker => _firstNameWorker!;

  String get lastNameWorker => _lastNameWorker!;
}
