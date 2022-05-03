import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:listonic_clone/model/product.dart';
import 'package:listonic_clone/view/home.dart';
import 'package:logger/logger.dart';

import 'model/listonic_list.dart';

final log = Logger(printer: PrettyPrinter(), output: ConsoleOutput());

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(ListonicListAdapter());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Listonic',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const HomeWindow(title: 'Listonic'),
    );
  }
}
