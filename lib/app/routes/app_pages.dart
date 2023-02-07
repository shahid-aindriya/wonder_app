import 'package:get/get.dart';

import '../modules/add_invoice/bindings/add_invoice_binding.dart';
import '../modules/add_invoice/views/add_invoice_view.dart';
import '../modules/bank_details/bindings/bank_details_binding.dart';
import '../modules/bank_details/views/bank_details_view.dart';
import '../modules/gst_details/bindings/gst_details_binding.dart';
import '../modules/gst_details/views/gst_details_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/invoice/bindings/invoice_binding.dart';
import '../modules/invoice/views/invoice_view.dart';
import '../modules/invoice_details/bindings/invoice_details_binding.dart';
import '../modules/invoice_details/views/invoice_details_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/map_place_picker/bindings/map_place_picker_binding.dart';
import '../modules/map_place_picker/views/map_place_picker_view.dart';
import '../modules/my_shops/bindings/my_shops_binding.dart';
import '../modules/my_shops/views/my_shops_view.dart';
import '../modules/notifications/bindings/notifications_binding.dart';
import '../modules/notifications/views/notifications_view.dart';
import '../modules/otp_verification/bindings/otp_verification_binding.dart';
import '../modules/otp_verification/views/otp_verification_view.dart';
import '../modules/password_generation/bindings/password_generation_binding.dart';
import '../modules/password_generation/views/password_generation_view.dart';
import '../modules/profile_view/bindings/profile_view_binding.dart';
import '../modules/profile_view/views/profile_view_view.dart';
import '../modules/registration_details/bindings/registration_details_binding.dart';
import '../modules/registration_details/views/registration_details_view.dart';
import '../modules/request_pending/bindings/request_pending_binding.dart';
import '../modules/request_pending/views/request_pending_view.dart';
import '../modules/seller_regist/bindings/seller_regist_binding.dart';
import '../modules/seller_regist/views/seller_regist_view.dart';
import '../modules/shop_details/bindings/shop_details_binding.dart';
import '../modules/shop_details/views/shop_details_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';
import '../modules/store_details/bindings/store_details_binding.dart';
import '../modules/store_details/views/store_details_view.dart';
import '../modules/success/bindings/success_binding.dart';
import '../modules/success/views/success_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

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
    GetPage(
      name: _Paths.INVOICE,
      page: () => InvoiceView(),
      binding: InvoiceBinding(),
    ),
    GetPage(
      name: _Paths.INVOICE_DETAILS,
      page: () => InvoiceDetailsView(),
      binding: InvoiceDetailsBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATIONS,
      page: () => NotificationsView(),
      binding: NotificationsBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_VIEW,
      page: () => ProfileViewView(),
      binding: ProfileViewBinding(),
    ),
    GetPage(
      name: _Paths.REQUEST_PENDING,
      page: () => RequestPendingView(),
      binding: RequestPendingBinding(),
    ),
    GetPage(
      name: _Paths.STORE_DETAILS,
      page: () => StoreDetailsView(),
      binding: StoreDetailsBinding(),
    ),
    GetPage(
      name: _Paths.PASSWORD_GENERATION,
      page: () => PasswordGenerationView(),
      binding: PasswordGenerationBinding(),
    ),
    GetPage(
      name: _Paths.ADD_INVOICE,
      page: () => AddInvoiceView(),
      binding: AddInvoiceBinding(),
    ),
    GetPage(
      name: _Paths.MY_SHOPS,
      page: () => MyShopsView(),
      binding: MyShopsBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.SHOP_DETAILS,
      page: () => ShopDetailsView(),
      binding: ShopDetailsBinding(),
    ),
    GetPage(
      name: _Paths.MAP_PLACE_PICKER,
      page: () => MapPlacePickerView(),
      binding: MapPlacePickerBinding(),
    ),
  ];
}
