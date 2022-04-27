import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:listonic_clone/database/populars.dart';
import 'package:listonic_clone/home_page/home_page.dart';
import 'package:listonic_clone/model/product.dart';

import 'model/listonic_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(ListonicListAdapter());

  await Hive.openBox<Product>('$Populars.boxName');
  await Hive.openBox<ListonicList>('$ListonicList.boxName');

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
      home: const HomePage(title: 'Listonic'),
    );
  }
}
