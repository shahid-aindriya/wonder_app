import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:wonder_app/app/data/urls.dart';

import '../model/terms_condition_model.dart';

class TermsConditionsController extends GetxController {
  //TODO: Implement TermsConditionsController

  final count = 0.obs;

  void increment() => count.value++;
  RxList<Terms> termsList = <Terms>[].obs;
  Future<RxList<Terms>?> getTermsAndCondtions() async {
    // try {

    var request = await http.get(
        Uri.parse("http://64.227.156.53:8000/terms-and-conditions/"),
        headers: headers);

    log(request.statusCode.toString());
    if (request.statusCode == 201) {
      final termsConditions = termsConditionsFromJson(request.body);
      termsList.assign(termsConditions.terms);
      return termsList;
    }
    return null;
    // } catch (e) {
    //   log(e.toString());
    // }
  }
}
