import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';

class MyListsWindow extends StatefulWidget {
  const MyListsWindow({Key? key}) : super(key: key);

  @override
  State<MyListsWindow> createState() => _MyListsWindowState();
}

class _MyListsWindowState extends State<MyListsWindow> {
  @override
  Widget build(BuildContext context) {
    return const Expanded(
        child: Align(
            child: Center(
      child: Text("My Lists"),
    )));
  }
}
