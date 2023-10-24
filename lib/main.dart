import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_appoinment/controller/splash_screen_controller.dart';
import 'package:my_appoinment/routes/app_pages.dart';
import 'database/database_helper.dart';
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper().database;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(SplashScreenController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mami Appointment',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        useMaterial3: true,
      ),
      initialRoute: AppPages.INITIAL,
      getPages:AppPages.routes,
    );
  }
}