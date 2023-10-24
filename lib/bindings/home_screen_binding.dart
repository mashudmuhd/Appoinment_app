import 'package:get/get.dart';
import '../controller/appoinmet_controller.dart';

class HomeScreenBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AppointmentsController>(() => AppointmentsController());
  }
}
