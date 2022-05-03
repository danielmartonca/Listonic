import 'dart:async';

import 'package:hive/hive.dart';
import 'package:listonic_clone/model/product.dart';

import 'package:logger/logger.dart';

import 'boxes.dart';

class Products {
  static final _log = Logger(printer: PrettyPrinter());
  static const String boxName = "productsBox";

  static Future<List<Product>> getProducts() async {
    Box box = await ListonicBoxes.getProducts();
    var _productsList = box.values.toList(growable: false).cast<Product>();
    _log.i("Got list of products from database: \n${_productsList.toString()}");
    return _productsList;
  }

  static Future<bool> addToProducts(Product dbEntry) async {
    try {
      Box box = await ListonicBoxes.getProducts();
      box.put(dbEntry.name, dbEntry);
      _log.i("Added ${dbEntry.toString()}to '$boxName'.");
      return true;
    } catch (e) {
      _log.e(e);
      return false;
    }
  }

  static Future<void> updateProduct(String oldKey, Product product) async {
    Box box = await ListonicBoxes.getProducts();
    box.delete(oldKey);
    box.put(product.name, product);
    _log.i("Updated product '\n${product.name}' to ${product.toString()}.");
  }
  static Future<void> deleteProduct(String oldKey ) async {
    Box box = await ListonicBoxes.getProducts();
    box.delete(oldKey);
    _log.i("Deleted product by key(name) '$oldKey'");
  }
}
