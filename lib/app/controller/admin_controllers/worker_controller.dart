import 'package:control_asistencia_app/app/view_models/worker_viewmodel.dart';
import 'package:dio/dio.dart';
import 'package:control_asistencia_app/app/model/api/http_request.dart';
import 'package:control_asistencia_app/app/model/worker_model.dart';
import 'package:flutter/material.dart';

class WorkerController {
  Future<List<WorkerViewModel>> getListWokersViewModel() async {
    final Response response = await HttpRequest.httpGet("/workers/listWorkers");

    List<WorkerViewModel> workerViewModelList = [];
    List<WorkerModel> workerList = [];
    if (response.statusCode == 200) {
      for (var worker in response.data) {
        WorkerModel workerModel = WorkerModel.fromMap(worker);
        workerList.add(workerModel);
        WorkerViewModel workerViewModel = WorkerViewModel(workerModel);
        workerViewModelList.add(workerViewModel);
      }
      return workerViewModelList;
    } else {
      return [];
    }
  }

  Future<List<WorkerModel>> getListWokersModel() async {
    final Response response = await HttpRequest.httpGet("/workers/listWorkers");
    List<WorkerModel> workerList = [];
    if (response.statusCode == 200) {
      for (var worker in response.data) {
        WorkerModel workerModel = WorkerModel.fromMap(worker);
        workerList.add(workerModel);
      }
      return workerList;
    } else {
      return [];
    }
  }

  Future<String> addWorker(WorkerModel workerModel) async {
    try {
      final workerMap = workerModel.toMap();
      Response response =
          await HttpRequest.httpPost("/workers/register/", workerMap);
      if (response.statusCode == 201) {
        return "Trabajador agregado";
      } else {
        return "Trabajador existente";
      }
    } catch (e) {
      debugPrint(e.toString());
      return "Error en guardar trabajador, Verifique datos de guardado";
    }
  }
}
