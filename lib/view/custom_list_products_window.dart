import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:listonic_clone/model/listonic_list.dart';

import '../database/lists.dart';
import '../database/products.dart';
import '../model/product.dart';

class CustomListProductsBottomSheet extends StatefulWidget {
  final ListonicList currentList;
  final void Function(VoidCallback fn) setStateParent;

  const CustomListProductsBottomSheet(
      ListonicList list, void Function(VoidCallback fn) setState,
      {Key? key})
      : currentList = list,
        setStateParent = setState,
        super(key: key);

  @override
  _CustomListProductsBottomSheetState createState() =>
      _CustomListProductsBottomSheetState();
}

class _CustomListProductsBottomSheetState
    extends State<CustomListProductsBottomSheet> {
  bool toggleIcon = true;

  toggleIconState(bool value) {
    setState(() {
      toggleIcon = value;
    });
  }

  final _notSelectedColor = Colors.green;
  final _selectedColor = Colors.amber;

  late List<Product> _productsList;

  void addProductToCurrentList(ListonicList currentList, Product product) {
    if (!currentList.products.contains(product)) {
      widget.setStateParent(() {
        setState(() {
          currentList.products.add(product);
        });
      });
    } else {
      widget.setStateParent(() {
        setState(() {
          currentList.products.remove(product);
        });
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
        Color color = widget.currentList.products.contains(product)
            ? _selectedColor
            : _notSelectedColor;

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

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
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
                        return createProductsListWidget();
                      }
                    })
              ],
            ),
          ),
        ));
  }
}
