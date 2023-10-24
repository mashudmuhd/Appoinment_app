import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class Controller extends GetxController {
  var name = ''.obs;
  var place = ''.obs;
  var pendingAmount = ''.obs;
  var dateTime = ''.obs;

  void getData() {
    print('Name: $name');
    print('Place: $place');
    print('Pending Amount: $pendingAmount');
    print('Date & Time: $dateTime');
  }
}