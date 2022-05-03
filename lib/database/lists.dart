import 'dart:async';

import 'package:hive/hive.dart';
import 'package:listonic_clone/model/product.dart';

import 'package:logger/logger.dart';

import 'boxes.dart';

class ListonicLists {
  static final _log = Logger(printer: PrettyPrinter());
  static const String boxName = "listsBox";

  static final Set<ListonicLists> listonicLists = Set.identity();

  static Future<List<ListonicLists>> getMyLists() async {
    Box box = await ListonicBoxes.getLists();
    var listOfLists = box.values.toList(growable: false).cast<ListonicLists>();
    _log.i("Got user lists from database:${listOfLists.toString()}");
    return listOfLists;
  }

  static Future<bool> addListToMyLists(Product dbEntry) async {
    try {
      Box box = await ListonicBoxes.getLists();
      box.add(dbEntry);
      _log.i("Added ${dbEntry.toString()} to '$boxName'.");
      return true;
    } catch (e) {
      _log.e(e);
      return false;
    }
  }
}
