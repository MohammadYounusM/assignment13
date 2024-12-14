import 'package:flutter/material.dart';
import 'package:flutter_application_4/homePage.dart';

import 'file.dart';
import 'sharePreferences.dart';
import 'sql.dart';

void main(List<String> args) => runApp(First());

class First extends StatefulWidget {
  const First({super.key});

  @override
  State<First> createState() => _FirstState();
}

class _FirstState extends State<First> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "home",
      routes: {
        "home": (context) => home(),
        "file": (context) => FileApp(),
        "pers": (context) => ShPreference(),
        "sql": (context) => NoteApp()
      },
    );
  }
}
