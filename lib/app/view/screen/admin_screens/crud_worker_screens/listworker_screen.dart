import 'package:cached_network_image/cached_network_image.dart';
import 'package:control_asistencia_app/app/model/user/worker_model.dart';
import 'package:control_asistencia_app/app/view/provider/worker_provider.dart';
import 'package:control_asistencia_app/app/view/screen/admin_screens/crud_worker_screens/addworker_screen.dart';
import 'package:control_asistencia_app/app/view/screen/admin_screens/crud_worker_screens/updateworker_screen.dart';
import 'package:control_asistencia_app/app/view/widget/customdialog_widget.dart';
import 'package:control_asistencia_app/app/view/widget/searchfield_widget.dart';
import 'package:control_asistencia_app/app/view_models/worker_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ListWorkerScreen extends StatefulWidget {
  const ListWorkerScreen({super.key});
  static const route = "/listWorkerScreen";

  @override
  State<ListWorkerScreen> createState() => _ListWorkerScreenState();
}

class _ListWorkerScreenState extends State<ListWorkerScreen> {
  // TextEditingController _searchNombreController = TextEditingController();
  // List<String> suggestionsWorker = [];

  void refreshWorker(WorkerProvider workerProvider, String isWorking) async {
    await workerProvider.getDataWorkerVModel(isWorking);
  }

  void registerWorkerScreen() {
    final workerProvider = Provider.of<WorkerProvider>(context, listen: false);
    //Hacer un dialog donde pregunte el numero del trabajador y si se encontro, que se actualice el campo trabajando
    //si no se encontro, dar opcion de agregar un nuevo trabajado.

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialogWidget(
            iconData: const Icon(Icons.search),
            messagge: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  SearchFieldWidget(
                    workerProvider: workerProvider,
                    isWorking: 'baja',
                    action: (numWorker) {
                      workerProvider.setVisibleWorkerProvider(numWorker, true);
                      Navigator.pop(context);
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 1,
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          textStyle: const TextStyle(fontSize: 18),
                          backgroundColor: const Color(0xFFD9D9D9),
                          foregroundColor: const Color(0xFF000000),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context)
                              .pushNamed(AddWorkerScreen.route);
                        },
                        child: const Text(
                          "Registrar nuevo personal",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });

    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return AlertDialog(
    //       title: const Text("Buscador de personal existente"),
    //       content: Container(
    //           padding: const EdgeInsets.symmetric(vertical: 10),
    //           child: Column(
    //             children: [
    //               SearchFieldWidget(
    //                 workerProvider: workerProvider,
    //                 isWorking: 'baja',
    //                 action: (numWorker) {
    //                   workerProvider.setVisibleWorkerProvider(numWorker, true);
    //                   Navigator.pop(context);
    //                 },
    //               ),
    //               Container(
    //                 margin: const EdgeInsets.symmetric(vertical: 10),
    //                 child: Center(
    //                   child: ElevatedButton(
    //                     style: ElevatedButton.styleFrom(
    //                       elevation: 1,
    //                       padding: const EdgeInsets.symmetric(horizontal: 24),
    //                       textStyle: const TextStyle(fontSize: 18),
    //                       backgroundColor: const Color(0xFFD9D9D9),
    //                       foregroundColor: const Color(0xFF000000),
    //                       shape: RoundedRectangleBorder(
    //                         borderRadius: BorderRadius.circular(20),
    //                       ),
    //                     ),
    //                     onPressed: () {
    //                       Navigator.of(context).pop();
    //                       Navigator.of(context)
    //                           .pushNamed(AddWorkerScreen.route);
    //                     },
    //                     child: const Text(
    //                       "Registrar nuevo personal",
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           )),
    //     );
    //   },
    // );
  }

  void deteleWorkerColection(
      WorkerProvider workerProvider, int numWorker) async {
    workerProvider.deleteWorkerProvider(
      "Asistencia",
      numWorker,
      false,
    );
  }

  void updateWorkerScreen(int numWorker, WorkerProvider workerProvider) async {
    WorkerModel workerModelSelect =
        await workerProvider.selectWorkerModel(numWorker);
    if (!mounted) return;
    Navigator.pushNamed(context, UpdateWorkerScreen.route, arguments: {
      "numWorkerSelectArg": numWorker,
      "workerModelSelectArg": workerModelSelect
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Trabajador"),
        centerTitle: true,
        backgroundColor: const Color(0xffEBEBEB),
      ),
      backgroundColor: const Color(0xffD9D9D9),
      body: Consumer<WorkerProvider>(
        builder: (context, workerProvider, child) {
          refreshWorker(workerProvider, "alta");
          List<WorkerViewModel> workerViewModelList =
              workerProvider.listWorkerViewModelHigh;
          return workerViewModelList.isEmpty
              ? Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Text(
                          'Presione el "botón +" para agregar un trabajador a la lista',
                          style: TextStyle(
                              fontSize: 20.sp, color: Colors.black45)),
                    ),
                    const Center(
                      child:
                          CircularProgressIndicator(color: Color(0xffF69100)),
                    )
                  ],
                )
              : Column(
                  children: [
                    SearchFieldWidget(
                        workerProvider: workerProvider,
                        isWorking: "alta",
                        action: (numWorker) {
                          updateWorkerScreen(numWorker, workerProvider);
                        }),
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          final WorkerViewModel workerViewModel =
                              workerViewModelList[index];
                          String numWorkerText = workerViewModel.numWorker;
                          String firstNameWorker =
                              workerViewModel.firstNameWorker;
                          String lastNameWorker =
                              workerViewModel.lastNameWorker;
                          String urlImage = workerViewModel.urlPhoto;
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
                              leading: CircleAvatar(
                                radius: 25.r,
                                backgroundColor: const Color(0xffE1E1E1),
                                foregroundImage: urlImage.isNotEmpty
                                    ? CachedNetworkImageProvider(urlImage)
                                    : null,
                                backgroundImage: urlImage.isNotEmpty
                                    ? null
                                    : const AssetImage(
                                        "assets/images/usuario.png"),
                              ),
                              title: Text("$firstNameWorker $lastNameWorker"),
                              subtitle: Text(numWorkerText),
                              onTap: () {
                                int numWorker = int.parse(numWorkerText);
                                updateWorkerScreen(numWorker, workerProvider);
                                debugPrint(
                                    "Item presionado con numero: $numWorker");
                              },
                              trailing: PopupMenuButton(
                                itemBuilder: (context) => <PopupMenuEntry<int>>[
                                  PopupMenuItem<int>(
                                    value: 1,
                                    child: const ListTile(
                                      leading: Icon(Icons.delete),
                                      title: Text("Dar baja"),
                                    ),
                                    onTap: () {
                                      deteleWorkerColection(
                                        workerProvider,
                                        int.parse(numWorkerText),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: workerViewModelList.length,
                        separatorBuilder: (BuildContext context, int index) =>
                            10.verticalSpace,
                      ),
                    ),
                  ],
                );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: SizedBox(
        height: 60.h,
        child: FittedBox(
          child: FloatingActionButton(
            shape: const CircleBorder(),
            backgroundColor: const Color(0xffD9D9D9),
            onPressed: registerWorkerScreen,
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
