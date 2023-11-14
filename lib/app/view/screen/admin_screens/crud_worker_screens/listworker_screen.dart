import 'package:cached_network_image/cached_network_image.dart';
import 'package:control_asistencia_app/app/model/user/worker_model.dart';
import 'package:control_asistencia_app/app/view/provider/worker_provider.dart';
import 'package:control_asistencia_app/app/view/screen/admin_screens/crud_worker_screens/addworker_screen.dart';
import 'package:control_asistencia_app/app/view/screen/admin_screens/crud_worker_screens/updateworker_screen.dart';
import 'package:control_asistencia_app/app/view_models/worker_viewmodel.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
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
  void refreshWorker() async {
    final workerProvider = Provider.of<WorkerProvider>(context, listen: false);
    await workerProvider.getDataWorkerVModel();
  }

  void registerWorkerScreen() {
    Navigator.of(context).pushNamed(AddWorkerScreen.route);
  }

  void updateWorkerScreen(int numWorker) async {
    final workerProvider = Provider.of<WorkerProvider>(context, listen: false);
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
          Expanded(child: Consumer<WorkerProvider>(
            builder: (context, workerProvider, child) {
              refreshWorker();
              List<WorkerViewModel> workerViewModelList =
                  workerProvider.listWorkerViewModel;
              return ListView.separated(
                itemBuilder: (context, index) {
                  final WorkerViewModel workerViewModel =
                      workerViewModelList[index];
                  String numWorkerText = workerViewModel.numWorker;
                  String firstNameWorker = workerViewModel.firstNameWorker;
                  String lastNameWorker = workerViewModel.lastNameWorker;
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
                            : const AssetImage("assets/images/usuario.png"),
                      ),
                      title: Text("$firstNameWorker $lastNameWorker"),
                      subtitle: Text(numWorkerText),
                      onTap: () {
                        int numWorker = int.parse(numWorkerText);
                        updateWorkerScreen(numWorker);
                        debugPrint("Item presionado con numero: $numWorker");
                      },
                    ),
                  );
                },
                itemCount: workerViewModelList.length,
                separatorBuilder: (BuildContext context, int index) =>
                    10.verticalSpace,
              );
            },
          )
              //     FutureBuilder(
              //   future: _getListWorker(),
              //   builder: (BuildContext context,
              //       AsyncSnapshot<List<WorkerViewModel>> snapshot) {
              //     if (snapshot.connectionState == ConnectionState.waiting) {
              //       return const Center(
              //         child: CircularProgressIndicator(color: Color(0xffF69100)),
              //       );
              //     } else if (snapshot.hasError) {
              //       return Center(child: Text('Error: ${snapshot.error}'));
              //     } else {
              //       _workerViewModelList = snapshot.data as List<WorkerViewModel>;
              //       return _workerViewModelList.isEmpty
              //           ? Column(
              //               children: [
              //                 Container(
              //                   margin: EdgeInsets.symmetric(horizontal: 10.h),
              //                   child: Text(
              //                       'Presione el "botón +" para agregar un trabajador a la lista',
              //                       style: TextStyle(
              //                           fontSize: 20.sp, color: Colors.black45)),
              //                 ),
              //                 const Center(
              //                   child: CircularProgressIndicator(
              //                       color: Color(0xffF69100)),
              //                 )
              //               ],
              //             )
              //           :
              //     }
              //   },
              // )
              ),
        ],
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
