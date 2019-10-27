import 'dart:convert';

import 'package:http/http.dart' as http;

import 'model/response.dart';

const baseUrl = "https://mock-rest-api-server.herokuapp.com/api/v1";

class API {
  static Future<Response> fetchContacts(int pageNumber, int row) async {
      final url = baseUrl + "/user?page=$pageNumber&row=$row";
      var response = await http.get(url);


      if (response.statusCode == 200) {
        return Response.fromJson(json.decode(response.body));
      } else {
        // If that response was not OK, throw an error.
        throw Exception('Failed to load contact');
      }
    }
}
