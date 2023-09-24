import 'package:dio/dio.dart';
import 'package:control_asistencia_app/app/model/api/http_request.dart';
import 'package:control_asistencia_app/app/model/worker_model.dart';
import 'package:flutter/material.dart';

class WorkerController {
  Future<List<WorkerModel>> getListWokers() async {
    final Response response = await HttpRequest.httpGet("/workers/listWorkers");
    List<WorkerModel> workerList = [];
    for (var worker in response.data) {
      WorkerModel workerModel = WorkerModel.fromMap(worker);
      workerList.add(workerModel);
    }
    return workerList;
  }

  Future<String> getWorkerFromNumber(int numTrabajador) async {
    final Response response = await HttpRequest.httpGet(
        "/workers/workerData?numTrabajador=$numTrabajador");
    try {
      return response.statusCode == 404 ? "no encontrado" : "encontrado";
    } catch (error) {
      debugPrint('''
        Error al verificar la existencia del trabajador.
          {
            Código de estado: ${response.statusCode},
            Mensaje: ${response.statusMessage}
          }
          ''');
      throw Exception('''
          $error,
          {
            Código de estado: ${response.statusCode},
            Mensaje: ${response.statusMessage}
          }
          ''');
    }
  }

  Future<String> addWorker(WorkerModel workerModel) async {
    try {
      final workerMap = workerModel.toMap();
      final numWorker = workerMap["numTrabajador"];
      final String result = await getWorkerFromNumber(numWorker);
      if (result != "encontrado") {
        HttpRequest.httpPost("/workers/register/", workerMap);
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
