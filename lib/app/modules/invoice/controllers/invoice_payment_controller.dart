import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:wonder_app/app/modules/invoice/model/verified_model.dart';

import '../views/invoice_view.dart';
import '../widgets/verifed_invoice/firebase_database_controller.dart';

final InvoicePaymentController invoicePaymentController =
    Get.put(InvoicePaymentController());

class InvoicePaymentController extends GetxController {
  int? vendorId;
  int? shopId;
  double? shopCommission;
  double? shopHalfCommission;
  double? commissionAmount;
  double? shopWalletAmount;
  String? preTaxAmount;
  double? invoiceAmount;
  double? vendorCommission;
  double? vendorBalance;
  int? expiryDays;
  double? getBalanceAmount;
  String? walletType;
  int? customerId;
  double? levelPercentsge;
  int? i;
  double? userCommission;
  double? balanceAmount;
  String? parentId;
  double? firstMonthCommission;
  double? fieldVisitCommission;
  dynamic getUserCommission;

  int? userBusinessRep;
  int? userRelationshipManager;
  int? userAdminOfficer;
  int? userZonalManager;
  int? userBusinessDirector;
  int? userBusinessPresident;
  final progressLoading = false.obs;
  bulkApproval(RxList<VerifiedInvoiceData> verifiedList, walletAmount2) async {
    RxList<VerifiedInvoiceData> selectedItems =
        RxList<VerifiedInvoiceData>.from(
      verifiedList.take(verifiedList.length < 20 ? verifiedList.length : 20),
    );

    expiryDays = await firebaseDatabaseController.getExpireDays();
    DateTime today = DateTime.now();
    DateTime expiryDate = today.add(Duration(days: expiryDays as int));

    shopId = selectedItems[0].shopId;
    log("shopId: ${shopId.toString()}");
    // Map<dynamic, dynamic> shopValues =
    //     await firebaseDatabaseController.shopData(shopId);

    // String walletAmount = shopValues["wallet_amount"];
    // double convertAmount =
    //     double.parse(walletAmount.isEmpty ? "0.0" : walletAmount);
    // String roundWalletAmount = convertAmount.toStringAsFixed(2);
    shopWalletAmount = double.parse(walletAmount2.toString());

    // updateProgress(progressValue);
    for (var verifiedData in selectedItems) {
      if ((verifiedData.payHalfAmount == true) &&
          (verifiedData.bulkApproveStatus == false)) {
        listCount.value++;

        vendorId = verifiedData.userId;
        shopCommission = verifiedData.shopCommission;
        shopHalfCommission = 50;
        customerId = verifiedData.customerId;

        preTaxAmount = verifiedData.preTaxAmount;
        invoiceAmount = double.parse(preTaxAmount.toString());

        if (verifiedData.isImport == true) {
          commissionAmount = invoiceAmount;
        } else {
          commissionAmount = calculatePercentage(shopCommission, invoiceAmount);
        }
        log("cimmission amount $commissionAmount");

        vendorCommission =
            calculatePercentage(shopHalfCommission, commissionAmount);
        log(vendorCommission.toString());
        vendorBalance =
            calculatePercentage(shopHalfCommission, commissionAmount);
        getBalanceAmount = commissionAmount;
        walletType = "Direct";
        log("wallet${shopWalletAmount.toString()}");
        log("commiss${vendorCommission.toString()}");
        if (shopWalletAmount! >= vendorCommission!) {
          log("custId:  ${customerId.toString()}");
          Map<dynamic, dynamic> userData =
              await firebaseDatabaseController.userData(customerId);
          // log("userData:${userData.toString()}");
          for (int i = 1; i <= 15; i++) {
            String parent = "p$i";
            parentId = userData[parent];

            if (i != 1) {
              walletType = "In Direct";
            }

            // ignore: unrelated_type_equality_checks
            if (int.tryParse(parentId.toString()) != 0) {
              levelPercentsge =
                  await firebaseDatabaseController.levelPercentsge(i + 1);

              userCommission =
                  calculatePercentage(levelPercentsge, commissionAmount);
              balanceAmount = getBalanceAmount! - userCommission!;
              getBalanceAmount = balanceAmount;
              log("Level percent:$levelPercentsge");
              log("commission amountt:$commissionAmount");
              log("user commission:$userCommission");
              //***** user wallet transaction
              firebaseDatabaseController.walletTransaction(
                  userId: parentId,
                  vendorId: vendorId,
                  shopId: shopId,
                  amount: userCommission,
                  invoiceId: verifiedData.id,
                  entryType: "Credit",
                  walletType: walletType,
                  expiryDate: expiryDate.toString(),
                  status: "Approve");

              //***** shop wallet transaction
              firebaseDatabaseController.shopWalletTransaction(
                  userId: parentId,
                  vendorId: vendorId,
                  shopId: shopId,
                  amount: userCommission,
                  invoiceId: verifiedData.id,
                  entryType: "Debit",
                  walletType: walletType,
                  expiryDate: expiryDate.toString(),
                  status: "Approve");
            }
          }

          if (getBalanceAmount! > 0) {
            firebaseDatabaseController.walletTransaction(
                userId: 1,
                vendorId: vendorId,
                shopId: shopId,
                amount: getBalanceAmount,
                invoiceId: verifiedData.id,
                entryType: "Credit",
                walletType: walletType,
                expiryDate: expiryDate.toString(),
                status: "Approve");
          }
          updateUserRoleCommissionAndShopBalance(
              verifiedInvoiceData: verifiedData,
              vendorBalance: vendorBalance,
              commissionAmount: commissionAmount);
          log("message");
          invoiceController.updateInvoiceBulkStatus(verifiedData.id);
        } else {
          Get.back();
          Get.snackbar("Error", "Insufficiant Balance",
              backgroundColor: Colors.red);

          return;
        }
      }
      //  else {
      //   Get.snackbar("Error", "Pay invoice amount",
      //       backgroundColor: Colors.red);
      //   return;
      // }
    }

    for (int i = 0; i < listCount.value; i++) {
      double progressValue = (i + 1) / listCount.value;
      // count.value++;
      count.value = count.value + 1;
      progress.value = progressValue;
      // update();
    }

    invoiceController.verifiedList.clear();
    await invoiceController.verifiedInvoiceList();
    progressLoading.value = true;
    // progress.value = 0.0;
    // count.value = 0;
    // listCount.value = 0;
    update();
    // Get.back();

    // count.value = 0;
    // progress.value = 0.0;
    // Get.back();
    // Get.snackbar("Info ", "Success", backgroundColor: Colors.green);

    return;
  }

