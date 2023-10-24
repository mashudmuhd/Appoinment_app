import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:my_appoinment/controller/validation_controller.dart';
import 'package:my_appoinment/utils/constants.dart';

Widget buildTextWidget({
  required String text,
  double? fontSize ,
  Color? color,
  FontWeight? fontWeight,
  FontStyle? fontStyle,

}) {
  return Text(
    text , // Use an empty string as the default text
    style: TextStyle(
      fontSize: fontSize ?? 16.0, // Default font size is 16.0
      color: color ?? Colors.black,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
        fontFamily: slaboText
    ),
  );
}

Widget buildTextField({

  TextEditingController? controller,
  required String label,
   suffixIcon,
  TextInputType? type,
  bool? enable
  })
{
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextField(
      keyboardType: type,
        enabled: enable,
        controller: controller,
        decoration: InputDecoration(
        suffixIcon: suffixIcon,
        labelText: label ?? '',
        labelStyle: const TextStyle(color: Colors.purple), // Change label text color
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.purple), // Change border color when focused
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey), // Change border color when not focused
        ),
        hintText: 'Enter text here', // Add a hint text
        hintStyle: const TextStyle(color: Colors.grey), // Change hint text color
      ),
    ),
  );
}

SnackbarController getSnackBar(String snackBarText){
  return Get.snackbar("Error", snackBarText,backgroundColor: Colors.red,colorText: Colors.white);
}


