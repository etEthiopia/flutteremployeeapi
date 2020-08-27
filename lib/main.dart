import 'package:flutter/material.dart';
import 'package:rest/screens/myapp.dart';

void main() {
  runApp(StartAPP());
}

class StartAPP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'REST',
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => MyApp(),
        });
  }
}