  updateUserRoleCommissionAndShopBalance(
      {required VerifiedInvoiceData verifiedInvoiceData,
      vendorBalance,
      commissionAmount}) async {
    shopId = verifiedInvoiceData.shopId;
    invoiceAmount = double.parse(verifiedInvoiceData.preTaxAmount.toString());
    vendorId = verifiedInvoiceData.userId;
    userCommission = 0.0;

    Map<dynamic, dynamic> shopData =
        await firebaseDatabaseController.shopData(shopId);

    print("===============$shopId");

    int adminOfficer = 2;
    int zonalManager = 1;
    int relationshipManager = 3;
    int businessRepresentative = 4;
    int businessDirector = 5;
    int businessPresident = 6;

    if (shopData.containsKey("business_rep_id")) {
      userBusinessRep = shopData["business_rep_id"];
    }
    if (shopData.containsKey("business_manager_id")) {
      userRelationshipManager = shopData["business_manager_id"];
    }
    if (shopData.containsKey("business_head_id")) {
      userAdminOfficer = shopData["business_head_id"];
    }
    if (shopData.containsKey("business_organiser_id")) {
      userZonalManager = shopData["business_organiser_id"];
    }
    if (shopData.containsKey("business_director_id")) {
      userBusinessDirector = shopData["business_director_id"];
    }
    if (shopData.containsKey("business_president_id")) {
      userBusinessPresident = shopData["business_president_id"];
    }
    log("userBusinessRep $userBusinessRep");
    log("userRelationshipManager $userRelationshipManager");
    log("userAdminOfficer $userAdminOfficer");
    log("userZonalManager $userZonalManager");
    log("userBusinessDirector $userBusinessDirector");
    log("userBusinessPresident $userBusinessPresident");
    if (userBusinessRep != null) {
      Map<dynamic, dynamic> offlineCommissionData =
          await firebaseDatabaseController
              .offlineCommissionData(businessRepresentative);

      String businessrepCommission = offlineCommissionData['commission'];
      double businessrepCommissionAmount = calculatePercentage(
          double.parse(businessrepCommission), commissionAmount);

      firebaseDatabaseController.createUserTransaction(
          userId: userBusinessRep,
          vendorId: verifiedInvoiceData.userId,
          shopId: verifiedInvoiceData.shopId,
          amount: businessrepCommissionAmount,
          invoiceId: verifiedInvoiceData.id,
          entryType: "Credit",
          walletType: "User Offline Commission");
    }

    if (userRelationshipManager != null) {
      Map<dynamic, dynamic> offlineCommissionData =
          await firebaseDatabaseController
              .offlineCommissionData(relationshipManager);
      String relationshipManagerCommission =
          offlineCommissionData['commission'];
      double relationshipManagerCommissionAmount = calculatePercentage(
          double.parse(relationshipManagerCommission), commissionAmount);

      firebaseDatabaseController.createUserTransaction(
          userId: userRelationshipManager,
          vendorId: verifiedInvoiceData.userId,
          shopId: verifiedInvoiceData.shopId,
          amount: relationshipManagerCommissionAmount,
          invoiceId: verifiedInvoiceData.id,
          entryType: "Credit",
          walletType: "User Offline Commission");
    }

    if (userAdminOfficer != null) {
      Map<dynamic, dynamic> offlineCommissionData =
          await firebaseDatabaseController.offlineCommissionData(adminOfficer);

      String adminOfficerCommission = offlineCommissionData['commission'];
      double adminOfficerCommissionAmount = calculatePercentage(
          double.parse(adminOfficerCommission), commissionAmount);

      print(
          "=======$adminOfficerCommission===$adminOfficerCommissionAmount========$commissionAmount");

      firebaseDatabaseController.createUserTransaction(
          userId: userAdminOfficer,
          vendorId: verifiedInvoiceData.userId,
          shopId: verifiedInvoiceData.shopId,
          amount: adminOfficerCommissionAmount,
          invoiceId: verifiedInvoiceData.id,
          entryType: "Credit",
          walletType: "User Offline Commission");
    }

    if (userZonalManager != null) {
      Map<dynamic, dynamic> offlineCommissionData =
          await firebaseDatabaseController.offlineCommissionData(zonalManager);

      String zonalManagerCommission = offlineCommissionData['commission'];
      double zonalManagerCommissionAmount = calculatePercentage(
          double.parse(zonalManagerCommission), commissionAmount);

      firebaseDatabaseController.createUserTransaction(
          userId: userZonalManager,
          vendorId: verifiedInvoiceData.userId,
          shopId: verifiedInvoiceData.shopId,
          amount: zonalManagerCommissionAmount,
          invoiceId: verifiedInvoiceData.id,
          entryType: "Credit",
          walletType: "User Offline Commission");
    }

    if (userBusinessDirector != null) {
      Map<dynamic, dynamic> offlineCommissionData =
          await firebaseDatabaseController
              .offlineCommissionData(businessDirector);

      String businessDirectorCommission = offlineCommissionData['commission'];
      double businessDirectorCommissionAmount = calculatePercentage(
          double.parse(businessDirectorCommission), commissionAmount);

      firebaseDatabaseController.createUserTransaction(
          userId: userBusinessDirector,
          vendorId: verifiedInvoiceData.userId,
          shopId: verifiedInvoiceData.shopId,
          amount: businessDirectorCommissionAmount,
          invoiceId: verifiedInvoiceData.id,
          entryType: "Credit",
          walletType: "User Offline Commission");
    }

    if (userBusinessPresident != null) {
      Map<dynamic, dynamic> offlineCommissionData =
          await firebaseDatabaseController
              .offlineCommissionData(businessPresident);

      String businessPresidentCommission = offlineCommissionData['commission'];
      double businessPresidentCommissionAmount = calculatePercentage(
          double.parse(businessPresidentCommission), commissionAmount);

      firebaseDatabaseController.createUserTransaction(
          userId: userBusinessPresident,
          vendorId: verifiedInvoiceData.userId,
          shopId: verifiedInvoiceData.shopId,
          amount: businessPresidentCommissionAmount,
          invoiceId: verifiedInvoiceData.id,
          entryType: "Credit",
          walletType: "User Offline Commission");
    }
    firebaseDatabaseController.createUserTransaction(
        vendorId: verifiedInvoiceData.userId,
        shopId: verifiedInvoiceData.shopId,
        amount: vendorBalance,
        invoiceId: verifiedInvoiceData.id,
        entryType: "Credit",
        walletType: "Shop Due Amount");
  }
  // updateUserRoleCommissionAndShopBalance(
  //     {required VerifiedInvoiceData verifiedInvoiceData, vendorBalance}) async {
  //   shopId = verifiedInvoiceData.shopId;
  //   invoiceAmount = double.parse(verifiedInvoiceData.preTaxAmount.toString());
  //   vendorId = verifiedInvoiceData.userId;
  //   userCommission = 0.0;

