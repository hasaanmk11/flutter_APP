import 'package:flutter/material.dart';

class UserInfo extends StatelessWidget {
  String name;
  String age;
  String img;

  UserInfo({required this.name, required this.age,required this.img});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        backgroundColor: Colors.blueAccent,

        actions: [
          Padding(padding: const EdgeInsets.only(right: 30), child: Text(age)),
        ],
      ),
      body: SafeArea(child: Column(children: [Container(
        child: Image.network(img),
      )])),
    );
  }
}
