import 'package:hive/hive.dart';
import 'package:listonic_clone/database/lists.dart';
import 'package:listonic_clone/model/product.dart';

import 'populars.dart';

class Boxes {
  static Box<Product> getPopulars() => Hive.box<Product>('$Populars.boxName');

  static Box<Product> getLists() => Hive.box<Product>('$ListonicList.boxName');
}
