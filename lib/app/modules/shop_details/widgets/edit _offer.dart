import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';import 'package:video_player/video_player.dart';
import 'package:wonder_app/app/data/urls.dart';
import 'package:wonder_app/app/modules/shop_details/model/offer_data_response.dart';

import '../controllers/shop_details_controller.dart';

class EditOffer extends StatefulWidget {
  final OfferDatum data;

  EditOffer({super.key, required this.data});

  @override
  State<EditOffer> createState() => _EditOfferState();
}

class _EditOfferState extends State<EditOffer> {
  final ShopDetailsController shopDetailsController =
      Get.put(ShopDetailsController());

  final formKey = GlobalKey<FormState>();

  late ChewieController _chewieController;

  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse("$baseUrlForImage/${widget.data.video}"));
    _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: false,
        looping: false,
        showControls: true
        // Additional chewie options can be set here
        );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.data.discount == null
        ? shopDetailsController.selectedEditDiscount.value = 2
        : shopDetailsController.selectedEditDiscount.value = 1;
    // VideoPlayerController videoPlayerController =
    //     VideoPlayerController.networkUrl(
    //         Uri.parse("$baseUrlForImage/${data.video}"));
    // final chewieController = ChewieController(
    //   videoPlayerController: videoPlayerController,
    //   autoPlay: false,
    //   looping: false,
    //   showControls: true,
    // );
    final TextEditingController titleController =
        TextEditingController(text: widget.data.title);
    final TextEditingController discountController = TextEditingController(
        text: widget.data.discount ?? widget.data.discountAmount);
    final TextEditingController descriptionController =
        TextEditingController(text: widget.data.description);
    final TextEditingController linkController =
        TextEditingController(text: widget.data.link);
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
                        // _videoPlayerController.dispose();
                        // _chewieController.dispose();

                        shopDetailsController.editPath.value = "";
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
                'Edit Offers',
                style: GoogleFonts.jost(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff4956b2),
                ),
              ),
            ),
            body: WillPopScope(
              onWillPop: () async {
                // _videoPlayerController.dispose();
                // _chewieController.dispose();
                shopDetailsController.editPath.value = "";
                Get.back();
                throw Exception();
              },
              child: ListView(
                children: [
                  Form(
                    key: formKey,
                    child: Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 14.0, top: 20),
                            child: Row(
                              children: [
                                Text(
                                  'Title',
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
                            enabled: true,
                            controller: titleController,
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
                                hintText: "Enter title",
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 18.0, horizontal: 18),
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
                                        color:
                                            Color.fromARGB(255, 255, 255, 255)),
                                    borderRadius: BorderRadius.circular(16)),
                                fillColor: Color.fromARGB(153, 255, 255, 255),
                                focusColor: Color.fromARGB(255, 231, 231, 231)),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please enter valid data';
                              } else {
                                return null;
                              }
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 14.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Obx(
                                      () => Radio<int>(
                                        fillColor: MaterialStateProperty.all(
                                            Color(0xff4956b2)),
                                        value: 1,
                                        groupValue: shopDetailsController
                                            .selectedEditDiscount.value,
                                        onChanged: (value) {
                                          shopDetailsController
                                              .selectedEditDiscount
                                              .value = value!;
                                        },
                                      ),
                                    ),
                                    Text(
                                      'Discount percent',
                                      style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        height: 1.1725,
                                        color: Color(0xff4956b2),
                                      ),
                                    ),
                                  ],
                                ),
                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Obx(
                                      () => Radio<int>(
                                        fillColor: MaterialStateProperty.all(
                                            Color(0xff4956b2)),
                                        value: 2,
                                        groupValue: shopDetailsController
                                            .selectedEditDiscount.value,
                                        onChanged: (value) {
                                          shopDetailsController
                                              .selectedEditDiscount
                                              .value = value!;
                                        },
                                      ),
                                    ),
                                    Text('Discount Amount',
                                        style: GoogleFonts.roboto(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          height: 1.1725,
                                          color: Color(0xff4956b2),
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.only(left: 14.0, top: 20),
                          //   child: Row(
                          //     children: [
                          //       Text(
                          //         'Discount',
                          //         style: GoogleFonts.roboto(
                          //           fontSize: 16,
                          //           fontWeight: FontWeight.w400,
                          //           height: 1.1725,
                          //           color: Color(0xff4956b2),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          SizedBox(
                            height: 4,
                          ),
                          TextFormField(
                            enabled: true,
                            controller: discountController,
                            keyboardType: TextInputType.number,
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
                                hintText: shopDetailsController
                                            .selectedEditDiscount.value ==
                                        1
                                    ? "Enter dicount percentage"
                                    : "Enter dicount amount",
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 18.0, horizontal: 18),
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
                                        color:
                                            Color.fromARGB(255, 255, 255, 255)),
                                    borderRadius: BorderRadius.circular(16)),
                                fillColor: Color.fromARGB(153, 255, 255, 255),
                                focusColor: Color.fromARGB(255, 231, 231, 231)),
                            validator: (value) {
                              if (!RegExp((r'^-?[0-9]+$')).hasMatch(value!)) {
                                return 'please enter valid Number';
                              } else {
                                return null;
                              }
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 14.0, top: 20),
                            child: Row(
                              children: [
                                Text(
                                  'Description',
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
                            enabled: true,
                            controller: descriptionController,
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
                                hintText: "Enter description",
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 18.0, horizontal: 18),
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
                                        color:
                                            Color.fromARGB(255, 255, 255, 255)),
                                    borderRadius: BorderRadius.circular(16)),
                                fillColor: Color.fromARGB(153, 255, 255, 255),
                                focusColor: Color.fromARGB(255, 231, 231, 231)),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please enter valid description';
                              } else {
                                return null;
                              }
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 14.0, top: 20),
                            child: Row(
                              children: [
                                Text(
                                  'Link',
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
                            enabled: true,
                            controller: linkController,
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
                                hintText: "Enter link",
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 18.0, horizontal: 18),
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
                                        color:
                                            Color.fromARGB(255, 255, 255, 255)),
                                    borderRadius: BorderRadius.circular(16)),
                                fillColor: Color.fromARGB(153, 255, 255, 255),
                                focusColor: Color.fromARGB(255, 231, 231, 231)),
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return 'please enter valid description';
                            //   } else {
                            //     return null;
                            //   }
                            // },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 14.0, top: 20),
                            child: Row(
                              children: [
                                Text(
                                  'Offer Image',
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
                          GetBuilder<ShopDetailsController>(
                              builder: (scontext) {
                            return Row(
                              children: [
                                Expanded(
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
                                        hintText:
                                            shopDetailsController.offerImage == ''
                                                ? "Browse Document"
                                                : "Uploaded",
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 18.0, horizontal: 18),
                                        enabled: true,
                                        disabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(16),
                                                topLeft: Radius.circular(16)),
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
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(16),
                                                topLeft: Radius.circular(16))),
                                        fillColor: Color.fromARGB(153, 255, 255, 255),
                                        focusColor: Color.fromARGB(255, 231, 231, 231)),
                                    // validator: (value) {
                                    //   if (!RegExp(r'^-?[0-9]+$')
                                    //           .hasMatch(value!) ||
                                    //       value.length < 3) {
                                    //     return 'please enter valid email';
                                    //   } else {
                                    //     return null;
                                    //   }
                                    // },
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    shopDetailsController.showPopup(
                                        context,
                                        (value) => shopDetailsController
                                            .pickimage(value));
                                  },
                                  child: Container(
                                    width: 100,
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
                                    child: Center(
                                      child: Text(
                                        'Upload',
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
                            );
                          }),
                          Padding(
                            padding: const EdgeInsets.only(left: 14.0, top: 20),
                            child: Row(
                              children: [
                                Text(
                                  'Upload Video ',
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
                          Container(
                              height: 47,
                              width: 100.w,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.white, width: 1),
                                  borderRadius: BorderRadius.circular(16),
                                  color: Color.fromARGB(153, 255, 255, 255)),
                              child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 5, right: 5),
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                          elevation:
                                              MaterialStateProperty.all(0),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.transparent)),
                                      onPressed: () async {
                                        shopDetailsController.pickVideo(2);
                                      },
                                      child: Icon(
                                        Icons.add,
                                        color: Color(0xff4956b2),
                                      )))),
                          Obx(() {
                            // final isVideoPlaying =
                            //     shopDetailsController.isVideoPlaying2.value;
                            if (shopDetailsController.editPath.value != "") {
                              return GetBuilder<ShopDetailsController>(
                                  builder: (contexst) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Container(
                                    width: 89.w,
                                    height: 200,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: AspectRatio(
                                          aspectRatio: contexst
                                              .videoPlayerController2!
                                              .value
                                              .aspectRatio,
                                          child: Chewie(
                                              controller:
                                                  contexst.chewieController2),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              });
                            } else {
                              return Container();
                            }
                          }),
                          Obx(() {
                            return Visibility(
                              visible: (shopDetailsController
                                          .isVideoPlaying2.value) ==
                                      true
                                  ? false
                                  : widget.data.video == null
                                      ? false
                                      : shopDetailsController.editPath.value ==
                                              ""
                                          ? false
                                          : true,
                              child: Container(
                                width: 89.w,
                                height: 200,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Chewie(
                                      controller: _chewieController,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            bottomNavigationBar: Container(
              height: 70,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              fixedSize:
                                  MaterialStateProperty.all(Size(120, 50)),
                              backgroundColor: MaterialStateProperty.all(
                                  Color.fromARGB(255, 196, 38, 27))),
                          onPressed: () {
                            shopDetailsController.deleteOffer(
                                widget.data.id, context);
                          },
                          child: Text("Delete Offer")),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
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
                          child: ElevatedButton(
                            style: ButtonStyle(
                                fixedSize:
                                    MaterialStateProperty.all(Size(100, 50)),
                                elevation: MaterialStateProperty.all(0),
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.transparent)),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                shopDetailsController.editOffers(
                                    context: context,
                                    link: linkController.text,
                                    name: titleController.text,
                                    description: descriptionController.text,
                                    discount: discountController.text,
                                    offerId: widget.data.id);
                              }
                            },
                            child: Text(
                              'Edit',
                              style: GoogleFonts.roboto(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                height: 1.2110513051,
                                color: Color(0xffffffff),
                              ),
                            ),
                          )),
                    ],
                  ),
                ],
              ),
            )));
  }
}
