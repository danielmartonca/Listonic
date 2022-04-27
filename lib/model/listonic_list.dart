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
}
