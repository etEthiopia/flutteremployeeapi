import 'package:flutter/material.dart';
import 'package:rest/components/error.dart';
import 'package:rest/components/loading.dart';
import 'package:rest/models/employee.dart';
import 'package:rest/screens/gridBuilder.dart';
import 'package:rest/screens/listBuilder.dart';
import 'package:rest/service/api_provider.dart';
import 'package:rest/theme/colors.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Employee> fetched;
  bool grid = true;
  int page = 0;
  String error = "";

  void _onItemTapped(int index) {
    setState(() {
      page = index;
    });
  }

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  _asyncMethod() async {
    setState(() {
      fetched = null;
    });
    APIProvider.fetch()
        .then((value) => {
              setState(() {
                fetched = value;
                error = "";
              })
            })
        .catchError((e) => {
              setState(() {
                error = e.message.toString();
              })
            });
  }

  @override
  Widget build(BuildContext context) {
    Widget create(bool por) {
      if (por) {
        return Container(
          color: primary,
          child: Text(""),
          width: double.maxFinite,
          height: 150,
        );
      }
      return Container(
        color: primary,
        child: Text(""),
        width: 150,
        height: double.maxFinite,
      );
    }

    Widget employees(bool por) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () async {
                    _asyncMethod();
                  },
                  child: Icon(
                    Icons.refresh,
                    color: primary,
                    size: 30,
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            grid = false;
                          });
                        },
                        child: Icon(
                          Icons.list,
                          color: grid ? extralight : primary,
                          size: 30,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            grid = true;
                          });
                        },
                        child: Icon(
                          Icons.grid_on,
                          color: grid ? primary : extralight,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            error.length < 1
                ? fetched != null
                    ? Expanded(
                        child: grid
                            ? gridBuilder(context, por, fetched)
                            : listBuilder(context, fetched),
                      )
                    : Expanded(child: loading(context))
                : Expanded(child: showerror(context, '', error))
          ],
        ),
      );
    }

    Widget layout() {
      bool por = true;
      Orientation orientation = MediaQuery.of(context).orientation;
      if (orientation == Orientation.landscape) {
        por = false;
      }

      if (por) {
        return Column(
          children: [
            create(por),
            Expanded(
              child: page == 0 ? employees(por) : Text("Search"),
            )
          ],
        );
      }
      return Row(
        children: [
          create(por),
          Expanded(
            child: page == 0 ? employees(por) : Text("Search"),
          )
        ],
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Container(child: layout()),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.group), title: Text("")),
          BottomNavigationBarItem(icon: Icon(Icons.search), title: Text("")),
        ],
        currentIndex: page,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
