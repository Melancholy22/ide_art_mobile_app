import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';

class DropdownButton1 extends StatefulWidget {
  
  final List<String> list;

  String _dropdownValue = "";

  DropdownButton1({super.key, required this.list});

  @override
  State<DropdownButton1> createState() => _DropdownButton1State(list);
  
  callBack(String drop) {
    _dropdownValue = drop;
  }

  getDrop() {
    safePrint(_dropdownValue);
    return _dropdownValue;
  }
}

class _DropdownButton1State extends State<DropdownButton1> {
  static List<String> list = [];
  static String dropdownValue = list.first;

  _DropdownButton1State(List<String> l) {
    list = l;
    dropdownValue = list.first;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
        widget.callBack(value!);
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}