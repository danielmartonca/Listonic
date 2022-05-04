import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:listonic_clone/model/product.dart';

import 'package:hive/hive.dart';

part 'listonic_list.g.dart';

@HiveType(typeId: 1)
class ListonicList extends HiveObject {
  @HiveField(0)
  late final String _name;
  @HiveField(1)
  late final List<Product> _products;

  ListonicList(this._name, this._products);


  @override
  String toString() {
    return 'ListonicList{_name: $_name, _products: $_products}';
  }

  List<Product> get products => _products;

  String get name => _name;

  Widget buildTitle(BuildContext context) {
    return Center(
      child: Text(_name,style: const TextStyle(fontSize: 20)),
    );
  }
}
