import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService extends GetxController {
  final _baseUrl = "http://64.227.178.175:8000/".obs;
  final _headers = {"Content-Type": "application/json"}.obs;

  Future<dynamic> get(String endpoint) async {
    var response =
        await http.get(Uri.parse(_baseUrl.value + endpoint), headers: _headers);
    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  post(String endpoint, dynamic body) async {
    try {
      var response = await http.post(Uri.parse(_baseUrl.value + endpoint),
          headers: _headers, body: jsonEncode(body));
      // log(response.body.toString());
      if (response.statusCode == 201) {
        return response.body;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<dynamic> put(String endpoint, dynamic body) async {
    var response = await http.put(Uri.parse(_baseUrl.value + endpoint),
        headers: _headers, body: jsonEncode(body));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<dynamic> delete(String endpoint) async {
    var response = await http.delete(Uri.parse(_baseUrl.value + endpoint),
        headers: _headers);
    if (response.statusCode == 204) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
