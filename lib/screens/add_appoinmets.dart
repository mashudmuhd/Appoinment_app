    import 'package:flutter/cupertino.dart';
    import 'package:flutter/material.dart';
    import 'package:flutter/src/widgets/framework.dart';
    import 'package:get/get.dart';
    import 'package:my_appoinment/common_widgets/common_widgets.dart';
    import 'package:my_appoinment/controller/appoinmet_controller.dart';

    class AddAppointmentPage extends GetView<AppointmentsController> {
      const AddAppointmentPage({Key? key}) : super(key: key);

      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: Colors.purple,
            title: const Text(
              "Add Appointment",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
            child: ListView(
              children: [
                buildTextField(controller: controller.nameController, label: "Enter Name",),
                buildTextField(controller: controller.placeController, label: "Enter Place",),
                buildTextField(controller: controller.amountController, label: "Amount",type: TextInputType.number),
                buildTextField(controller: controller.commentsController, label: "Comments"),
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
                  child:ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.purple),
                    ),
                    onPressed: () {
                      try {
                        if (controller.nameController.text.isEmpty) {
                          getSnackBar("Name is Required");
                        } else if (controller.placeController.text.isEmpty) {
                          getSnackBar("Place is Required");
                        } else if (controller.dateAndTime.value.isEmpty) {
                          getSnackBar("Date is Required");
                        } else if (controller.selectedTime.value.isEmpty) {
                          getSnackBar("Time is Required");
                        } else {
                          controller.addAppointment();
                          Get.back();
                        }
                      } catch (e) {
                        // Handle the exception here, display an error message, or log the error.
                        print("An error occurred: $e");
                        // You can also display an error message to the user if needed.
                      }
                    },
                    child: buildTextWidget(text: 'SAVE', color: Colors.white),
                  ),

                ),
              ],
            ),
          ),
        );
      }
    }