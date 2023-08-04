import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'package:wonder_app/app/modules/invoice/controllers/invoice_controller.dart';
import 'package:wonder_app/app/modules/invoice/model/verified_model.dart';
import 'package:wonder_app/app/modules/invoice/views/invoice_view.dart';

import '../../../data/urls.dart';
import 'package:http/http.dart' as http;

import '../widgets/firebase_database_controller.dart';


final InvoicePaymentController invoicePaymentController =
    Get.put(InvoicePaymentController());
class InvoicePaymentController extends GetxController {

  FirebaseDatabaseController firebaseDatabaseController = FirebaseDatabaseController();
  InvoiceController invoiceController = InvoiceController();
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
  double? getUserCommission;
  bool isSuccess = true;
 
  bulkApproval(RxList<VerifiedInvoiceData> verifiedList) async{

    expiryDays          =   await firebaseDatabaseController.getExpireDays();
    DateTime today      =   DateTime.now();
    DateTime expiryDate =   today.add(Duration(days: expiryDays as int));

   

    shopId              =   verifiedList[0].shopId;
    Map<dynamic, dynamic> shopValues = await firebaseDatabaseController.shopData(shopId);

    if (shopValues != null) {
      String walletAmount       =   shopValues["wallet_amount"];
      double convertAmount      =   double.parse(walletAmount);
      String roundWalletAmount  =   convertAmount.toStringAsFixed(2);
      shopWalletAmount          =   double.parse(roundWalletAmount);
    }
    
    for(var verifiedData in verifiedList){

      if(verifiedData.payHalfAmount == true && verifiedData.bulkApproveStatus == false){

        vendorId            =   verifiedData.userId;
        shopCommission      =   verifiedData.shopCommission;
        shopHalfCommission  =   50;
        customerId          =   verifiedData.customerId;
      
        preTaxAmount        =   verifiedData.preTaxAmount;
        invoiceAmount       =   double.parse(preTaxAmount.toString());

        if(verifiedData.isImport == true){

          commissionAmount  =   invoiceAmount;

        }else{

          commissionAmount  =   calculatePercentage(shopCommission, invoiceAmount);

        }

        vendorCommission    =   calculatePercentage(shopHalfCommission, commissionAmount);
        vendorBalance       =   calculatePercentage(shopHalfCommission, commissionAmount);
        getBalanceAmount    =   commissionAmount;
        walletType          =   "Direct";

        if(shopWalletAmount! >= vendorCommission!){

          Map<dynamic, dynamic> userData = await firebaseDatabaseController.userData(customerId);

          for (int i = 1; i <= 15; i++) {

            String parent       =   "p$i";
            parentId            =   userData[parent];

            // ignore: unrelated_type_equality_checks
            if(parentId != 0)
            {
              levelPercentsge   =   await firebaseDatabaseController.levelPercentsge(i+1);
              userCommission    =   calculatePercentage(levelPercentsge, commissionAmount);
              balanceAmount     =   getBalanceAmount! - userCommission!;
              getBalanceAmount  =   balanceAmount;

              //*************** user wallet transaction
              firebaseDatabaseController.walletTransaction(
                userId: parentId,
                vendorId: vendorId,
                shopId: shopId,
                amount:userCommission,
                invoiceId: verifiedData.id,
                entryType: "Credit",
                walletType: walletType,
                expiryDate: expiryDate.toString(),
                status: "Approve"
              );

              //*************** shop wallet transaction
              firebaseDatabaseController.shopWalletTransaction(
                userId: parentId,
                vendorId: vendorId,
                shopId: shopId,
                amount:userCommission,
                invoiceId: verifiedData.id,
                entryType: "Debit",
                walletType: walletType,
                expiryDate: expiryDate.toString()
              );
            }
          }

          if(getBalanceAmount! > 0){
            firebaseDatabaseController.walletTransaction(
              userId: 1,
              vendorId: vendorId,
              shopId: shopId,
              amount:userCommission,
              invoiceId: verifiedData.id,
              entryType: "Credit",
              walletType: walletType
            );
          }
          updateUserRoleCommissionAndShopBalance(verifiedInvoiceData: verifiedData,vendorBalance: vendorBalance);
          invoiceController.updateInvoiceBulkStatus(verifiedData.id);
        }
        else{
          Get.snackbar("Error", "Insufficiant Balance",
              backgroundColor: Colors.red);

          break;
        }

        
      }else{
        Get.snackbar("Error", "Pay invoice amount",
            backgroundColor: Colors.red);

        isSuccess = false; // Set the flag to false since bulk approval failed
        break; 
      }
    }

    if(isSuccess) {
    // The loop is finished, and bulk approval was successful, show the success message.
      Get.snackbar("Info ", "Success", backgroundColor: Colors.green);
    }

    return;
  }


