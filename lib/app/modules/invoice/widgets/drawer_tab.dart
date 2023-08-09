import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/urls.dart';
import '../../add_invoice/controllers/add_invoice_controller.dart';
import '../../connections/views/connections_view.dart';
import '../../login/views/login_view.dart';
import '../../my_shops/views/my_shops_view.dart';
import '../../profile_view/views/profile_view_view.dart';
import '../../support_request/views/support_request_view.dart';
import '../../terms_conditions/views/terms_conditions_view.dart';
import '../../vendors_added/views/vendors_added_view.dart';
import '../../wonder_list/views/wonder_list_view.dart';
import '../views/invoice_view.dart';

class DrawerTab extends StatelessWidget {
  const DrawerTab({
    super.key,
    required this.addInvoiceController,
  });

  final AddInvoiceController addInvoiceController;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromARGB(
        255,
        239,
        240,
        246,
      ),
      child: ListView(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.close))
          ],
        ),
        Column(
          children: [
            Container(
              height: 124,
              width: 30.w,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(25)),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Obx(() {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: (invoiceController.userDetailLists.isEmpty ||
                            invoiceController.userDetailLists.first.image == '')
                        ? Image.asset("assets/images/User.png")
                        : Image.network(
                            "$baseUrlForImage${invoiceController.userDetailLists.first.image}",
                            fit: BoxFit.fitWidth,
                          ),
                  );
                }),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: Obx(() {
                return Text(
                    invoiceController.userDetailLists.isEmpty
                        ? ""
                        : invoiceController.userDetailLists.first.email,
                    style: GoogleFonts.roboto(
                        color: Color.fromARGB(255, 63, 69, 189),
                        fontSize: 18,
                        fontWeight: FontWeight.w600));
              }),
            ),
            SizedBox(
              height: 10,
            ),
            // Text("Kakkanad",
            //     style: GoogleFonts.roboto(
            //         color: Color.fromARGB(255, 0, 0, 0),
            //         fontSize: 18,
            //         fontWeight: FontWeight.w300)),
          ],
        ),
        SizedBox(
          height: 5.h,
        ),
        Column(
          children: [
            ListTile(
              onTap: () {
                Get.back();
                Get.to(ProfileViewView());
              },
              leading: SvgPicture.asset(
                "assets/images/drawer/User.svg",
                fit: BoxFit.contain,
              ),
              title: Text(
                "View Profile",
                style: GoogleFonts.roboto(
                    color: Color.fromARGB(177, 0, 0, 0),
                    fontSize: 17,
                    fontWeight: FontWeight.normal),
              ),
              trailing: IconButton(
                  onPressed: () {
                    Get.back();
                    Get.to(ProfileViewView());
                  },
                  icon: Icon(Icons.arrow_forward_ios_outlined)),
            ),
            Padding(
              padding: EdgeInsets.only(top: 6.0),
              child: Divider(color: Colors.white, thickness: 2),
            ),
            ListTile(
              onTap: () {
                Get.to(MyShopsView());
                // Get.to(BankDetailsView());
              },
              leading: SvgPicture.asset(
                "assets/images/drawer/Storefront.svg",
                fit: BoxFit.contain,
              ),
              title: Text(
                "My Shops",
                style: GoogleFonts.roboto(
                    color: Color.fromARGB(177, 0, 0, 0),
                    fontSize: 17,
                    fontWeight: FontWeight.normal),
              ),
              trailing: IconButton(
                  onPressed: () {
                    Get.to(MyShopsView());
                    // Get.to(BankDetailsView());
                  },
                  icon: Icon(Icons.arrow_forward_ios_outlined)),
            ),
            Padding(
              padding: EdgeInsets.only(top: 6.0),
              child: Divider(color: Colors.white, thickness: 2),
            ),
            ListTile(
              onTap: () {
                Get.to(WonderListView());
              },
              leading: SvgPicture.asset(
                "assets/images/Basket.svg",
                fit: BoxFit.contain,
              ),
              title: Text(
                "My Products",
                style: GoogleFonts.roboto(
                    color: Color.fromARGB(177, 0, 0, 0),
                    fontSize: 17,
                    fontWeight: FontWeight.normal),
              ),
              trailing: IconButton(
                  onPressed: () {
                    Get.to(WonderListView());
                  },
                  icon: Icon(Icons.arrow_forward_ios_outlined)),
            ),
            // Padding(
            //   padding: EdgeInsets.only(top: 6.0),
            //   child: Divider(color: Colors.white, thickness: 2),
            // ),
            // ListTile(
            //   onTap: () {
            //     Get.to(MyEarningsView());
            //   },
            //   leading: SvgPicture.asset(
            //     "assets/images/drawer/Coin (1).svg",
            //     fit: BoxFit.contain,
            //   ),
            //   title: Text(
            //     "My Commissions",
            //     style: GoogleFonts.roboto(
            //         color: Color.fromARGB(177, 0, 0, 0),
            //         fontSize: 17,
            //         fontWeight: FontWeight.normal),
            //   ),
            //   trailing: IconButton(
            //       onPressed: () {
            //         Get.to(MyEarningsView());
            //       },
            //       icon: Icon(Icons.arrow_forward_ios_outlined)),
            // ),
            Padding(
              padding: EdgeInsets.only(top: 6.0),
              child: Divider(color: Colors.white, thickness: 2),
            ),
            ListTile(
              onTap: () {
                Get.to(VendorsAddedView());
              },
              leading: SvgPicture.asset(
                "assets/images/vendorList.svg",
                fit: BoxFit.contain,
              ),
              title: Text(
                "Vendors List",
                style: GoogleFonts.roboto(
                    color: Color.fromARGB(177, 0, 0, 0),
                    fontSize: 17,
                    fontWeight: FontWeight.normal),
              ),
              trailing: IconButton(
                  onPressed: () {
                    Get.to(VendorsAddedView());
                  },
                  icon: Icon(Icons.arrow_forward_ios_outlined)),
            ),
            Padding(
              padding: EdgeInsets.only(top: 6.0),
              child: Divider(color: Colors.white, thickness: 2),
            ),
            ListTile(
              onTap: () {
                Get.to(ConnectionsView());
              },
              leading: SvgPicture.asset(
                "assets/images/drawer/AddressBook.svg",
                fit: BoxFit.contain,
              ),
              title: Text(
                "Connections",
                style: GoogleFonts.roboto(
                    color: Color.fromARGB(177, 0, 0, 0),
                    fontSize: 17,
                    fontWeight: FontWeight.normal),
              ),
              trailing: IconButton(
                  onPressed: () {
                    Get.to(ConnectionsView());
                  },
                  icon: Icon(Icons.arrow_forward_ios_outlined)),
            ),
            Padding(
              padding: EdgeInsets.only(top: 6.0),
              child: Divider(color: Colors.white, thickness: 2),
            ),
            InkWell(
              onTap: () {
                Get.to(SupportRequestView());
              },
              child: ListTile(
                leading: SvgPicture.asset(
                  "assets/images/support_req.svg",
                  fit: BoxFit.contain,
                ),
                title: Text(
                  "Support Requests",
                  style: GoogleFonts.roboto(
                      color: Color.fromARGB(177, 0, 0, 0),
                      fontSize: 17,
                      fontWeight: FontWeight.normal),
                ),
                trailing: IconButton(
                    onPressed: () {
                      Get.to(SupportRequestView());
                    },
                    icon: Icon(Icons.arrow_forward_ios_outlined)),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 6.0),
              child: Divider(color: Colors.white, thickness: 2),
            ),
            ListTile(
              onTap: () {
                Get.to(TermsConditionsView());
              },
              leading: SvgPicture.asset(
                "assets/images/drawer/ClipboardText.svg",
                fit: BoxFit.contain,
              ),
              title: Text(
                "Terms & Conditions",
                style: GoogleFonts.roboto(
                    color: Color.fromARGB(177, 0, 0, 0),
                    fontSize: 17,
                    fontWeight: FontWeight.normal),
              ),
              trailing: IconButton(
                  onPressed: () {
                    Get.to(TermsConditionsView());
                  },
                  icon: Icon(Icons.arrow_forward_ios_outlined)),
            ),
            Padding(
              padding: EdgeInsets.only(top: 6.0),
              child: Divider(color: Colors.white, thickness: 2),
            ),
            InkWell(
              onTap: () async {
                if (!await launchUrl(
                  Uri.parse("https://wonderpoints.com/contact-us/"),
                  mode: LaunchMode.externalApplication,
                )) {
                  throw Exception("https://wonderpoints.com/contact-us/");
                }
              },
              child: ListTile(
                leading: SvgPicture.asset(
                  "assets/images/drawer/ChatDots.svg",
                  fit: BoxFit.contain,
                ),
                title: Text(
                  "Contact us",
                  style: GoogleFonts.roboto(
                      color: Color.fromARGB(177, 0, 0, 0),
                      fontSize: 17,
                      fontWeight: FontWeight.normal),
                ),
                trailing: IconButton(
                    onPressed: () async {
                      if (!await launchUrl(
                        Uri.parse("https://wonderpoints.com/contact-us/"),
                        mode: LaunchMode.externalApplication,
                      )) {
                        throw Exception("https://wonderpoints.com/contact-us/");
                      }
                    },
                    icon: Icon(Icons.arrow_forward_ios_outlined)),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 6.0),
              child: Divider(color: Colors.white, thickness: 2),
            ),
            InkWell(
              onTap: () async {
                if (!await launchUrl(
                  Uri.parse("https://wonderpoints.com/privacy-policy/"),
                  mode: LaunchMode.externalApplication,
                )) {
                  throw Exception("https://wonderpoints.com/privacy-policy/");
                }
              },
              child: ListTile(
                leading: SvgPicture.asset(
                  "assets/images/drawer/LockKey.svg",
                  fit: BoxFit.contain,
                ),
                title: Text(
                  "Privacy policy",
                  style: GoogleFonts.roboto(
                      color: Color.fromARGB(177, 0, 0, 0),
                      fontSize: 17,
                      fontWeight: FontWeight.normal),
                ),
                trailing: IconButton(
                    onPressed: () async {
                      if (!await launchUrl(
                        Uri.parse("https://wonderpoints.com/privacy-policy/"),
                        mode: LaunchMode.externalApplication,
                      )) {
                        throw Exception(
                            "https://wonderpoints.com/privacy-policy/");
                      }
                    },
                    icon: Icon(Icons.arrow_forward_ios_outlined)),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 6.0),
              child: Divider(color: Colors.white, thickness: 2),
            ),
            ListTile(
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.clear();
                invoiceController.invoiceLists.value.clear();
                invoiceController.walletTransactionLists.clear();
                addInvoiceController.shopLists.value.clear();
                invoiceController.selectShopId = null;
                await DefaultCacheManager().emptyCache();

                Get.offAll(LoginView());
              },
              leading: SvgPicture.asset(
                "assets/images/drawer/SignOut.svg",
                fit: BoxFit.contain,
              ),
              title: Text(
                "Logout",
                style: GoogleFonts.roboto(
                    color: Color.fromARGB(177, 0, 0, 0),
                    fontSize: 17,
                    fontWeight: FontWeight.normal),
              ),
              trailing: IconButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.clear();
                    Get.offAll(LoginView());
                  },
                  icon: Icon(Icons.arrow_forward_ios_outlined)),
            ),
            SizedBox(
              height: 30,
            )
          ],
        )
      ]),
    );
  }
}
