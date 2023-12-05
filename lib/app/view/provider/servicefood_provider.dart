import 'package:control_asistencia_app/app/controller/servicesfood_controller/servicefood_controller.dart';
import 'package:control_asistencia_app/app/model/lunch/foodservices_model.dart';
import 'package:control_asistencia_app/app/packages/packages_pub.dart';

class ServiceFoodProvider extends ChangeNotifier {
  final ServicesFoodController _serviceFoodControllder =
      ServicesFoodController();
  Future<String> addBreakFastProvider(
      FoodServicesModel foodServiceModel, int numWorker) async {
    String response = await _serviceFoodControllder.addServiceFoodController(
        foodServiceModel, numWorker);
    notifyListeners();
    return response;
  }

  Future<void> getListFoodServices() async {
    await _serviceFoodControllder.getListFoodService();
  }
}
