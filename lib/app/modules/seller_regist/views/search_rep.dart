import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchRep extends StatelessWidget {
  SearchRep({super.key});
  final TextEditingController searchController = TextEditingController();
  final focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    focusNode.requestFocus();
    return Container(
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
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
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
          title: Text(
            'Search Representative',
            style: GoogleFonts.jost(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: Color(0xff4956b2),
            ),
          ),
        ),
        body: Column(
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
                        // _controller.getSearchResults(value);
                      },
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    // var data = _controller.searchUserList[index];

                    if (1 == 1) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14)),
                          elevation: 10,
                          child: ListTile(
                            onTap: (() {
                              // phone.number.text = data.phone;
                              // phone.id.text = data.id.toString();
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
                                  " {data.phone}",
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
                                Text("data.id.toString()",
                                    style: GoogleFonts.roboto(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500)),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                        elevation: 10,
                        child: ListTile(
                          onTap: (() {
                            // phone.number.text = data.phone;
                            // phone.id.text = data.id.toString();
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
                                " {data.phone}",
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
                              Text("data.id.toString()",
                                  style: GoogleFonts.roboto(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemCount: 10),
            ),
          ],
        ),
      ),
    );
  }
}
