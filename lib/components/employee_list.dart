import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rest/models/employee.dart';
import 'package:rest/theme/colors.dart';
import 'package:rest/theme/font.dart';

Widget employeeList({Employee e}) {
  return Container(
    margin: EdgeInsets.all(10),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(boxShadow: [
      BoxShadow(
        color: Colors.grey[300],
        offset: const Offset(3.0, 3.0),
        blurRadius: 5.0,
        spreadRadius: 2.0,
      ),
    ], color: Colors.white, borderRadius: BorderRadius.circular(15)),
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
                    color: dark, fontSize: 15, fontFamily: defaultFont),
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
                      color: dark, fontSize: 17, fontFamily: defaultFont),
                ),
                Divider(
                  color: Colors.grey[300],
                  height: 10,
                ),
                Text(
                  "Sal: ${e.salary} ETB",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: primary, fontSize: 12, fontFamily: defaultFont),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "Age: ",
                      style: TextStyle(
                          color: primary,
                          fontSize: 12,
                          fontFamily: defaultFont),
                    ),
                    Text(
                      "${e.age}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: dark, fontSize: 12, fontFamily: defaultFont),
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
                      border: Border.all(color: dark),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.edit,
                      color: dark,
                      size: 13,
                    ))),
            Expanded(
                child: Container(
                    padding: const EdgeInsets.all(5.0),
                    decoration: new BoxDecoration(
                      border: Border.all(color: dark),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.delete,
                      color: dark,
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
  return const Center(child: Icon(Icons.error));
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
