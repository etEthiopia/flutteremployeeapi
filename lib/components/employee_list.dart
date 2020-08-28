import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rest/models/employee.dart';
import 'package:rest/theme/colors.dart';
import 'package:rest/theme/font.dart';

Widget employeeList({Employee e}) {
  return Container(
    height: 100,
    margin: EdgeInsets.all(10),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(boxShadow: [
      BoxShadow(
        color: darksecond,
        offset: const Offset(0.0, 3.0),
        blurRadius: 5.0,
        spreadRadius: 2.0,
      ),
    ], color: primary, borderRadius: BorderRadius.circular(10)),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    //color: Colors.green,

                    borderRadius: BorderRadius.all(
                  Radius.circular(5),
                )),
                child: loadimage(e.image),
              ),
              Text(
                "ID:  ${e.id}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.white, fontSize: 15, fontFamily: defaultFont),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "${e.name}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      fontFamily: defaultFont),
                ),
                Divider(
                  color: Colors.white,
                  thickness: 1,
                ),
                Text(
                  "Sal: ${e.salary} ETB",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: defaultFont),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "Age: ",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: defaultFont),
                    ),
                    Text(
                      "${e.age}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: defaultFont),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Column(
          children: <Widget>[
            Expanded(
                child: Container(
                    padding: const EdgeInsets.all(5.0),
                    decoration: new BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 13,
                    ))),
            Expanded(
                child: Container(
                    padding: const EdgeInsets.all(5.0),
                    decoration: new BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 13,
                    ))),
          ],
        )
      ],
    ),
  );
}

Widget _error(BuildContext context, String url, dynamic error) {
  print(error);
  return Container(
    padding: EdgeInsets.all(5),
    decoration: BoxDecoration(boxShadow: [
      BoxShadow(
        color: darksecond,
      ),
    ], color: darkGreyColor, borderRadius: BorderRadius.circular(10)),
    child: Image.asset('assets/person.png'),
  );
  ;
}

Widget _progress(BuildContext context, String url, dynamic downloadProgress) {
  return Center(
      child: CircularProgressIndicator(value: downloadProgress.progress));
}

Widget loadimage(String image) {
  return CachedNetworkImage(
    imageUrl: '$image',
    progressIndicatorBuilder: _progress,
    errorWidget: _error,
  );
}
