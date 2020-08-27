import 'package:flutter/material.dart';
import 'package:rest/components/employee_list.dart';
import 'package:rest/models/employee.dart';

Widget listBuilder(var context, List<Employee> emps) {
  print("emps: " + emps.length.toString());
  return ListView.builder(
      itemCount: emps.length,
      itemBuilder: (BuildContext context, int index) {
        return employeeList(e: emps[index]);
      });
}
