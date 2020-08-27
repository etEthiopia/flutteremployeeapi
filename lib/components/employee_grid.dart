import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rest/models/employee.dart';
import 'package:rest/theme/colors.dart';

Widget employeeGrid({Employee e}) {
  return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[300],
            offset: const Offset(3.0, 3.0),
            blurRadius: 5.0,
            spreadRadius: 2.0,
          ),
        ],
      ),
      child: Hero(
          tag: e.name + e.id.toString(),
          child: Material(
              borderRadius: BorderRadius.circular(15),
              child: InkWell(
                  onTap: () {},
                  child: GridTile(
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: loadimage(e.image)),
                    footer: Container(
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15)),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            e.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 15,
                                color: darksecond,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            e.salary.toString() + " ETB",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: darksecond),
                          ),
                        ],
                      ),
                    ),
                  )))));
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
