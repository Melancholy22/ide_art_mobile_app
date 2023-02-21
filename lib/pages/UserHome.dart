import 'package:flutter/material.dart';

class UserHome extends StatelessWidget {
  const UserHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Color.fromRGBO(113, 203, 255, 100),
        elevation: 0,
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            'ideArt',
            style: TextStyle(color: Colors.white),
          ),
          Row(
            children: [Icon(Icons.density_medium)],
          )
        ]),
      ),
      body: Center(child: Text('Home')),
    );
  }
}
