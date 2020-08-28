import 'package:flutter/material.dart';
import 'package:rest/components/error.dart';
import 'package:rest/components/loading.dart';
import 'package:rest/models/employee.dart';
import 'package:rest/screens/gridBuilder.dart';
import 'package:rest/screens/listBuilder.dart';
import 'package:rest/screens/searchEmp.dart';
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
    print("index: " + index.toString());
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
    bool por = true;
    Orientation orientation = MediaQuery.of(context).orientation;
    if (orientation == Orientation.landscape) {
      por = false;
    }

    Widget fab() {
      print(por);
      return Container(
        margin: por
            ? EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height - 220,
                right: MediaQuery.of(context).size.width / 2 - 40)
            : EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height / 2 - 55,
                right: MediaQuery.of(context).size.width - 190),
        child: FloatingActionButton(
          onPressed: () {},
          elevation: 1.0,
          foregroundColor: Colors.white,
          backgroundColor: primary,
          child: Icon(
            Icons.add,
            size: 30,
          ),
        ),
      );
    }

    Widget tabs() {
      if (por) {
        return Container(
          height: 50,
          padding: EdgeInsets.only(top: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: InkWell(
                  child: Column(
                    children: [
                      Icon(
                        Icons.group,
                        color: page == 0 ? dark : Colors.black,
                      ),
                      Divider(
                        thickness: 2,
                        color: page == 0 ? dark : Colors.transparent,
                      )
                    ],
                  ),
                  onTap: () {
                    _onItemTapped(0);
                  },
                ),
              ),
              Expanded(
                child: InkWell(
                  child: Column(
                    children: [
                      Icon(
                        Icons.search,
                        color: page == 1 ? dark : Colors.black,
                      ),
                      Divider(
                        thickness: 2,
                        color: page == 1 ? dark : Colors.transparent,
                      )
                    ],
                  ),
                  onTap: () {
                    _onItemTapped(1);
                  },
                ),
              )
            ],
            // labelColor: primary,
            // unselectedLabelColor: extralight,
            // indicatorColor: Colors.transparent,
            // onTap: (value) => _onItemTapped(value),
            // controller: tabController,
          ),
        );
      }
      return Container(
        padding: EdgeInsets.only(left: 5),
        child: Column(
          children: [
            Expanded(
              child: InkWell(
                child: Row(
                  children: [
                    Icon(
                      Icons.group,
                      color: page == 0 ? dark : Colors.black,
                    ),
                    VerticalDivider(
                      thickness: 2,
                      color: page == 0 ? dark : Colors.transparent,
                    )
                  ],
                ),
                onTap: () {
                  _onItemTapped(0);
                },
              ),
            ),
            Expanded(
              child: InkWell(
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: page == 1 ? dark : Colors.black,
                    ),
                    VerticalDivider(
                      thickness: 2,
                      color: page == 1 ? dark : Colors.transparent,
                    )
                  ],
                ),
                onTap: () {
                  _onItemTapped(1);
                },
              ),
            )
          ],
          // labelColor: primary,
          // unselectedLabelColor: extralight,
          // indicatorColor: Colors.transparent,
          // onTap: (value) => _onItemTapped(value),
          // controller: tabController,
        ),
      );
    }

    Widget create() {
      if (por) {
        return Container(
          child: Column(
            children: [
              tabs(),
              Expanded(
                  child: Center(
                child: Container(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    "HRM",
                    style: TextStyle(color: darksecond, fontSize: 30),
                  ),
                ),
              )),
            ],
          ),
          alignment: Alignment.topCenter,
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)),
          ),
          height: 150,
        );
      }
      return Container(
        child: Row(
          children: [
            tabs(),
            Expanded(
                child: Center(
              child: Container(
                padding: EdgeInsets.only(right: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "H",
                      style: TextStyle(color: darksecond, fontSize: 30),
                    ),
                    Text(
                      "R",
                      style: TextStyle(color: darksecond, fontSize: 30),
                    ),
                    Text(
                      "M",
                      style: TextStyle(color: darksecond, fontSize: 30),
                    ),
                  ],
                ),
              ),
            )),
          ],
        ),
        width: 150,
        height: double.maxFinite,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), bottomRight: Radius.circular(30)),
        ),
      );
    }

    Widget employees() {
      if (por) {
        return Container(
          padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
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
      return Container(
        padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
        child: Row(
          children: [
            Column(
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
                  child: Column(
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
      if (por) {
        return Column(
          children: [
            create(),
            Expanded(
              child: page == 0 ? employees() : SearchEmp(),
            )
          ],
        );
      }
      return Row(
        children: [
          create(),
          Expanded(
            child: page == 0 ? employees() : SearchEmp(),
          )
        ],
      );
    }

    return Scaffold(
      backgroundColor: darkGreyColor,
      body: SafeArea(
        child: Container(child: layout()),
      ),
      floatingActionButton: fab(),
    );
  }
}
