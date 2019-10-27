import 'package:contacts_app/model/contact.dart';

class Response {
  final List<Contact> contacts;
  final int page;
  final int row;
  final int totalRow;

  Response({this.contacts, this.page, this.row, this.totalRow});

  factory Response.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<Contact> data = list.map((model) => Contact.fromJson(model)).toList();
    return Response(
      contacts: data,
      page: json['page'],
      row: json['row'],
      totalRow: json['total_row'],
    );
  }
}
