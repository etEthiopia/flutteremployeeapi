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
  bool grid;
  int page = 0;
  String error = "";

  void _onItemTapped(int index) {
    setState(() {
      page = index;
    });
  }

  @override
  initState() {
    setState(() {
      fetched = APIProvider.fetch() as List<Employee>;
      error = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      error = "";
    });
    Widget create(bool por) {
      if (por) {
        return Container(
          child: Text(""),
          width: double.maxFinite,
          height: 300,
        );
      }
      return Container(
        child: Text(""),
        width: 500,
        height: double.maxFinite,
      );
    }

    Widget employees(bool por) {
      return Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () async {
                    setState(() {
                      try {
                        fetched = null;
                        fetched = APIProvider.fetch() as List<Employee>;
                        error = "";
                      } catch (e) {
                        setState(() {
                          error = e.message.toString();
                        });
                      }
                    });
                  },
                  child: Icon(Icons.refresh, color: primary),
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
                        child: Icon(Icons.list,
                            color: grid ? extralight : primary),
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
                        child: Icon(Icons.grid_on,
                            color: grid ? primary : extralight),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            error == ""
                ? fetched != null
                    ? Expanded(
                        child: grid
                            ? gridBuilder(context, por, fetched)
                            : listBuilder(context, fetched),
                      )
                    : loading(context)
                : showerror(context, '', error)
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
        child: Container(
          child: Column(
            children: [],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
          ),
        ],
        currentIndex: page,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
