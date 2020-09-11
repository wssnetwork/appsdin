import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:appsdin/model/form.dart';

class FormController {
  static const String URL =
      "https://script.google.com/macros/s/AKfycbx0Q-E-k2WA01Gg1wT0zZ3d_Ej9enjc8jiKb_ha7PitmD07WVSX/exec";
  static const STATUS_SUCCESS = "Berjaya";

  void submitForm(FormUpdate formUpdate, void Function(String) callback) async {
    try {
      await http.post(URL, body: formUpdate.toJson()).then((response) async {
        if (response.statusCode == 302) {
          var url = response.headers['location'];
          await http.get(url).then((response) {
            callback(convert.jsonDecode(response.body)['status']);
          });
        } else {
          callback(convert.jsonDecode(response.body)['status']);
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
