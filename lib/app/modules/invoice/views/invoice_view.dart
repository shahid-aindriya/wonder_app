import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wonder_app/app/data/colors.dart';

import '../controllers/invoice_controller.dart';
import '../widgets/drawer_icon.dart';
import '../widgets/invoices_tab.dart';
import '../widgets/notification_icon.dart';

class InvoiceView extends GetView<InvoiceController> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/wonder_app_background.png"),
                fit: BoxFit.cover)),
        child: Scaffold(
            drawer: Drawer(),
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              leadingWidth: 90,
              leading: Builder(builder: (contezxt) {
                return InkWell(
                  onTap: () {
                    Scaffold.of(contezxt).openDrawer();
                  },
                  child: Container(
                    decoration: BoxDecoration(),
                    child: Center(
                      child: DrawerIcon(),
                    ),
                  ),
                );
              }),
              actions: [
                Container(
                  decoration: BoxDecoration(),
                  child: Center(
                    child: BellWidget(),
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
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      InvoiceTab(),
                      Column(
                        children: [
                          Container(
                            child: Center(
                              child: Text('Content of Tab 2'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
