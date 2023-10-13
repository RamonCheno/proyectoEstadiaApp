import 'package:control_asistencia_app/app/model/worker_model.dart';

class WorkerViewModel {
  late String _numWorker;

  late String _firstNameWorker;

  late String _lastNameWorker;

  WorkerViewModel(WorkerModel workerModel) {
    _numWorker = workerModel.numTrabajador.toString().trim();
    List<String> firstNameWorker = workerModel.nombre.split(' ');
    List<String> lastNameWorker = workerModel.apellido.split(' ');
    _firstNameWorker = firstNameWorker[0];
    _lastNameWorker = lastNameWorker[0];
  }

  String get numWorker => _numWorker;

  String get firstNameWorker => _firstNameWorker;

  String get lastNameWorker => _lastNameWorker;
}
