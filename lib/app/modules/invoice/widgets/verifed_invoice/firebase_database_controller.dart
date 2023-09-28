import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

final FirebaseDatabaseController firebaseDatabaseController =
    Get.put(FirebaseDatabaseController());

class FirebaseDatabaseController extends GetxController {
  // String dataBaseUrl = 'https://wonderapp-73f65-default-rtdb.asia-southeast1.firebasedatabase.app';

  // *********Test
  String dataBaseUrl =
      'https://wonderapptest-c9a28-default-rtdb.asia-southeast1.firebasedatabase.app';

// *********************************************ExpireDays
  Future<int?> getExpireDays() async {
    await Firebase.initializeApp();
    final firebaseApp = Firebase.app();
    final rtdb = FirebaseDatabase.instanceFor(
      app: firebaseApp,
      databaseURL: dataBaseUrl,
    );

    final rtdbRef = rtdb.ref().child("settings_tb/1");

    Completer<int?> completer = Completer();

    rtdbRef.onValue.listen((event) {
      DataSnapshot snapshot = event.snapshot;
      Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
      if (values != null) {
        String days = values["expiry_days"];
        int convertDays = int.parse(days.toString());
        completer.complete(convertDays);
      } else {
        completer.complete(
            null); // You might want to handle this case based on your requirement.
      }
    });

    return completer.future;
  }

  // *********************************************Shop Data

  Future<Map<dynamic, dynamic>> shopData(shopId) async {
    await Firebase.initializeApp();
    final firebaseApp = Firebase.app();
    final rtdb = FirebaseDatabase.instanceFor(
      app: firebaseApp,
      databaseURL: dataBaseUrl,
    );

    final rtdbRef = rtdb.ref().child("shops_tb/$shopId");
    Completer<Map<dynamic, dynamic>> completer = Completer();

    rtdbRef.onValue.listen((event) {
      DataSnapshot snapshot = event.snapshot;
      Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
      completer.complete(values);
    });
    return completer.future;
  }

  // *********************************************Levels Data

  Future<Map<dynamic, dynamic>> levelsData(id) async {
    await Firebase.initializeApp();
    final firebaseApp = Firebase.app();
    final rtdb = FirebaseDatabase.instanceFor(
      app: firebaseApp,
      databaseURL: dataBaseUrl,
    );

    final rtdbRef = rtdb.ref().child("levels_tb/$id");
    Completer<Map<dynamic, dynamic>> completer = Completer();

    rtdbRef.onValue.listen((event) {
      DataSnapshot snapshot = event.snapshot;
      Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
      completer.complete(values);
    });
    return completer.future;
  }

  // *********************************************User Data

  // Future<Map<dynamic, dynamic>> userData(userId) async {
  //   await Firebase.initializeApp();
  //   final firebaseApp = Firebase.app();
  //   final rtdb = FirebaseDatabase.instanceFor(
  //     app: firebaseApp,
  //     databaseURL:
  //         'https://wonderapp-73f65-default-rtdb.asia-southeast1.firebasedatabase.app',
  //   );

  //   final rtdbRef = rtdb.ref().child("user_data_tb/userId");
  //   Completer<Map<dynamic, dynamic>> completer = Completer();

  //   rtdbRef.onValue.listen((event) {
  //     DataSnapshot snapshot = event.snapshot;
  //     Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;

  //     print("values================$values");
  //     completer.complete(values);
  //   });
  //   return completer.future;
  // }

  Future<Map<dynamic, dynamic>> userData(userId) async {
    await Firebase.initializeApp();
    final firebaseApp = Firebase.app();
    final rtdb = FirebaseDatabase.instanceFor(
      app: firebaseApp,
      databaseURL: dataBaseUrl,
    );

    final rtdbRef = rtdb.ref().child("user_data_tb/$userId");
    Completer<Map<dynamic, dynamic>> completer = Completer();

    rtdbRef.onValue.listen((event) {
      DataSnapshot snapshot = event.snapshot;

      if (snapshot.value != null && snapshot.value is Map<dynamic, dynamic>) {
        Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
        // print("values================$values");
        completer.complete(values);
      } else {
        print("No data found for user $userId");
        completer.completeError("No data found");
      }
    });

    return completer.future;
  }

  // *********************************************Get level percentage

  Future<double?> levelPercentsge(id) async {
    await Firebase.initializeApp();
    final firebaseApp = Firebase.app();
    final rtdb = FirebaseDatabase.instanceFor(
      app: firebaseApp,
      databaseURL: dataBaseUrl,
    );

    final rtdbRef = rtdb.ref().child("levels_tb/$id");

    Completer<double?> completer = Completer();

    rtdbRef.onValue.listen((event) {
      DataSnapshot snapshot = event.snapshot;
      Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
      if (values != null) {
        String percentage = values["percentage"];
        double levelPercentsge = double.parse(percentage.toString());
        completer.complete(levelPercentsge);
      } else {
        completer.complete(null);
      }
    });

    return completer.future;
  }

