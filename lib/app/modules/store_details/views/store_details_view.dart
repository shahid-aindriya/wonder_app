import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wonder_app/app/modules/map_place_picker/views/map_place_picker_view.dart';
import 'package:wonder_app/app/modules/registration_details/views/registration_details_view.dart';

import '../controllers/store_details_controller.dart';

class StoreDetailsView extends GetView<StoreDetailsController> {
  final storeLocation;
  final TextEditingController shopNameController = TextEditingController();
  final TextEditingController shopAdressController = TextEditingController();
  final TextEditingController gstPercentageController = TextEditingController();
  final TextEditingController commissionController = TextEditingController();
  final TextEditingController closeTimeController = TextEditingController();
  final TextEditingController openTimeController = TextEditingController();
  final TextEditingController latController = TextEditingController();
  final TextEditingController longController = TextEditingController();
  @override
  final StoreDetailsController controller = Get.put(StoreDetailsController());

  StoreDetailsView({this.storeLocation});

  @override
  Widget build(BuildContext context) {
    // log(storeLocation.toString());
    final formKey = GlobalKey<FormState>();
    final TextEditingController shopLocationController =
        TextEditingController();
    controller.getShopCategories();
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
                    onPressed: () {
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
              'Store Details',
              style: GoogleFonts.jost(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: Color(0xff4956b2),
              ),
            ),
          ),
          body: ListView(
            children: [
              SizedBox(
                height: 5.h,
              ),
              Form(
                key: formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 14.0),
                        child: Row(
                          children: [
                            Text(
                              'Shop Name',
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                height: 1.1725,
                                color: Color(0xff4956b2),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: shopNameController,
                        enabled: true,
                        style: GoogleFonts.roboto(
                            fontSize: 18, color: Color.fromRGBO(0, 0, 0, 1)),
                        decoration: InputDecoration(
                            hintStyle: GoogleFonts.roboto(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                              height: 1.1725,
                              color: Color.fromARGB(93, 0, 0, 0),
                            ),
                            hintText: "Enter shop name",
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
                        validator: (value) {
                          if (!RegExp(r"^[a-zA-Z ]+$").hasMatch(value!) ||
                              value.length < 3) {
                            return 'please enter valid name';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 14.0),
                        child: Row(
                          children: [
                            Text(
                              'Store Address',
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                height: 1.1725,
                                color: Color(0xff4956b2),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: shopAdressController,
                        enabled: true,
                        style: GoogleFonts.roboto(
                            fontSize: 18, color: Color.fromRGBO(0, 0, 0, 1)),
                        decoration: InputDecoration(
                            hintStyle: GoogleFonts.roboto(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                              height: 1.1725,
                              color: Color.fromARGB(93, 0, 0, 0),
                            ),
                            hintText: "Enter full adress",
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
                        validator: (value) {
                          if (!RegExp(r'^[#.0-9a-zA-Z\u00C0-\u00FF ,]+$')
                                  .hasMatch(value!) ||
                              value.length < 3) {
                            return 'please enter valid adress';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 14.0),
                        child: Row(
                          children: [
                            Text(
                              'Store Location',
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                height: 1.1725,
                                color: Color(0xff4956b2),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: shopLocationController,
                        enabled: true,
                        style: GoogleFonts.roboto(
                            fontSize: 18, color: Color.fromRGBO(0, 0, 0, 1)),
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () async {
                                  Get.to(MapPlacePickerView(),
                                      arguments: LocationDatas(
                                          lat: latController,
                                          location: shopLocationController,
                                          long: longController));

                                  // Get.to(MapPlacePicker());
                                },
                                icon: Icon(Icons.my_location)),
                            hintStyle: GoogleFonts.roboto(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                              height: 1.1725,
                              color: Color.fromARGB(93, 0, 0, 0),
                            ),
                            hintText: "Enter Store location",
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
                        validator: (value) {
                          if (value!.length < 3) {
                            return 'please enter valid adress';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 14.0),
                        child: Row(
                          children: [
                            Text(
                              'Commission %',
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                height: 1.1725,
                                color: Color(0xff4956b2),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: commissionController,
                        enabled: true,
                        keyboardType: TextInputType.number,
                        style: GoogleFonts.roboto(
                            fontSize: 18, color: Color.fromRGBO(0, 0, 0, 1)),
                        decoration: InputDecoration(
                            hintStyle: GoogleFonts.roboto(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                              height: 1.1725,
                              color: Color.fromARGB(93, 0, 0, 0),
                            ),
                            hintText: "Enter Commision in percentage",
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
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter valid amount';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 14.0),
                        child: Row(
                          children: [
                            Text(
                              'Gst-Percentage',
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                height: 1.1725,
                                color: Color(0xff4956b2),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: gstPercentageController,
                        keyboardType: TextInputType.number,
                        enabled: true,
                        style: GoogleFonts.roboto(
                            fontSize: 18, color: Color.fromRGBO(0, 0, 0, 1)),
                        decoration: InputDecoration(
                            hintStyle: GoogleFonts.roboto(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                              height: 1.1725,
                              color: Color.fromARGB(93, 0, 0, 0),
                            ),
                            hintText: "Enter Gst in percentage",
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
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter valid amount';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 14.0),
                        child: Row(
                          children: [
                            Text(
                              'Opening Time',
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                height: 1.1725,
                                color: Color(0xff4956b2),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: openTimeController,
                        enabled: true,
                        keyboardType: TextInputType.none,
                        style: GoogleFonts.roboto(
                            fontSize: 18, color: Color.fromRGBO(0, 0, 0, 1)),
                        decoration: InputDecoration(
                            hintStyle: GoogleFonts.roboto(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                              height: 1.1725,
                              color: Color.fromARGB(93, 0, 0, 0),
                            ),
                            hintText: "Enter opening time",
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
                        validator: (value) {
                          if (value == null) {
                            return 'please enter opening time';
                          } else {
                            return null;
                          }
                        },
                        onTap: () async {
                          TimeOfDay? selectedOpeningTime;
                          final TimeOfDay? picked = await showTimePicker(
                            context: context,
                            initialTime: selectedOpeningTime ?? TimeOfDay.now(),
                          );
                          if (picked != null) {
                            selectedOpeningTime = picked;
                            openTimeController.text =
                                "${selectedOpeningTime.hour}:${selectedOpeningTime.minute}";
                          } else {
                            var current = TimeOfDay.now();
                            openTimeController.text =
                                "${current.hour}:${current.minute}";
                          }
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 14.0),
                        child: Row(
                          children: [
                            Text(
                              'Closing Time',
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                height: 1.1725,
                                color: Color(0xff4956b2),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: closeTimeController,
                        enabled: true,
                        keyboardType: TextInputType.none,
                        style: GoogleFonts.roboto(
                            fontSize: 18, color: Color.fromRGBO(0, 0, 0, 1)),
                        decoration: InputDecoration(
                            hintStyle: GoogleFonts.roboto(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                              height: 1.1725,
                              color: Color.fromARGB(93, 0, 0, 0),
                            ),
                            hintText: "Enter closing time",
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
                        validator: (value) {
                          if (value == null) {
                            return 'please enter closing time';
                          } else {
                            return null;
                          }
                        },
                        onTap: () async {
                          TimeOfDay? selectedOpeningTime;
                          final TimeOfDay? picked = await showTimePicker(
                            context: context,
                            initialTime: selectedOpeningTime ?? TimeOfDay.now(),
                          );
                          if (picked != null) {
                            selectedOpeningTime = picked;
                            closeTimeController.text =
                                "${selectedOpeningTime.hour}:${selectedOpeningTime.minute}";
                          } else {
                            var current = TimeOfDay.now();
                            closeTimeController.text =
                                "${current.hour}:${current.minute}";
                          }
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 14.0),
                        child: Row(
                          children: [
                            Text(
                              'Category',
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                height: 1.1725,
                                color: Color(0xff4956b2),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Obx(() {
                        return DropdownButtonFormField(
                          isDense: true,
                          style: GoogleFonts.roboto(
                              fontSize: 18, color: Color.fromRGBO(0, 0, 0, 1)),
                          decoration: InputDecoration(
                              hintStyle: GoogleFonts.roboto(
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                                height: 1.1725,
                                color: Color.fromARGB(93, 0, 0, 0),
                              ),
                              hintText: "Select Category",
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 18.0, horizontal: 18),
                              enabled: true,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                      width: 0,
                                      color:
                                          Color.fromARGB(255, 199, 199, 179))),
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0,
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
                                  borderRadius: BorderRadius.circular(16)),
                              fillColor: Color.fromARGB(153, 255, 255, 255),
                              focusColor: Color.fromARGB(255, 231, 231, 231)),
                          value: controller.categoryId,
                          onChanged: (value) {
                            controller.changeCategory(
                              value: value,
                            );
                          },
                          items: controller.categoryLists.value.map((data) {
                            return DropdownMenuItem(
                                value: data.id.toString(),
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 5.0),
                                  child: Text(
                                    data.name,
                                    overflow: TextOverflow.visible,
                                  ),
                                ));
                          }).toList(),
                          validator: (value) {
                            if (controller.categoryId == null) {
                              return "Please Select category";
                            }
                            return null;
                          },
                        );
                      }),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 14.0),
                        child: Row(
                          children: [
                            Text(
                              'Upload Shop Image',
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                height: 1.1725,
                                color: Color(0xff4956b2),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      GetBuilder<StoreDetailsController>(builder: (contexta) {
                        return Row(
                          children: [
                            Wrap(
                              children: [
                                Container(
                                  width: 65.w,
                                  child: TextFormField(
                                    enabled: false,
                                    style: GoogleFonts.roboto(
                                        fontSize: 18,
                                        color: Color.fromRGBO(0, 0, 0, 1)),
                                    decoration: InputDecoration(
                                        hintStyle: GoogleFonts.roboto(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300,
                                          height: 1.1725,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                        ),
                                        hintText: controller.shopImage == ''
                                            ? "Browse Document"
                                            : "Uploaded",
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 18.0, horizontal: 18),
                                        enabled: true,
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(16),
                                                topLeft: Radius.circular(16)),
                                            borderSide: BorderSide(
                                                width: 0,
                                                color: Color.fromARGB(
                                                    255, 199, 199, 179))),
                                        filled: true,
                                        disabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(16),
                                                topLeft: Radius.circular(16)),
                                            borderSide: BorderSide(
                                                width: 0,
                                                color: Color.fromARGB(
                                                    255, 199, 199, 179))),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(width: 0, color: Color.fromARGB(255, 255, 255, 255)),
                                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16), topLeft: Radius.circular(16))),
                                        fillColor: Color.fromARGB(153, 255, 255, 255),
                                        focusColor: Color.fromARGB(255, 231, 231, 231)),
                                  ),
                                ),
                                InkWell(
                                    onTap: () {
                                      // controller.pickimage();
                                    },
                                    child: Container(
                                        height: 56,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(10),
                                              bottomRight: Radius.circular(10)),
                                          border: Border(),
                                          gradient: LinearGradient(
                                            begin: Alignment(-0.934, -1),
                                            end: Alignment(1.125, 1.333),
                                            colors: <Color>[
                                              Color(0xe53f46bd),
                                              Color(0xe5417de8)
                                            ],
                                            stops: <double>[0, 1],
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0x3f000000),
                                              offset: Offset(0, 0.7870440483),
                                              blurRadius: 2.7546541691,
                                            ),
                                          ],
                                        ),
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                              elevation:
                                                  MaterialStateProperty.all(0),
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.transparent)),
                                          onPressed: () {
                                            controller.showPopup(context);
                                          },
                                          child: Text(
                                            'Upload',
                                            style: GoogleFonts.roboto(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                              height: 1.2110513051,
                                              color: Color(0xffffffff),
                                            ),
                                          ),
                                        ))),
                              ],
                            ),
                          ],
                        );
                      }),
                      SizedBox(
                        height: 13,
                      ),
                      GetBuilder<StoreDetailsController>(builder: (context) {
                        return Row(
                          children: [
                            Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Checkbox(
                                checkColor: Color(0xff4956b2),
                                activeColor: Color.fromARGB(255, 255, 255, 255),
                                fillColor: MaterialStateProperty.all(
                                    Color.fromARGB(255, 255, 255, 255)),
                                value: controller.isChecked,
                                onChanged: (value) {
                                  controller.checkBox(value);
                                },
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text("Set Featured",
                                style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    height: 1.1725,
                                    color: Color(0xff4956b2)))
                          ],
                        );
                      }),
                      SizedBox(
                        height: 52,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              if (controller.shopImage == '') {
                                controller.alertPopu(
                                    context: context,
                                    data: "Please Enter All Fields");
                              } else if (formKey.currentState!.validate()) {
                                Get.off(RegistrationDetailsView(
                                  featured: controller.isChecked,
                                  commission: commissionController.text,
                                  gstPercentage: gstPercentageController.text,
                                  categoryId: controller.categoryId,
                                  shopAdress: shopAdressController.text,
                                  shopImage: controller.shopImage,
                                  shopLocation: shopLocationController.text,
                                  shopName: shopNameController.text,
                                  closingTime: closeTimeController.text,
                                  openingTime: openTimeController.text,
                                ));
                              }
                            },
                            child: Container(
                              width: 124,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border(),
                                gradient: LinearGradient(
                                  begin: Alignment(-0.934, -1),
                                  end: Alignment(1.125, 1.333),
                                  colors: <Color>[
                                    Color(0xe53f46bd),
                                    Color(0xe5417de8)
                                  ],
                                  stops: <double>[0, 1],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x3f000000),
                                    offset: Offset(0, 0.7870440483),
                                    blurRadius: 2.7546541691,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  'Next',
                                  style: GoogleFonts.roboto(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    height: 1.2110513051,
                                    color: Color(0xffffffff),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 52,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

class LocationDatas {
  TextEditingController? location;
  TextEditingController? long;
  TextEditingController? lat;
  LocationDatas({this.location, this.lat, this.long});
}
