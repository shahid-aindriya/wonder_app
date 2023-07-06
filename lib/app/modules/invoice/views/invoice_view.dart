import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:upgrader/upgrader.dart';
import 'package:wonder_app/app/data/colors.dart';
import 'package:wonder_app/app/modules/add_invoice/views/add_invoice_view.dart';
import 'package:wonder_app/app/modules/invoice/widgets/search_invoice.dart';
import 'package:wonder_app/app/modules/invoice/widgets/verified_invoices.dart';

import '../../add_invoice/controllers/add_invoice_controller.dart';
import '../../notifications/views/notifications_view.dart';
import '../controllers/invoice_controller.dart';
import '../widgets/drawer_tab.dart';
import '../widgets/due.dart';
import '../widgets/invoices_tab.dart';
import '../widgets/notification_icon.dart';
import '../widgets/wallet_tab.dart';

final InvoiceController invoiceController = Get.put(InvoiceController());

class InvoiceView extends GetView<InvoiceController> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final AddInvoiceController addInvoiceController =
      Get.put(AddInvoiceController());

  @override
  Widget build(BuildContext context) {
    invoiceController.notifications();
    // addInvoiceController.getListOfShops();
    // invoiceController.getUserData();
    invoiceController.pushFCMtoken();
    // invoiceController.onPullRefreshInWallet();
    invoiceController.checkActiveUser();
    return DefaultTabController(
      length: 3,
      child: UpgradeAlert(
        upgrader: Upgrader(dialogStyle: UpgradeDialogStyle.material),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment(2, 1.0548897981643677),
                end: Alignment(-1.0548897981643677, 1.226324439048767),
                colors: [
                  Color.fromRGBO(239, 221, 214, 1),
                  Color.fromRGBO(220, 222, 242, 1),
                  Color.fromRGBO(250, 227, 243, 1),
                  Color.fromRGBO(228, 249, 254, 1)
                ]),
          ),
          child: Scaffold(
            drawer: DrawerTab(addInvoiceController: addInvoiceController),
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              leading: Builder(builder: (contezxt) {
                return InkWell(
                  onTap: () async {
                    await invoiceController.getUserData();
                    Scaffold.of(contezxt).openDrawer();
                  },
                  child: Container(
                    decoration: BoxDecoration(),
                    child: Center(
                      child: Icon(
                        Icons.menu,
                        color: textGradientBlue,
                      ),
                    ),
                  ),
                );
              }),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: FutureBuilder(
                      future: addInvoiceController.getListOfShops(),
                      builder: (contextsd, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container(
                            width: 60.w,
                            height: 50,
                            child: Shimmer(
                              color: Color.fromARGB(255, 185, 84, 84),
                              child: ListTile(
                                dense: true,
                                leading: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor:
                                          Color.fromARGB(255, 220, 216, 216),
                                      radius: 20,
                                    ),
                                  ],
                                ),
                                title: Container(
                                  height: 20,
                                  color: Color.fromARGB(255, 220, 216, 216),
                                ),
                                subtitle: Container(
                                  height: 16,
                                  margin: EdgeInsets.only(top: 8),
                                  color: Color.fromARGB(255, 220, 216, 216),
                                ),
                              ),
                              direction: ShimmerDirection.fromRTLB(),
                            ),
                          );
                        }
                        return Obx(() {
                          return Container(
                              width: 60.w,
                              child: DropdownButtonFormField(
                                isExpanded: true,
                                isDense: true,
                                style: GoogleFonts.roboto(
                                    fontSize: 18,
                                    color: Color.fromRGBO(0, 0, 0, 1)),
                                decoration: InputDecoration(
                                    hintStyle: GoogleFonts.roboto(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w300,
                                      height: 1.1725,
                                      color: Color.fromARGB(93, 0, 0, 0),
                                    ),
                                    hintText: "Select Shop",
                                    enabled: true,
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: BorderSide(
                                            width: 0,
                                            color: Color.fromARGB(
                                                255, 199, 199, 179))),
                                    filled: true,
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 0,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255)),
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    fillColor:
                                        Color.fromARGB(153, 255, 255, 255),
                                    focusColor:
                                        Color.fromARGB(255, 231, 231, 231)),
                                value: invoiceController.selectShopId,
                                onChanged: (value) async {
                                  invoiceController.invoiceListsFilter.value
                                      .clear();
                                  invoiceController.walletTransactionLists
                                      .clear();
                                  invoiceController.invoiceLists.value.clear();
                                  invoiceController.walletCurrentpage.value = 1;
                                  invoiceController.invoiceCurrentpage.value =
                                      1;
                                  invoiceController.shopWalletAmount.value =
                                      "0";
                                  invoiceController.dueList.clear();
                                  invoiceController.walletAmount.value = '';
                                  invoiceController.filterPage.value = 1;
                                  invoiceController.dueTotalCount.value = 1;
                                  invoiceController.dueCurrentCount.value = 1;
                                  invoiceController.debitListValue.value =
                                      "All";
                                  invoiceController.changeShop(
                                    value: value,
                                  );
                                  await invoiceController.checkVerifiedVendor();
                                  await invoiceController
                                      .onDropDownChanged(value);
                                  await invoiceController
                                      .ondropDownChangedInvoice(value);
                                  await invoiceController.getDueData();
                                },
                                items: addInvoiceController.shopLists.value
                                    .map((data) {
                                  return DropdownMenuItem(
                                      value: data.id.toString(),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 5.0),
                                        child: Text(
                                          data.name,
                                          overflow: TextOverflow.visible,
                                        ),
                                      ));
                                }).toList(),
                              ));
                        });
                      }),
                ),
                Container(
                  decoration: BoxDecoration(),
                  child: InkWell(
                    onTap: () {
                      Get.to(NotificationsView(
                        invoiceController: invoiceController,
                      ));
                    },
                    child: Center(
                      child: BellWidget(),
                    ),
                  ),
                )
              ],
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            body: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 57,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 0.2),
                        blurRadius: 10,
                      ),
                    ],
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color.fromARGB(255, 243, 229, 223),
                        Color.fromARGB(255, 229, 230, 244)
                      ],
                      tileMode: TileMode.clamp,
                    ),
                  ),
                  child: TabBar(
                    unselectedLabelColor: Color.fromARGB(255, 151, 151, 155),
                    labelStyle: GoogleFonts.roboto(
                        color: textGradientBlue,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                    labelColor: textGradientBlue,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Color.fromARGB(255, 247, 240, 240),
                      gradient: LinearGradient(
                          begin: Alignment(
                              1.0411021709442139, 0.002192780375480652),
                          end: Alignment(
                              -0.002192780375480652, 0.01846526376903057),
                          colors: [
                            Color.fromARGB(255, 247, 240, 240),
                            Color.fromARGB(255, 247, 240, 240)
                          ]),
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: [
                      Tab(
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Wrap(
                                children: [
                                  ImageIcon(AssetImage(
                                      "assets/images/invoice-icon.png")),
                                  Text(
                                    "Invoices",
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Tab(
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Wrap(
                                children: [
                                  ImageIcon(
                                      AssetImage("assets/images/Wallet.png")),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 2.0, left: 2),
                                    child: Text(
                                      "Wallet",
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Tab(
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Wrap(
                                children: [
                                  ImageIcon(
                                      AssetImage("assets/images/due.png")),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 2.0, left: 2),
                                    child: Text(
                                      "Due",
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.to(SearchInvoice(
                                        invoiceController: invoiceController));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(117, 255, 255, 255),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                          "assets/images/search.png"),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Obx(() {
                                  return Expanded(
                                    child: Container(
                                      child: DropdownButtonFormField(
                                        isDense: true,
                                        isExpanded: true,
                                        decoration: InputDecoration(
                                            hintStyle: GoogleFonts.roboto(
                                                fontWeight: FontWeight.w300,
                                                fontSize: 18,
                                                color: Color.fromRGBO(
                                                    0, 0, 0, .6)),
                                            hintText: "Select",
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 0.0,
                                                    horizontal: 10),
                                            enabled: true,
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                borderSide: BorderSide(
                                                    width: 0,
                                                    color: Color.fromARGB(
                                                        255, 199, 199, 179))),
                                            filled: true,
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 0,
                                                    color:
                                                        Color.fromARGB(255, 255, 255, 255)),
                                                borderRadius: BorderRadius.circular(16)),
                                            fillColor: Color.fromARGB(92, 255, 255, 255),
                                            focusColor: Color.fromARGB(255, 231, 231, 231)),
                                        value: invoiceController
                                            .filterListValue.value,
                                        onChanged: (value) {
                                          invoiceController.filterListValue
                                              .value = value.toString();
                                          invoiceController.invoiceLists.value
                                              .clear();
                                          invoiceController.filterPage.value =
                                              1;
                                          invoiceController
                                              .onFilterListChange();
                                        },
                                        items: invoiceController.filterList
                                            .map((data) {
                                          return DropdownMenuItem(
                                              value: data,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 5.0),
                                                child: Text(
                                                  data,
                                                  overflow:
                                                      TextOverflow.visible,
                                                ),
                                              ));
                                        }).toList(),
                                      ),
                                    ),
                                  );
                                }),
                                SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.to(VerifiedInvoices(
                                      invoiceController: invoiceController,
                                    ));
                                  },
                                  child: Container(
                                    child: SvgPicture.asset(
                                        "assets/images/verified_image.svg"),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ),
                          Expanded(child: InvoiceTab()),
                        ],
                      ),
                      WalletTab(),
                      Due()
                    ],
                  ),
                ),
              ],
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniCenterFloat,
            floatingActionButton: Obx(() {
              return (invoiceController.isAddInvoiceTrue.value == false ||
                      invoiceController.selectShopId == null)
                  ? Container()
                  : FloatingActionButton(
                      backgroundColor: Color.fromARGB(255, 57, 55, 166),
                      onPressed: () {
                        Get.to(AddInvoiceView(
                          shopId: invoiceController.selectShopId,
                          invoiceController: invoiceController,
                        ));
                      },
                      child: Icon(
                        Icons.add,
                        size: 30,
                      ));
            }),
          ),
        ),
      ),
    );
  }
}
