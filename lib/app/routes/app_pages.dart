import 'package:get/get.dart';

import 'package:wonder_app/app/modules/bank_details/bindings/bank_details_binding.dart';
import 'package:wonder_app/app/modules/bank_details/views/bank_details_view.dart';
import 'package:wonder_app/app/modules/gst_details/bindings/gst_details_binding.dart';
import 'package:wonder_app/app/modules/gst_details/views/gst_details_view.dart';
import 'package:wonder_app/app/modules/home/bindings/home_binding.dart';
import 'package:wonder_app/app/modules/home/views/home_view.dart';
import 'package:wonder_app/app/modules/login/bindings/login_binding.dart';
import 'package:wonder_app/app/modules/login/views/login_view.dart';
import 'package:wonder_app/app/modules/otp_verification/bindings/otp_verification_binding.dart';
import 'package:wonder_app/app/modules/otp_verification/views/otp_verification_view.dart';
import 'package:wonder_app/app/modules/registration_details/bindings/registration_details_binding.dart';
import 'package:wonder_app/app/modules/registration_details/views/registration_details_view.dart';
import 'package:wonder_app/app/modules/seller_regist/bindings/seller_regist_binding.dart';
import 'package:wonder_app/app/modules/seller_regist/views/seller_regist_view.dart';
import 'package:wonder_app/app/modules/success/bindings/success_binding.dart';
import 'package:wonder_app/app/modules/success/views/success_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.OTP_VERIFICATION,
      page: () => OtpVerificationView(),
      binding: OtpVerificationBinding(),
    ),
    GetPage(
      name: _Paths.SELLER_REGIST,
      page: () => SellerRegistView(),
      binding: SellerRegistBinding(),
    ),
    GetPage(
      name: _Paths.GST_DETAILS,
      page: () => GstDetailsView(),
      binding: GstDetailsBinding(),
    ),
    GetPage(
      name: _Paths.REGISTRATION_DETAILS,
      page: () => RegistrationDetailsView(),
      binding: RegistrationDetailsBinding(),
    ),
    GetPage(
      name: _Paths.BANK_DETAILS,
      page: () => BankDetailsView(),
      binding: BankDetailsBinding(),
    ),
    GetPage(
      name: _Paths.SUCCESS,
      page: () => SuccessView(),
      binding: SuccessBinding(),
    ),
  ];
}
