
import 'package:get/get.dart';
import 'package:my_appoinment/bindings/add_appoinment_screen_bindong.dart';
import 'package:my_appoinment/bindings/edit_appoinment_binding.dart';
import 'package:my_appoinment/bindings/home_screen_binding.dart';
import 'package:my_appoinment/bindings/splashScreenBindings.dart';
import 'package:my_appoinment/screens/add_appoinmets.dart';
import 'package:my_appoinment/screens/edit_appoinment_screen.dart';
import 'package:my_appoinment/screens/splash_screen.dart';
import '../screens/home_screen.dart';
part 'app_routes.dart';


class AppPages {
  static const INITIAL = Routes.SPLASH_SCREEN;
  static final routes = [
    GetPage(
      name: _Paths.MY_HOME_PAGE_SCREEN,
      page: () =>  const MyHomePage(),
      binding: HomeScreenBindings(),
    ),
    GetPage(
      name: _Paths.ADD_APPOINMENTS_SCREEN,
      page: () =>   const AddAppointmentPage(),
      binding: AddAppointmentScreenBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_APPOINMENT,
      page: () =>    EditAppointmentPage(),
      binding: EditAppointmentBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () =>    SplashScreen(),
      binding: SplashScreenBindings(),
    ),

  ];
}