  updateUserRoleCommissionAndShopBalance({
    required VerifiedInvoiceData verifiedInvoiceData,vendorBalance
  }) async{

    shopId              =   verifiedInvoiceData.shopId;
    invoiceAmount       =   double.parse(verifiedInvoiceData.preTaxAmount.toString()) ;
    vendorId            =   verifiedInvoiceData.userId;
    userCommission      =   0.0;

    Map<dynamic, dynamic> settingsValues = await firebaseDatabaseController.settingsData();

    if (settingsValues != null) {
      String getfirstMonthCommission      =   settingsValues["field_visit_commission"];
      double convertFirstMonthCommission  =   double.parse(getfirstMonthCommission);
      String roundFirstMonthCommission    =   convertFirstMonthCommission.toStringAsFixed(2);
      firstMonthCommission                =   double.parse(roundFirstMonthCommission);

      String getfieldVisitCommission      =   settingsValues["field_visit_commission"];
      double convertFieldVisitCommission  =   double.parse(getfieldVisitCommission);
      String roundfieldVisitCommission    =   convertFieldVisitCommission.toStringAsFixed(2);
      fieldVisitCommission                =   double.parse(roundfieldVisitCommission);

    }

    if(verifiedInvoiceData.addedByCommission != null){
      if(verifiedInvoiceData.fieldVisitCommission == true){

        userCommission    =   calculatePercentage(fieldVisitCommission, invoiceAmount);
        getUserCommission =   verifiedInvoiceData.addedByCommission;
        userCommission    =   getUserCommission! + userCommission!;

        firebaseDatabaseController.createUserTransaction(
          userId: verifiedInvoiceData.shopAddedBy,
          vendorId: verifiedInvoiceData.userId,
          shopId: verifiedInvoiceData.shopId,
          amount: userCommission,
          invoiceId: verifiedInvoiceData.id,
          entryType: "Credit",
          walletType: "User Field Visit Commission"
        );

      }else{

        userCommission    =   calculatePercentage(firstMonthCommission, invoiceAmount);
        getUserCommission =   verifiedInvoiceData.addedByCommission;
        userCommission    =   getUserCommission! + userCommission!;

        firebaseDatabaseController.createUserTransaction(
          userId: verifiedInvoiceData.shopAddedBy,
          vendorId: verifiedInvoiceData.userId,
          shopId: verifiedInvoiceData.shopId,
          amount: userCommission,
          invoiceId: verifiedInvoiceData.id,
          entryType: "Credit",
          walletType: "User Field Visit Commission"
        );
      }
    }

    if(verifiedInvoiceData.shopBusinessRepId != null){
      DateTime now          = DateTime.now();
      DateTime oneMonthAgo  = now.subtract(Duration(days: 30));

      if(verifiedInvoiceData.shopCreatedAt > oneMonthAgo){
        userCommission      = calculatePercentage(firstMonthCommission, invoiceAmount);
        getUserCommission   = verifiedInvoiceData.businessRepCommission;
        userCommission      = getUserCommission! + userCommission!;

        firebaseDatabaseController.createUserTransaction(
          userId: verifiedInvoiceData.shopBusinessRepId,
          vendorId: verifiedInvoiceData.userId,
          shopId: verifiedInvoiceData.shopId,
          amount: userCommission,
          invoiceId: verifiedInvoiceData.id,
          entryType: "Credit",
          walletType: "User First Month Commission"
        );
     
      }
    }

    firebaseDatabaseController.createUserTransaction(
      vendorId: verifiedInvoiceData.userId,
      shopId: verifiedInvoiceData.shopId,
      amount: vendorBalance,
      invoiceId: verifiedInvoiceData.id,
      entryType: "Credit",
      walletType: "Shop Due Amount"
    );
  }

  double calculatePercentage(numA, numB) {
    double percentage = (numA / 100) * numB;
    return percentage;
  }
}
