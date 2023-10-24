import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:my_appoinment/routes/app_pages.dart';

class SplashScreenController extends GetxController with GetSingleTickerProviderStateMixin{
  late AnimationController animationController;
  RxString myObservable = "".obs;


  void tittle(title) {
    myObservable.value=title; // Update the observable variable
  }

  @override
  void onInit() {

    animationController =AnimationController(vsync:this,duration: const Duration(seconds: 2));
    animationController.forward();
    Future.delayed(const Duration(seconds: 5), () {
      Get.offAndToNamed(Routes.MY_HOME_PAGE_SCREEN);
    });
    super.onInit();
  }
}