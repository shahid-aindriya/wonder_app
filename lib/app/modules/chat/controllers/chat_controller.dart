import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  //TODO: Implement ChatController

  final count = 0.obs;

  void increment() => count.value++;

  getData() async {
    // final data = await FirebaseFirestore.instance
    //     .collection('chat_with_wonder_friend')
    //     .get();
    // log(data.docs.toString());

    List<Map<String, dynamic>> documentsList = [];

// Replace 'yourCollection' and 'yourDocumentID' with your actual collection and document ID
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await FirebaseFirestore.instance
            .collection('chat_with_wonder_friend')
            .doc('1')
            .get();

    if (documentSnapshot.exists) {
      Map<String, dynamic>? data = documentSnapshot.data();
      documentsList.add(data!);
    } else {
      print('Document with ID "1" does not exist.');
    }
  }
}