  //   Map<dynamic, dynamic> settingsValues =
  //       await firebaseDatabaseController.settingsData();

  //   String getfirstMonthCommission = settingsValues["field_visit_commission"];
  //   double convertFirstMonthCommission = double.parse(getfirstMonthCommission);
  //   String roundFirstMonthCommission =
  //       convertFirstMonthCommission.toStringAsFixed(2);
  //   firstMonthCommission = double.parse(roundFirstMonthCommission);

  //   String getfieldVisitCommission = settingsValues["field_visit_commission"];
  //   double convertFieldVisitCommission = double.parse(getfieldVisitCommission);
  //   String roundfieldVisitCommission =
  //       convertFieldVisitCommission.toStringAsFixed(2);
  //   fieldVisitCommission = double.parse(roundfieldVisitCommission);

  //   if (verifiedInvoiceData.addedByCommission != null) {
  //     if (verifiedInvoiceData.fieldVisitCommission == true) {
  //       userCommission =
  //           calculatePercentage(fieldVisitCommission, invoiceAmount);
  //       getUserCommission = verifiedInvoiceData.addedByCommission;
  //       userCommission = getUserCommission! + userCommission!;

  //       firebaseDatabaseController.createUserTransaction(
  //           userId: verifiedInvoiceData.shopAddedBy,
  //           vendorId: verifiedInvoiceData.userId,
  //           shopId: verifiedInvoiceData.shopId,
  //           amount: userCommission,
  //           invoiceId: verifiedInvoiceData.id,
  //           entryType: "Credit",
  //           walletType: "User Field Visit Commission");
  //     } else {
  //       userCommission =
  //           calculatePercentage(firstMonthCommission, invoiceAmount);
  //       getUserCommission = verifiedInvoiceData.addedByCommission;
  //       userCommission = getUserCommission! + userCommission!;

