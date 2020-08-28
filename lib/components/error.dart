import 'package:flutter/material.dart';
import 'package:rest/theme/colors.dart';
import 'package:rest/theme/font.dart';

Widget showerror(var context, String route, String error) {
  return Container(
    child: Column(
      children: [
        Expanded(
          child: Center(
            child: Text(
              error,
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: Material(
                  color: dark,
                  borderRadius: BorderRadius.circular(15.0),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/$route');
                    },
                    child: Text(
                      "Retry",
                      style: TextStyle(
                          color: Colors.white, fontFamily: defaultFont),
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    ),
  );
}
