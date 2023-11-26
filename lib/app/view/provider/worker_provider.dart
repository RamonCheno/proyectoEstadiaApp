import 'dart:io';

import 'package:control_asistencia_app/app/controller/worker_controllers/worker_controller.dart';
import 'package:control_asistencia_app/app/model/user/worker_model.dart';
import 'package:control_asistencia_app/app/packages/packages_pub.dart';
import 'package:control_asistencia_app/app/view/widget/customdialog_widget.dart';
import 'package:control_asistencia_app/app/view_models/worker_viewmodel.dart';
import 'package:flutter/material.dart';

class WorkerProvider with ChangeNotifier {
  final WorkerController _workerController = WorkerController();
  List<WorkerViewModel> _listWorkerViewModelHigh = [];
  List<WorkerViewModel> get listWorkerViewModelHigh => _listWorkerViewModelHigh;

  List<WorkerViewModel> _listWorkerViewModelLow = [];
  List<WorkerViewModel> get listWorkerViewModelLow => _listWorkerViewModelLow;

  Future<String> addWokerProvider(WorkerModel workerModel) async {
    String response = await _workerController.addWorker(workerModel).then(
      (methodResponse) {
        return methodResponse;
      },
    );
    notifyListeners();
    return response;
  }

  Future<void> getDataWorkerVModel(String isWorking) async {
    if (isWorking == "alta") {
      _listWorkerViewModelHigh =
          await _workerController.getListWokersViewModel("alta");
    } else {
      _listWorkerViewModelLow =
          await _workerController.getListWokersViewModel("baja");
    }
    notifyListeners();
  }

  Future<WorkerModel> selectWorkerModel(int numWorker) async {
    WorkerModel? workerModelSelect = await _workerController
        .getWorkerData(numWorker, useAnonymousAuth: false);
    notifyListeners();
    return workerModelSelect!;
  }

  Future<String> updateWorkerProvider(
      WorkerModel workerModel, int numWorkerSelect) async {
    String response =
        await _workerController.updateWorker(numWorkerSelect, workerModel).then(
              (methodResponse) => methodResponse,
            );
    notifyListeners();
    return response;
  }

  Future<void> setVisibleWorkerProvider(int numWorker, bool working) async {
    WorkerModel workerModel = await selectWorkerModel(numWorker);
    await _workerController.setVisibleWorker(numWorker, working, workerModel);
  }

  Future<void> deleteWorkerProvider(
      String nameColection, int numWorker, bool working) async {
    await setVisibleWorkerProvider(numWorker, working);
    await _workerController.deleteSubColeccionWorker(nameColection, numWorker);

    notifyListeners();
  }

  void showResponseDialog(BuildContext context, String response,
      {bool addWorker = false}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.of(context).pop();
          if (addWorker) {
            Navigator.of(context).pop();
          }
        });
        return CustomDialogWidget(
          messagge: Text(response),
          iconData: addWorker
              ? const Icon(Icons.check_circle, color: Colors.green)
              : const Icon(Icons.cancel, color: Colors.red),
        );
      },
    );
  }

  Future<String> getUrlImage(
      File image, String firstName, String lastName) async {
    String urlPhoto = await _workerController.uploadImageToStorage(
        image, firstName, lastName);
    notifyListeners();
    return urlPhoto;
  }
}
