import 'package:hive/hive.dart';
import 'package:listonic_clone/database/lists.dart';
import 'package:listonic_clone/model/product.dart';
import 'package:logger/logger.dart';

import '../model/listonic_list.dart';
import 'products.dart';

final log = Logger(printer: PrettyPrinter(), output: ConsoleOutput());

class ListonicBoxes {
  static var created = false;

  static Future<Box<Product>> getProducts() async {
    if (created == false) {
      await Hive.openBox<Product>(Products.boxName);
      await Hive.openBox<ListonicList>(ListonicLists.boxName);
      created = true;
    }
    return Hive.box<Product>(Products.boxName);
  }

  static Future<Box<ListonicList>> getLists() async {
    if (created == false) {
      await Hive.openBox<Product>(Products.boxName);
      await Hive.openBox<ListonicList>(ListonicLists.boxName);
      created = true;
    }
    return Hive.box<ListonicList>(ListonicLists.boxName);
  }

  static void clearBoxes() {
    getProducts().then((value) => value.clear());
    getLists().then((value) => value.clear());
    log.wtf("Cleared boxes.");
  }
}
