// import 'package:control_asistencia_app/app/controller/admin_controllers/worker_controller.dart';
import 'package:control_asistencia_app/app/controller/worker_controllers/worker_controller.dart';
import 'package:control_asistencia_app/app/view/screen/admin_screens/addworker_screen.dart';
import 'package:control_asistencia_app/app/view_models/worker_viewmodel.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';

class ListWorkerScreen extends StatefulWidget {
  const ListWorkerScreen({super.key});
  static const route = "/listWorkerScreen";

  @override
  State<ListWorkerScreen> createState() => _ListWorkerScreenState();
}

class _ListWorkerScreenState extends State<ListWorkerScreen> {
  WorkerController workerController = WorkerController();

  List<WorkerViewModel> _workersViewModel = [];

  Future<List<WorkerViewModel>> _getListWorker() async {
    List<WorkerViewModel> workerViewModelList =
        await workerController.getListWokersViewModel();
    return workerViewModelList;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getListWorker().then((worker) {
      setState(() {
        _workersViewModel = worker;
      });
    });
  }

  Future<void> _updateListWorker(dynamic data) async {
    _workersViewModel = data;
    debugPrint('${_workersViewModel.toList()}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EasySearchBar(
        title: const Text(
          "Trabajadores",
          textAlign: TextAlign.center,
        ),
        onSearch: (value) => null,
        backgroundColor: const Color(0xffEBEBEB),
      ),
      backgroundColor: const Color(0xffEBEBEB),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: FutureBuilder(
            future: _getListWorker(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.none ||
                  (!snapshot.hasData || _workersViewModel.isEmpty)) {
                return Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: const Text(
                          'Presione el "botón +" para agregar un alumno a la lista',
                          style:
                              TextStyle(fontSize: 20, color: Colors.black45)),
                    ),
                    const Center(
                      child:
                          CircularProgressIndicator(color: Color(0xffF69100)),
                    ),
                  ],
                );
              }
              if (snapshot.data != null) {
                _updateListWorker(snapshot.data);
              }
              return ListView.separated(
                itemBuilder: (context, index) {
                  final WorkerViewModel workerViewModel =
                      _workersViewModel[index];
                  String numWorker = workerViewModel.numWorker;
                  String firstNameWorker = workerViewModel.firstNameWorker;
                  String lastNameWorker = workerViewModel.lastNameWorker;
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
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
                itemCount: _workersViewModel.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                  height: 10,
                ),
              );
            },
          )),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: const Color(0xffD9D9D9),
        onPressed: () => Navigator.of(context)
            .pushNamed(AddWorkerScreen.route)
            .then((value) => _getListWorker().then((worker) {
                  setState(() {
                    _workersViewModel = worker;
                  });
                })),
        child: const Icon(
          Icons.person_add_outlined,
          size: 40,
          color: Colors.black,
        ),
      ),
    );
  }
}
