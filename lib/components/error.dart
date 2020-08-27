import 'package:flutter/material.dart';
import 'package:rest/theme/colors.dart';
import 'package:rest/theme/font.dart';

showerror(var context, String route, String error) {
  return Column(
    children: [
      Expanded(
        child: Container(
          color: primary,
          child: Text(error),
        ),
      ),
      Expanded(
        child: Container(
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
                style: TextStyle(color: Colors.white, fontFamily: defaultFont),
              ),
            ),
          ),
        ),
        ),
      )
    ],
  );
}
