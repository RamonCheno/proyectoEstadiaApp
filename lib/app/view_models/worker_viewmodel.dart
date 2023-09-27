import 'package:control_asistencia_app/app/model/worker_model.dart';

class WorkerViewModel {
  late String _numWorker;

  late String _firstNameWorker;

  late String _lastNameWorker;

  WorkerViewModel(WorkerModel workerModel) {
    _numWorker = workerModel.numTrabajador.toString().trim();
    List<String> nameCompleteWorker = workerModel.nombre.split(' ');
    _firstNameWorker = nameCompleteWorker[0];
    _lastNameWorker = nameCompleteWorker[2];
  }

  String get numWorker => _numWorker;

  String get firstNameWorker => _firstNameWorker;

  String get lastNameWorker => _lastNameWorker;
}
