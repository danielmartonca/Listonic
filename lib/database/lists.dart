import 'dart:async';

import 'package:hive/hive.dart';
import 'package:listonic_clone/model/product.dart';

import 'package:logger/logger.dart';

import 'boxes.dart';

class ListonicList {
  static final _log = Logger(printer: PrettyPrinter());

  // static final ListonicList instance = ListonicList.init();
  // ListonicList.init();
  static const String boxName = "listsBox";

  static Box box = Boxes.getLists();

  static final Set<ListonicList> listonicLists = Set.identity();

  static List<ListonicList> getMyLists() {
    var listOfLists = box.values.toList(growable: false).cast<ListonicList>();
    _log.i("Got user lists from database:${listOfLists.toString()}");
    return listOfLists;
  }

  static Future<bool> addListToMyLists(Product dbEntry) async {
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
