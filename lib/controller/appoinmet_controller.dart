import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../models/appoinment_model.dart';
import '../database/database_helper.dart';

class AppointmentsController extends GetxController {
  RxString dateAndTime = ''.obs;
  RxString selectedTime = ''.obs;
  final nameController = TextEditingController();
  final placeController = TextEditingController();
  final amountController = TextEditingController();
  final commentsController = TextEditingController();
  final dbHelper = DatabaseHelper();
  RxList<Appointment> appointments = <Appointment>[].obs;
  final RxBool isLoading = true.obs;
  final RxBool hasError = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAppointments();


  }

  Future<void> fetchAppointments() async {
    isLoading.value = true;
    final loadAppointments = await dbHelper.getAppointments();
    appointments.assignAll(loadAppointments);
    isLoading.value = false;
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      dateAndTime.value = formattedDate;
    }
  }

  void selectTime() async {
    final TimeOfDay? pickedTime = await Get.dialog(TimePickerDialog(
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.dial,
    ));

    if (pickedTime != null) {
      updateTime(pickedTime);
    }
  }

  void updateTime(TimeOfDay pickedTime) {
    final int hour = pickedTime.hourOfPeriod;
    final int minute = pickedTime.minute;
    final String period = pickedTime.period == DayPeriod.am ? 'AM' : 'PM';
    String timeString = '$hour:${minute.toString().padLeft(2, '0')} $period';
    selectedTime.value = timeString;
  }

  void addAppointment() async {
    try {
      final appointment = Appointment(
        name: nameController.text,
        place: placeController.text,
        amount: double.tryParse(amountController.text),
        comments: commentsController.text,
        date: dateAndTime.value,
        time: selectedTime.value,
      );

      final id = await dbHelper.insertAppointment(appointment);

      // Add more detailed logging for debugging
      print("Inserting appointment: $appointment");
      print("Insertion ID: $id");

      if (id != null) {
        appointment.id = id; // Update the appointment object with the generated ID
        appointments.add(appointment);
        clearForm();
        Get.snackbar("Appointment", "New appointment has been added.",colorText: Colors.white,backgroundColor: Colors.green);
        // Navigate back to the previous screen

      } else {
        // Handle the case where id is null (insertion failed)
        throw Exception("Appointment insertion failed");
      }
    } catch (e) {
      // Handle the exception here, display an error message, or log the error.
      print("An error occurred: $e");
      // You can also display an error message to the user if needed.
    }
  }





  Future<void> deleteAppointments(int id) async {
    isLoading.value = true;
    try {
      final deletedRows = await dbHelper.deleteAppointment(id);

      if (deletedRows > 0) {
        appointments.removeWhere((appointment) => appointment.id == id);
        Get.snackbar("Appointment", "Appointment has been deleted.",backgroundColor: Colors.green,colorText: Colors.white);
      } else {
        Get.snackbar("Error", "No appointment found with ID: $id");
      }
    } finally {
      isLoading.value = false;
    }
  }

  void editAppointment(Appointment editedAppointment) async {
    try {
      final result = await dbHelper.updateAppointment(editedAppointment);

      if (result > 0) {
        final index = appointments.indexWhere((element) => element.id == editedAppointment.id);
        if (index != -1) {
          appointments[index] = editedAppointment;
        }
        Get.back();
        Get.snackbar("Appointment Updated", "The appointment has been updated.",backgroundColor: Colors.green,colorText: Colors.white);
      } else {
        Get.snackbar("Update Failed", "The appointment update failed.",backgroundColor: Colors.redAccent,colorText: Colors.white);
      }
    } catch (e) {
      print('Error updating appointment: $e');
      Get.snackbar("Update Error", "An error occurred while updating the appointment.",backgroundColor: Colors.redAccent,colorText: Colors.white);
    }
  }




  Future<void> loadAppointmentForEdit(int appointmentId) async {
    final existingAppointment = appointments.firstWhere((element) => element.id == appointmentId);
    nameController.text = existingAppointment.name;
    placeController.text = existingAppointment.place;
    amountController.text = existingAppointment.amount.toString();
    commentsController.text = existingAppointment.comments;
    dateAndTime.value = existingAppointment.date;
    selectedTime.value = existingAppointment.time;
  }

  void clearForm() {
    nameController.clear();
    placeController.clear();
    amountController.clear();
    commentsController.clear();
    dateAndTime.value = '';
    selectedTime.value = '';
  }

  void validateTextField() {
    if (nameController.text.isEmpty ||
        placeController.text.isEmpty ||
        amountController.text.isEmpty ||
        dateAndTime.value.isEmpty ||
        selectedTime.value.isEmpty) {
      hasError.value = true;
    } else {
      hasError.value = false;
    }
  }
}
