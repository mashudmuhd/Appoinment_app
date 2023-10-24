import 'package:get/get.dart';
import 'package:my_appoinment/controller/appoinmet_controller.dart';

class AddAppointmentScreenBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AppointmentsController>(() => AppointmentsController());
  }

}