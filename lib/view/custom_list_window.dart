import 'package:flutter/material.dart';
import 'package:listonic_clone/model/listonic_list.dart';
import 'package:listonic_clone/view/custom_list_products_window.dart';

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

  toggleIconState(bool value) {
    setState(() {
      toggleIcon = value;
    });
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
        return CustomListProductsBottomSheet(widget.currentList,setState);
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
