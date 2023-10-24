import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:my_appoinment/common_widgets/common_widgets.dart';
import 'package:my_appoinment/controller/appoinmet_controller.dart';
import 'package:my_appoinment/models/appoinment_model.dart';
import 'package:my_appoinment/routes/app_pages.dart';

class MyHomePage extends GetView<AppointmentsController> {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: buildTextWidget(
            text: 'Appointments',
            color: Colors.white,
            fontWeight: FontWeight.bold),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
              child: CircularProgressIndicator()); // Show loading indicator
        } else if (controller.appointments.isNotEmpty) {
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: controller.appointments.length,
            itemBuilder: (BuildContext context, int index) {
              Appointment data = controller.appointments[index];
              print("id here${data.id}");
              return getEventCard(data);
            },
          );
        } else {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search_outlined, size: 90, color: Colors.purple),
                Text("Welcome Mami 👋 \n Here you can Add appointments 😊",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold,)),
              ],
            ),
          );
        }
      }),
      floatingActionButton: getAddAppointmentButton(),
    );
  }

  Widget getAddAppointmentButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          controller.clearForm();
          Get.toNamed(Routes.ADD_APPOINMENTS_SCREEN);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              colors: [Colors.purple, Colors.deepPurple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: buildTextWidget(
              text: "ADD APPOINTMENT",
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        )

      ),
    );
  }

  Widget getEventCard(Appointment appointment) {
    return Card(
      color: Colors.white,
      elevation: 10, // Increased elevation for a more pronounced shadow
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Custom border radius
      ),
      margin: const EdgeInsets.all(10),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16), // Padding inside the ListTile
        title: buildTextWidget(
          text: appointment.name,
          fontWeight: FontWeight.bold,
          color: Colors.purple,
          fontSize: 20,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildTextWidget(
              text: 'Place: ${appointment.place}',
              fontSize: 15,
            ),
            buildTextWidget(
              text: 'Date: ${appointment.date}',
              fontSize: 15,
            ),
            buildTextWidget(
              text: 'Time: ${appointment.time}',
              fontSize: 15,
            ),
            buildTextWidget(
              text: appointment.comments??'',
              fontSize: 15,
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () {
                Get.toNamed(
                  Routes.EDIT_APPOINMENT,
                  arguments: {
                    "appointments": appointment,
                    "date": appointment.date,
                    "time": appointment.time,
                  },
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                showDeleteConfirmationDialog(appointment);
              },
            ),
          ],
        ),
      ),
    )
    ;
  }

  void showDeleteConfirmationDialog(Appointment? appointment) {
    if (appointment != null) {
      Get.defaultDialog(
        title: "Delete Appointment",
        titleStyle: const TextStyle(fontSize: 20),
        content: buildTextWidget(text: "Are you sure you want to delete this appointment?"),
        confirm: ElevatedButton(
          onPressed: () {
            controller.deleteAppointments(appointment.id!);
            Get.back();
          },
          child: buildTextWidget(text: "Delete"),
        ),
        cancel: ElevatedButton(
          onPressed: () {
            Get.back(); // Close the confirmation dialog
          },
          child: buildTextWidget(text: "Cancel"),
        ),
      );
    }
  }

}
