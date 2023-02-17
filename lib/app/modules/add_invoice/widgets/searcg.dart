import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wonder_app/app/modules/add_invoice/controllers/add_invoice_controller.dart';

import '../views/add_invoice_view.dart';

class SearchUser extends GetView<AddInvoiceController> {
  final text;
  final AddInvoiceController _controller = Get.put(AddInvoiceController());

  SearchUser({this.text});
  final focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    final TextData phone = Get.arguments;
    final TextEditingController searchController = TextEditingController();
    focusNode.requestFocus();
    // TODO: implement build

    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/wonder_app_background.jpg"),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Color.fromARGB(117, 255, 255, 255),
                  borderRadius: BorderRadius.circular(10)),
              child: IconButton(
                  onPressed: () async {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: Color(0xff4956b2),
                  )),
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            'Search user',
            style: GoogleFonts.jost(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: Color(0xff4956b2),
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                      child: TextField(
                        focusNode: focusNode,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintStyle: GoogleFonts.roboto(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                              height: 1.1725,
                              color: Color.fromARGB(93, 0, 0, 0),
                            ),
                            hintText: "Search user",
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 18.0, horizontal: 18),
                            enabled: true,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(
                                    width: 0,
                                    color: Color.fromARGB(255, 199, 199, 179))),
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0,
                                    color: Color.fromARGB(255, 255, 255, 255)),
                                borderRadius: BorderRadius.circular(16)),
                            fillColor: Color.fromARGB(153, 255, 255, 255),
                            focusColor: Color.fromARGB(255, 231, 231, 231)),
                        controller: searchController,
                        onChanged: (value) {
                          _controller.getSearchResults(value);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Obx(
                () {
                  return Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          var data = _controller.searchUserList[index];
                          if (data.phone
                              .toLowerCase()
                              .contains(searchController.text.toLowerCase())) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14)),
                                elevation: 10,
                                child: ListTile(
                                  onTap: (() {
                                    phone.number.text = data.phone;
                                    phone.id.text = data.id.toString();
                                    Get.back();
                                  }),
                                  leading: Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Image.asset(
                                      'assets/images/User.png',
                                    ),
                                  ),
                                  title: Row(
                                    children: [
                                      Text(
                                        "Number:",
                                        style: GoogleFonts.roboto(
                                            fontWeight: FontWeight.w300),
                                      ),
                                      Text(
                                        " ${data.phone}",
                                        style: GoogleFonts.roboto(
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  subtitle: Row(
                                    children: [
                                      // SizedBox(
                                      //   width: 10.w,
                                      // ),
                                      Text(
                                        "Id: ",
                                        style: GoogleFonts.roboto(
                                            fontWeight: FontWeight.w300),
                                      ),
                                      Text(data.id.toString(),
                                          style: GoogleFonts.roboto(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                        itemCount: _controller.searchUserList.length),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
