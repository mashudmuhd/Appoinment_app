part of 'app_pages.dart';

abstract class Routes {
  static const SPLASH_SCREEN = _Paths.SPLASH_SCREEN;
  static const MY_HOME_PAGE_SCREEN = _Paths.MY_HOME_PAGE_SCREEN;
  static const ADD_APPOINMENTS_SCREEN = _Paths.ADD_APPOINMENTS_SCREEN;
  static const EDIT_APPOINMENT = _Paths.EDIT_APPOINMENT;
}

abstract class _Paths {
  static const MY_HOME_PAGE_SCREEN = '/my_home_page_screen';
  static const ADD_APPOINMENTS_SCREEN = '/add_appointments_screen';
  static const EDIT_APPOINMENT = '/edit_appointment';
  static const SPLASH_SCREEN = '/splash_screen';
}

