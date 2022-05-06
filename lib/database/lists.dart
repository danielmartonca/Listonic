import 'dart:async';

import 'package:hive/hive.dart';
import 'package:listonic_clone/model/listonic_list.dart';

import 'package:logger/logger.dart';

import 'boxes.dart';

class ListonicLists {
  static final _log = Logger(printer: PrettyPrinter());
  static const String boxName = "listsBox";

  static Future<List<ListonicList>> getMyLists() async {
    Box box = await ListonicBoxes.getLists();
    var listOfLists = box.values.toList(growable: false).cast<ListonicList>();
    _log.i("Got user lists from database:${listOfLists.toString()}");
    return listOfLists;
  }

  static Future<bool> addListToMyLists(ListonicList dbEntry) async {
    try {
      Box box = await ListonicBoxes.getLists();
      box.put(dbEntry.name, dbEntry);
      _log.i("Added ${dbEntry.toString()}to '$boxName'.");
      return true;
    } catch (e) {
      _log.e(e);
      return false;
    }
  }

  static Future<void> updateList(String oldKey, ListonicList list) async {
    Box box = await ListonicBoxes.getLists();
    box.delete(oldKey);
    box.put(list.name, list);
    _log.i("Updated list '${list.name}' to \n${list.toString()}.");
  }

  static Future<void> deleteList(String oldKey) async {
    Box box = await ListonicBoxes.getLists();
    box.delete(oldKey);
    _log.i("Deleted list by key(name) '$oldKey'");
  }
}
