// import 'package:control_asistencia_app/app/controller/admin_controllers/worker_controller.dart';
import 'package:control_asistencia_app/app/controller/worker_controllers/worker_controller.dart';
import 'package:control_asistencia_app/app/view/screen/admin_screens/addworker_screen.dart';
import 'package:control_asistencia_app/app/view_models/worker_viewmodel.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListWorkerScreen extends StatefulWidget {
  const ListWorkerScreen({super.key});
  static const route = "/listWorkerScreen";

  @override
  State<ListWorkerScreen> createState() => _ListWorkerScreenState();
}

class _ListWorkerScreenState extends State<ListWorkerScreen> {
  final WorkerController workerController = WorkerController();

  List<WorkerViewModel> _workerViewModelList = [];

  Future<List<WorkerViewModel>> _getListWorker() async {
    List<WorkerViewModel> listWorkerViewModel =
        await workerController.getListWokersViewModel();
    return listWorkerViewModel;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // _getListWorker().then((_) {
    //   setState(() {});
    // });
  }

  Future<void> registerWorker() async {
    Navigator.of(context).pushNamed(AddWorkerScreen.route).then((_) {
      _getListWorker().then((_) {
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EasySearchBar(
        title: const Text(
          "Trabajadores",
          style: TextStyle(fontWeight: FontWeight.w700),
          textAlign: TextAlign.center,
        ),
        onSearch: (value) => null,
        backgroundColor: const Color(0xffEBEBEB),
      ),
      backgroundColor: const Color(0xffEBEBEB),
      body: Column(
        children: [
          10.verticalSpace,
          Expanded(
              child: FutureBuilder(
            future: _getListWorker(),
            builder: (BuildContext context,
                AsyncSnapshot<List<WorkerViewModel>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(color: Color(0xffF69100)),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                _workerViewModelList = snapshot.data as List<WorkerViewModel>;
                return _workerViewModelList.isEmpty
                    ? Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10.h),
                            child: Text(
                                'Presione el "botón +" para agregar un alumno a la lista',
                                style: TextStyle(
                                    fontSize: 20.sp, color: Colors.black45)),
                          ),
                          const Center(
                            child: CircularProgressIndicator(
                                color: Color(0xffF69100)),
                          )
                        ],
                      )
                    : ListView.separated(
                        itemBuilder: (context, index) {
                          final WorkerViewModel workerViewModel =
                              _workerViewModelList[index];
                          String numWorker = workerViewModel.numWorker;
                          String firstNameWorker =
                              workerViewModel.firstNameWorker;
                          String lastNameWorker =
                              workerViewModel.lastNameWorker;
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
                        itemCount: _workerViewModelList.length,
                        separatorBuilder: (BuildContext context, int index) =>
                            10.verticalSpace,
                      );
              }
            },
          )),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: SizedBox(
        height: 60.h,
        child: FittedBox(
          child: FloatingActionButton(
            shape: const CircleBorder(),
            backgroundColor: const Color(0xffD9D9D9),
            onPressed: registerWorker,
            child: Icon(
              Icons.person_add_outlined,
              size: 30.r,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
