import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rest/models/employee.dart';

class APIProvider {
  static Future<List<Employee>> fetch() async {
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
          throw Exception("unsuccessful");
        }
      } else {
        throw Exception("res-body is null");
      }
    } else {
      throw Exception("res-code: " + res.statusCode.toString());
    }
  }
}
