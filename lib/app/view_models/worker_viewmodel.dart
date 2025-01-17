import 'package:control_asistencia_app/app/packages/packagelocal_model.dart';

class WorkerViewModel {
  late String _numWorker;

  late String _firstNameWorker;

  late String _lastNameWorker;

  String? _urlPhoto;

  WorkerViewModel(WorkerModel workerModel) {
    _numWorker = workerModel.numTrabajador.toString().trim();
    List<String> firstNameWorkerArray = workerModel.nombre.split(' ');
    List<String> lastNameWorkerArray = workerModel.apellido.split(' ');
    _firstNameWorker = firstNameWorkerArray[0];
    _lastNameWorker = lastNameWorkerArray[0];
    _urlPhoto = workerModel.urlPhoto;
  }

  String get urlPhoto => _urlPhoto!;

  String get numWorker => _numWorker;

  String get firstNameWorker => _firstNameWorker;

  String get lastNameWorker => _lastNameWorker;
}
