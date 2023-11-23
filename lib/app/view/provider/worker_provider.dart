import 'dart:io';

import 'package:control_asistencia_app/app/controller/worker_controllers/worker_controller.dart';
import 'package:control_asistencia_app/app/model/user/worker_model.dart';
import 'package:control_asistencia_app/app/packages/packages_pub.dart';
import 'package:control_asistencia_app/app/view/widget/customdialog_widget.dart';
import 'package:control_asistencia_app/app/view_models/worker_viewmodel.dart';
import 'package:flutter/material.dart';

class WorkerProvider with ChangeNotifier {
  final WorkerController _workerController = WorkerController();
  List<WorkerViewModel> _listWorkerViewModel = [];
  List<WorkerViewModel> get listWorkerViewModel => _listWorkerViewModel;

  Future<String> addWokerProvider(WorkerModel workerModel) async {
    String response = await _workerController.addWorker(workerModel).then(
      (methodResponse) {
        return methodResponse;
      },
    );
    notifyListeners();
    return response;
  }

  Future<void> getDataWorkerVModel() async {
    _listWorkerViewModel = await _workerController.getListWokersViewModel();
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
