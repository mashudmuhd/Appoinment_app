import 'package:get/get.dart';

class ValidationController extends GetxController{
  final RxString errorText = RxString('');
 final RxBool isValid =false.obs;



  String? validateInput(String input) {
    // Add your validation logic here
    // Return an error message if the input is not valid, otherwise return null
    if (input.isEmpty) {
      errorText.value = 'This field cannot be empty';
      return 'This field cannot be empty';
    }
    errorText.value = '';
    return null;
  }

}