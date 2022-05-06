import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:listonic_clone/model/listonic_list.dart';

import '../database/boxes.dart';
import '../database/lists.dart';
import '../database/products.dart';
import '../model/product.dart';

class ListsBottomSheet extends StatefulWidget {
  final ListonicList currentList;

  const ListsBottomSheet(ListonicList list, {Key? key})
      : currentList = list,
        super(key: key);

  @override
  _ListsBottomSheetState createState() => _ListsBottomSheetState();
}

class _ListsBottomSheetState extends State<ListsBottomSheet> {
  bool toggleIcon = true;
  final double _addProductToListsIconSize = 50;
  final _notSelectedColor = Colors.green;
  final _selectedColor = Colors.amber;

  late List<Product> _productsList;
  late final Map<Product, Color> _selectedProductsMap =
      Map<Product, Color>.identity();

  toggleIconState(bool value) {
    setState(() {
      toggleIcon = value;
    });
  }

  void addProductToCurrentList(ListonicList currentList, Product product) {
    log.wtf(_selectedProductsMap[product]);
    if (!currentList.products.contains(product)) {
      setState(() {
        _selectedProductsMap[product] = _selectedColor;
        currentList.products.add(product);
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //       content: Text("Added '${product.name}' to the list."),
        //       backgroundColor: Colors.green),
        // );
      });
    } else {
      setState(() {
        _selectedProductsMap[product] = _notSelectedColor;
        currentList.products.remove(product);
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //       content: Text("Removed '${product.name}' from the list."),
        //       backgroundColor: Colors.grey),
        // );
      });
    }
    ListonicLists.updateList(currentList.name, currentList);
  }

  Widget createProductsListWidget() {
    return Expanded(
        child: ListView.builder(
      shrinkWrap: true,
      itemCount: _productsList.length,
      // Provide a builder function. This is where the magic happens.
      // Convert each item into a widget based on the type of item it is.
      itemBuilder: (context, index) {
        final Product product = _productsList[index];
        Color? color = _selectedProductsMap[product];
        color ??= _notSelectedColor;

        return Container(
          margin: const EdgeInsets.all(5.0),
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              color: color,
              border:
                  Border.all(color: Colors.black, style: BorderStyle.solid)),
          child: ListTile(
            dense: true,
            title: product.buildTitle(context),
            subtitle: product.buildSubtitle(context),
            onTap: () => addProductToCurrentList(widget.currentList, product),
          ),
        );
      },
    ));
  }

  Widget getCurrentListProducts() {
    if (widget.currentList.products.isEmpty) {
      return const Padding(
        padding: EdgeInsets.only(top: 50),
        child: Text(
          "List is empty. Add products to it!",
          style: TextStyle(fontSize: 20),
        ),
      );
    } else {
      return Text(widget.currentList.products.toString());
    }
  }

  void addProductToList() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              height: 500,
              color: Colors.lightBlue,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: Text(
                        'Select a product',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 15),
                      child: Text(
                        '(or add new one in Products)',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    FutureBuilder(
                        future: Products.getProducts(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                                child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                              // child: Text("Loading data...")),
                              child: SpinKitFadingCube(
                                size: 30,
                                color: Colors.green,
                              ),
                            ));
                          } else {
                            _productsList = snapshot.data;
                            for (var product in _productsList) {
                              _selectedProductsMap[product] = _notSelectedColor;
                            }
                            return createProductsListWidget();
                          }
                        })
                  ],
                ),
              ),
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          height: double.infinity,
          color: Colors.amber,
          child: Center(
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Center(
                        child: Text(
                          widget.currentList.name,
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: getCurrentListProducts())
                  ],
                ),
                Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 5, 15),
                      child: IconButton(
                        onPressed: () => addProductToList(),
                        icon: const Icon(Icons.add_circle_rounded),
                        color: Colors.green,
                        iconSize: _addProductToListsIconSize,
                      ),
                    ))
              ],
            ),
          ),
        ));
  }
}
