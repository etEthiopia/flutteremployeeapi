import 'package:flutter/material.dart';
import 'package:rest/components/search_default.dart';
import 'package:rest/theme/colors.dart';

class SearchEmp extends StatefulWidget {
  @override
  _SearchEmpState createState() => _SearchEmpState();
}

class _SearchEmpState extends State<SearchEmp> {
  final TextEditingController _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // bool por = true;
    // Orientation orientation = MediaQuery.of(context).orientation;
    // if (orientation == Orientation.landscape) {
    //   setState(() {
    //     por = false;
    //   });
    // }

    Widget _searchPrompt() {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          color: darkGreyColor.withOpacity(0.8),
          elevation: 0.0,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(
                    color: primary, width: 2, style: BorderStyle.solid)),
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
            child: TextFormField(
              decoration: InputDecoration(
                  hintText: "Search by ID",
                  hintStyle: TextStyle(color: light),
                  icon: Icon(
                    Icons.search,
                    color: dark,
                  ),
                  border: InputBorder.none,
                  isDense: true),
              keyboardType: TextInputType.text,
              controller: _textController,
              validator: (value) {
                if (value.isEmpty) {
                  return "The Search cannot be empty";
                }
                return null;
              },
            ),
          ),
        ),
      );
    }

    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            child: _searchPrompt(),
          ),
          Expanded(
              child: _textController.text.length == 0
                  ? searchDefault(context)
                  : Text("Search", style: TextStyle(color: Colors.white)))
        ],
      ),
    );
  }
}
