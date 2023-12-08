import 'package:control_asistencia_app/app/packages/packagelocal_provider.dart';
import 'package:control_asistencia_app/app/packages/packages_pub.dart';
import 'package:control_asistencia_app/app/packages/packageslocal_view.dart';

class SearchFieldWidget extends StatefulWidget {
  final WorkerProvider workerProvider;
  final String isWorking;
  final void Function(int) action;
  const SearchFieldWidget(
      {required this.isWorking,
      required this.workerProvider,
      required this.action,
      super.key});

  @override
  State<SearchFieldWidget> createState() => _SearchFieldWidgetState();
}

class _SearchFieldWidgetState extends State<SearchFieldWidget> {
  final FocusNode _focusNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<SearchFieldListItem<WorkerViewModel>> _searchDataWorker = [];
  List<WorkerViewModel> listWorkerVModel = [];
  final TextEditingController _conNumWorker = TextEditingController();

  @override
  void initState() {
    super.initState();
    getDataWorkerSearch(widget.workerProvider, widget.isWorking);
  }

  @override
  void dispose() {
    super.dispose();
    _searchDataWorker.clear();
    listWorkerVModel.clear();
  }

  void getVMWorkerProvider(
      WorkerProvider workerProvider, String isWorking) async {
    await workerProvider.getDataWorkerVModel(isWorking);
  }

  void getDataWorkerSearch(WorkerProvider workerProvider, String isWorking) {
    getVMWorkerProvider(workerProvider, isWorking);
    if (isWorking == "alta") {
      listWorkerVModel = workerProvider.listWorkerViewModelHigh;
    } else {
      listWorkerVModel = workerProvider.listWorkerViewModelLow;
    }
    _searchDataWorker = listWorkerVModel.map((worker) {
      return SearchFieldListItem<WorkerViewModel>(
        worker.numWorker,
        item: worker,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10.w),
          child: Text("${worker.firstNameWorker} ${worker.lastNameWorker}"),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Form(
        key: _formKey,
        child: SearchField<WorkerViewModel>(
          controller: _conNumWorker,
          hint: "Numero de personal",
          suggestions: _searchDataWorker,
          onTapOutside: (p0) {
            _focusNode.unfocus();
          },
          focusNode: _focusNode,
          onSuggestionTap: (SearchFieldListItem<WorkerViewModel> workerSearch) {
            if (mounted) {
              setState(() {
                _conNumWorker.text = workerSearch.searchKey;
              });
            }
          },
          validator: (searchWorker) {
            List<String> searchItem =
                _searchDataWorker.map((e) => e.searchKey).toList();
            if (!searchItem.contains(searchWorker) || searchWorker == null) {
              return "Ingrese un nombre valido";
            }
            return null;
          },
          onSearchTextChanged: (query) {
            final filter = listWorkerVModel
                .where((element) => element.numWorker.contains(query))
                .toList();
            // setState(() {});
            return filter
                .map(
                  (e) => SearchFieldListItem(
                    e.numWorker,
                    item: e,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Text("${e.firstNameWorker} ${e.lastNameWorker}"),
                    ),
                  ),
                )
                .toList();
          },
          onSubmit: (p0) {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              debugPrint("Valor: $p0");
              int numWorker = int.parse(p0);
              widget.action(numWorker);
              debugPrint("Item presionado con numero: $numWorker");
            }
          },
        ),
      ),
    );
  }
}
