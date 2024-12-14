import 'package:flutter/material.dart';

void main(List<String> args) => runApp(home());

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  items(String address, String imageName, String detail) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: ListTile(
        leading: GestureDetector(
            onTap: () {
              setState(() {
                Navigator.pushNamed(context, "$address");
              });
            },
            child: Image.asset("$imageName")),
        subtitle: Text("Click on image to open the new page \n $detail"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Project"),
        ),
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              items("file", "first.jpg", "this is about file read and write with files "),
              items("pers", "second.jpg", "this is about share preferences"),
              items("sql", "third.jpg", "this is about sqlite by this you can storage files for easy"),
            ],
          ),
        ),
      ),
    );
  }
}
