import 'package:control_asistencia_app/app/controller/worker_controllers/worker_controller.dart';
import 'package:control_asistencia_app/app/view_models/worker_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListAttendance extends StatefulWidget {
  const ListAttendance({super.key});
  static const route = "/listAttendanceWorker";

  @override
  State<ListAttendance> createState() => _ListAttendanceState();
}

class _ListAttendanceState extends State<ListAttendance> {
  final WorkerController workerController = WorkerController();
  Future<List<WorkerViewModel>> _getListWorker() async {
    List<WorkerViewModel> workerViewModelList =
        await workerController.getListWokersViewModel();
    return workerViewModelList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Asistencia",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xffEBEBEB),
      ),
      backgroundColor: const Color(0xffEBEBEB),
      body: Column(children: [
        10.verticalSpace,
        Expanded(
            child: FutureBuilder(
          future: _getListWorker(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: Color(0xffF69100)),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              List<WorkerViewModel> workerViewModelList =
                  snapshot.data as List<WorkerViewModel>;
              return ListView.separated(
                itemBuilder: (context, index) {
                  final WorkerViewModel workerViewModel =
                      workerViewModelList[index];
                  String numWorker = workerViewModel.numWorker;
                  String firstNameWorker = workerViewModel.firstNameWorker;
                  String lastNameWorker = workerViewModel.lastNameWorker;
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15).r,
                        color: const Color(0XFFF4F4F4),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0.0, 3.0),
                              blurRadius: 1),
                        ]),
                    child: ListTile(
                      title: Text("$firstNameWorker $lastNameWorker"),
                      subtitle: Text(numWorker),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    10.verticalSpace,
                itemCount: workerViewModelList.length,
              );
            }
          },
        ))
      ]),
    );
  }
}