  //       firebaseDatabaseController.createUserTransaction(
  //           userId: verifiedInvoiceData.shopAddedBy,
  //           vendorId: verifiedInvoiceData.userId,
  //           shopId: verifiedInvoiceData.shopId,
  //           amount: userCommission,
  //           invoiceId: verifiedInvoiceData.id,
  //           entryType: "Credit",
  //           walletType: "User Field Visit Commission");
  //     }
  //   }

  //   if (verifiedInvoiceData.shopBusinessRepId != null) {
  //     DateTime now = DateTime.now();
  //     DateTime oneMonthAgo = now.subtract(Duration(days: 30));

  //     if (DateTime.parse(verifiedInvoiceData.shopCreatedAt)
  //         .isAfter(oneMonthAgo)) {
  //       userCommission =
  //           calculatePercentage(firstMonthCommission, invoiceAmount);
  //       getUserCommission = verifiedInvoiceData.businessRepCommission;
  //       userCommission =
  //           getUserCommission == "" ? 0.0 : getUserCommission + userCommission!;

  //       firebaseDatabaseController.createUserTransaction(
  //           userId: verifiedInvoiceData.shopBusinessRepId,
  //           vendorId: verifiedInvoiceData.userId,
  //           shopId: verifiedInvoiceData.shopId,
  //           amount: userCommission,
  //           invoiceId: verifiedInvoiceData.id,
  //           entryType: "Credit",
  //           walletType: "User First Month Commission");
  //     }
  //   }

  //   firebaseDatabaseController.createUserTransaction(
  //       vendorId: verifiedInvoiceData.userId,
  //       shopId: verifiedInvoiceData.shopId,
  //       amount: vendorBalance,
  //       invoiceId: verifiedInvoiceData.id,
  //       entryType: "Credit",
  //       walletType: "Shop Due Amount");
  // }

  double calculatePercentage(numA, numB) {
    double percentage = (numA / 100) * numB;
    return percentage;
  }

  RxDouble progress = 0.0.obs;
  RxInt listCount = 0.obs;
  RxInt count = 0.obs;
  void updateProgress(double value) {
    log(progress.value.toString());
    count.value = count.value + 1;
    progress.value = value;
    update();
  }
}
