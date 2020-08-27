import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:rest/models/employee.dart';

class APIProvider {
  static Future<List<Employee>> fetch() async {
    try {
      var res = await http
          .get("http://dummy.restapiexample.com/api/v1/employees")
          .timeout(Duration(seconds: 20));
      if (res.statusCode == 200) {
        if (res.body != null) {
          if (json.decode(res.body)['status'] == 'success') {
            List<Employee> emps =
                Employee.generateEmployeeList(json.decode(res.body)['data']);
            return emps;
          } else {
            print("unsuccessful");
            throw Exception("unsuccessful");
          }
        } else {
          print("res-body is null");
          throw Exception("res-body is null");
        }
      } else {
        print("res-code: " + res.statusCode.toString());
        throw Exception("res-code: " + res.statusCode.toString());
      }
    } on SocketException {
      print('Internet Error');
      throw Exception("Check Your Connection");
    }
  }
}
