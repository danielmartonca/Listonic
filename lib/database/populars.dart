import 'dart:async';

import 'package:hive/hive.dart';
import 'package:listonic_clone/model/product.dart';

import 'package:logger/logger.dart';

import 'boxes.dart';

class Populars {
  static final _log = Logger(printer: PrettyPrinter());

  // static final Populars instance = Populars.init();
  // Populars.init();
  static const String boxName = "popularsBox";

  static Box box = Boxes.getPopulars();

  static final Set<Product> popularsList = Set.identity();

  static List<Product> getPopulars() {
    var popularsList = box.values.toList(growable: false).cast<Product>();
    _log.i("Got list of populars from database:${popularsList.toString()}");
    return popularsList;
  }

  static Future<bool> addToPopulars(Product dbEntry) async {
    try {
      box.add(dbEntry);
      _log.i("Added ${dbEntry.toString()} to '$boxName'.");
      return true;
    } catch (e) {
      _log.e(e);
      return false;
    }
  }
}
