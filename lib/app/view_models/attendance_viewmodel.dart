import 'package:control_asistencia_app/app/model/attendance/checkout_model.dart';
import 'package:control_asistencia_app/app/model/attendance/ckeckin_model.dart';
import 'package:control_asistencia_app/app/model/user/worker_model.dart';

class AttendanceViewModel {
  String? _firstNameWorker;

  String? _lastNameWorker;

  String? _checkInHour;

  String? _urlPhoto;

  String? _checkOutHour;

  AttendanceViewModel(
      {required WorkerModel workerModel,
      required CheckInModel checkInModel,
      required CheckOutModel checkOutModel}) {
    List<String> firstNameWorkerArray = workerModel.nombre.split(' ');
    List<String> lastNameWorkerArray = workerModel.apellido.split(' ');
    _firstNameWorker = firstNameWorkerArray[0];
    _lastNameWorker = lastNameWorkerArray[0];
    _checkInHour = checkInModel.hora;
    _checkOutHour = checkOutModel.hora;
    _urlPhoto = workerModel.urlPhoto;
  }

  String get checkOutHour => _checkOutHour!;

  String get urlPhoto => _urlPhoto!;

  String get checkInHour => _checkInHour!;

  String get firstNameWorker => _firstNameWorker!;

  String get lastNameWorker => _lastNameWorker!;
}
