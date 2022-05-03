import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

part 'product.g.dart';

@HiveType(typeId: 0)
class Product extends HiveObject {
  @HiveField(0)
  late final String _productName;

  String get productName => _productName;
  @HiveField(1)
  late final double _defaultQuantity;
  @HiveField(2)
  late final String _measureUnit;
  @HiveField(3)
  late final String _type;

  Product(
      this._productName, this._defaultQuantity, this._measureUnit, this._type);

  Product.withValues(
      {required String productName,
      required double defaultQuantity,
      required String measureUnit,
      required String type})
      : _productName = productName,
        _defaultQuantity = defaultQuantity,
        _measureUnit = measureUnit,
        _type = type;

  @override
  String toString() {
    return '\nProduct{_productName: $_productName, _defaultQuantity: $_defaultQuantity, _measureUnit: $_measureUnit, _type: $_type}';
  }

  Widget buildTitle(BuildContext context) {
    return Center(
      child: Text("Name: $_productName"),
    );
  }

  Widget buildSubtitle(BuildContext context) {
    return Column(
      children: [
        Text("Type: $_type"),
        Text("Measure unit: $_measureUnit"),
        Text("Default quantity: $_defaultQuantity"),
      ],
    );
  }

  String get name => _productName;

  double get defaultQuantity => _defaultQuantity;

  String get measureUnit => _measureUnit;

  String get type => _type;
}
