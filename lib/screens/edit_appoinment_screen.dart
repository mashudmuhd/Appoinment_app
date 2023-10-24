import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:my_appoinment/common_widgets/common_widgets.dart';
import 'package:my_appoinment/controller/appoinmet_controller.dart';
import 'package:my_appoinment/models/appoinment_model.dart';

class EditAppointmentPage extends GetView<AppointmentsController> {
  final Appointment? appointment;
  EditAppointmentPage({ this.appointment, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String ,dynamic> data = Get.arguments;
    var appointmentData = data['appointments'];
    String date = data['date'];
    String time = data['time'];

    controller.nameController.text = appointmentData.name;
    controller.placeController.text = appointmentData.place;
    controller.amountController.text = appointmentData.amount.toString();
    controller.commentsController.text = appointmentData.comments;
    controller.selectedTime.value=appointmentData.time;
    controller.dateAndTime.value=appointmentData.date;


    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.purple,
        title: const Text(
          "Edit Appointment",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
        child: ListView(
          children: [
            buildTextField(controller: controller.nameController, label:appointmentData.name??"",),
            buildTextField(controller: controller.placeController, label: appointmentData.place??"",),
            Row(
              children: [
                Expanded(
                  child: buildTextField(type:TextInputType.number,controller: controller.amountController, label: appointmentData.amount.toString(),),
                ),
                buildTextWidget(text: "Add Comment", color: Colors.purple, fontWeight: FontWeight.bold),
              ],
            ),
            buildTextField(controller: controller.commentsController, label: appointmentData.comments),
            Obx(() => Row(
              children: [
                Expanded(
                  child: buildTextField(
                    enable: false,
                    label: controller.dateAndTime.value.isNotEmpty ? controller.dateAndTime.value : "Schedule Date",

                  ),
                ),
                IconButton(onPressed:() => controller.selectDate(context),icon: const Icon(Icons.date_range_outlined) ,
                )
              ],
            )),
            Obx(() => Row(
              children: [
                Expanded(
                  child: buildTextField(
                    enable: false,
                    label: controller.selectedTime.value.isNotEmpty? controller.selectedTime.value : "Schedule Time",
                  ),
                ),
                IconButton(onPressed:() => controller.selectTime(),icon: const Icon(Icons.access_time_outlined),)
              ],
            )),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.purple),
                ),
                onPressed: () {
                  final editedAppointment = Appointment(
                    id: appointmentData.id,
                    name: controller.nameController.text,
                    place: controller.placeController.text,
                    amount: double.tryParse(controller.amountController.text) ?? 0.0,
                    comments: controller.commentsController.text,
                    date: controller.dateAndTime.value,
                    time: controller.selectedTime.value,
                  );
                  controller.editAppointment(editedAppointment);



                },
                child: buildTextWidget(text: 'Update', color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}