import 'package:control_asistencia_app/app/packages/packagelocal_model.dart';

class AttendanceViewModel {
  String? _numberWorker;
  String? _firstNameWorker;

  String? _lastNameWorker;

  String? _checkInHour;

  String? _urlPhoto;

  String? _checkOutHour;
  String? _dayEntrance;
  String? _dayFinish;

  AttendanceViewModel.instance();

  AttendanceViewModel(
      {required WorkerModel workerModel,
      required CheckInModel checkInModel,
      required CheckOutModel checkOutModel}) {
    _numberWorker = workerModel.numTrabajador.toString();
    List<String> firstNameWorkerArray = workerModel.nombre.split(' ');
    List<String> lastNameWorkerArray = workerModel.apellido.split(' ');
    _firstNameWorker = firstNameWorkerArray[0];
    _lastNameWorker = lastNameWorkerArray[0];
    _checkInHour = checkInModel.hora;
    _checkOutHour = checkOutModel.hora;
    _urlPhoto = workerModel.urlPhoto;
    _dayEntrance = checkInModel.fecha;
    _dayFinish = checkOutModel.fecha;
  }

  String get numberWorker => _numberWorker!;

  String get urlPhoto => _urlPhoto!;

  String get firstNameWorker => _firstNameWorker!;

  String get lastNameWorker => _lastNameWorker!;

  String? get checkInHour => _checkInHour;

  String? get checkOutHour => _checkOutHour;

  String get dayEntrance => _dayEntrance ?? "";

  String get dayFinish => _dayFinish ?? "";
}
