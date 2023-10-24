

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:my_appoinment/common_widgets/common_widgets.dart';
import 'package:my_appoinment/controller/splash_screen_controller.dart';
import 'package:my_appoinment/utils/constants.dart';

class SplashScreen extends GetView<SplashScreenController>{
  @override
  Widget build(BuildContext context) {

    controller.tittle("My Appointment");

    return Scaffold(
      body:Center(
        child: Obx(
              () {
            final Animation<double> animation = CurvedAnimation(
              parent: controller.animationController,
              curve: Curves.easeIn,
            );

            return FadeTransition(
              opacity: animation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(appIcon, width: 200, height: 200),
                  const SizedBox(height: 20,),
                  buildTextWidget(text:controller.myObservable.value,fontSize: 20,color: Colors.purple)
                ],
              ),
            );
          },
        ),
      ),
    );

  }
  
}