  // *********************************************Get settings data

  Future<Map<dynamic, dynamic>> settingsData() async {
    await Firebase.initializeApp();
    final firebaseApp = Firebase.app();
    final rtdb = FirebaseDatabase.instanceFor(
      app: firebaseApp,
      databaseURL: dataBaseUrl,
    );

    final rtdbRef = rtdb.ref().child("settings_tb/1");
    Completer<Map<dynamic, dynamic>> completer = Completer();

    rtdbRef.onValue.listen((event) {
      DataSnapshot snapshot = event.snapshot;
      Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
      completer.complete(values);
    });
    return completer.future;
  }

  // *********************************************Shop Data

  Future<Map<dynamic, dynamic>> offlineCommissionData(roleId) async {
    await Firebase.initializeApp();
    final firebaseApp = Firebase.app();
    final rtdb = FirebaseDatabase.instanceFor(
      app: firebaseApp,
      databaseURL: dataBaseUrl,
    );

    final rtdbRef = rtdb.ref().child("offline_commission_settings_tb/$roleId");
    Completer<Map<dynamic, dynamic>> completer = Completer();

    rtdbRef.onValue.listen((event) {
      DataSnapshot snapshot = event.snapshot;
      Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
      completer.complete(values);
    });
    return completer.future;
  }

  // *********************************************Create user wallet transaction data

  walletTransaction(
      {userId,
      vendorId,
      shopId,
      amount,
      invoiceId,
      entryType,
      expiryDate,
      walletType,
      status}) async {
    await Firebase.initializeApp();
    final firebaseApp = Firebase.app();
    final rtdb = FirebaseDatabase.instanceFor(
      app: firebaseApp,
      databaseURL: dataBaseUrl,
    );

    final rtdbRef = rtdb.ref().child("wallet_transactions_tb");
    final String now = DateTime.now().toString();

    Map<String, dynamic> data = {
      "user_id": userId,
      "vendor_id": vendorId,
      "shop_id": shopId,
      "amount": amount,
      "invoice_id": invoiceId,
      "entry_type": entryType,
      "expiry_date": expiryDate,
      "wallet_type": walletType,
      "status": status,
      "created_at": now,
      "updated_at": now,
    };

    await rtdbRef.push().set(data);
  }

  // *********************************************Create shop wallet transaction data

  shopWalletTransaction(
      {userId,
      vendorId,
      shopId,
      amount,
      invoiceId,
      entryType,
      expiryDate,
      walletType,
      status}) async {
    await Firebase.initializeApp();
    final firebaseApp = Firebase.app();
    final rtdb = FirebaseDatabase.instanceFor(
      app: firebaseApp,
      databaseURL: dataBaseUrl,
    );

    final rtdbRef = rtdb.ref().child("shop_wallet_transactions_tb");
    final String now = DateTime.now().toString();

    Map<String, dynamic> data = {
      "user_id": userId,
      "vendor_id": vendorId,
      "shop_id": shopId,
      "amount": amount,
      "invoice_id": invoiceId,
      "entry_type": entryType,
      "expiry_date": expiryDate,
      "wallet_type": walletType,
      "status": status,
      "created_at": now,
      "updated_at": now,
    };

    await rtdbRef.push().set(data);
  }

  // *********************************************create user transaction

  createUserTransaction(
      {userId,
      vendorId,
      shopId,
      amount,
      invoiceId,
      entryType,
      expiryDate,
      walletType,
      status}) async {
    await Firebase.initializeApp();
    final firebaseApp = Firebase.app();
    final rtdb = FirebaseDatabase.instanceFor(
      app: firebaseApp,
      databaseURL: dataBaseUrl,
    );

    final rtdbRef = rtdb.ref().child("user_transactions_tb");
    final String now = DateTime.now().toString();

    Map<String, dynamic> data = {
      "user_id": userId,
      "vendor_id": vendorId,
      "shop_id": shopId,
      "amount": amount,
      "invoice_id": invoiceId,
      "entry_type": entryType,
      "wallet_type": walletType,
      "created_at": now,
      "updated_at": now,
    };

    await rtdbRef.push().set(data);
  }

  createShopTransaction(
      {userId,
      vendorId,
      shopId,
      amount,
      invoiceId,
      entryType,
      expiryDate,
      walletType,
      status}) async {
    await Firebase.initializeApp();
    final firebaseApp = Firebase.app();
    final rtdb = FirebaseDatabase.instanceFor(
      app: firebaseApp,
      databaseURL: dataBaseUrl,
    );

    final rtdbRef = rtdb.ref().child("user_transactions_tb");
    final String now = DateTime.now().toString();

    Map<String, dynamic> data = {
      "user_id": userId,
      "vendor_id": vendorId,
      "shop_id": shopId,
      "amount": amount,
      "invoice_id": invoiceId,
      "entry_type": entryType,
      "wallet_type": walletType,
      "created_at": now,
      "updated_at": now,
    };

    await rtdbRef.push().set(data);
  }
}
