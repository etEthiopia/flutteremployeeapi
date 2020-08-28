import 'package:flutter/material.dart';
import 'package:rest/components/employee_grid.dart';
import 'package:rest/models/employee.dart';

Widget gridBuilder(var context, bool por, List<Employee> emps) {
  int col = 2;
  if (por == false) {
    col = 3;
  }

  return Container(
    child: GridView.builder(
        itemCount: emps.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: col),
        itemBuilder: (BuildContext context, int index) {
          return employeeGrid(e: emps[index]);
        }),
  );
}
