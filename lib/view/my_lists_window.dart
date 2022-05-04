import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:listonic_clone/model/listonic_list.dart';
import 'package:logger/logger.dart';

import '../database/lists.dart';
import '../model/product.dart';

final log = Logger(printer: PrettyPrinter(), output: ConsoleOutput());

class MyListsWindow extends StatefulWidget {
  const MyListsWindow({Key? key}) : super(key: key);

  @override
  State<MyListsWindow> createState() => _MyListsWindowState();
}

class _MyListsWindowState extends State<MyListsWindow> {
  final double _addListsIconSize = 50;
  List<ListonicList> _listOfCustomsList =
      List<ListonicList>.empty(growable: true);

  late ListonicList currentList;

  final _formKey = GlobalKey<FormState>();
  final _formControllerName = TextEditingController();

  void addProductToList(ListonicList list) {}

  Widget getCurrentListProducts() {
    if (currentList.products.isEmpty) {
      return const Padding(
        padding: EdgeInsets.only(top: 50),
        child: Text(
          "List is empty. Add products to it!",
          style: TextStyle(fontSize: 20),
        ),
      );
    } else {
      return Text(currentList.products.toString());
    }
  }

  void openAddListsModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              height: 500,
              color: Colors.amber,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'New List:',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            SizedBox(
                                width: 200,
                                child: TextFormField(
                                  controller: _formControllerName,
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    labelText: 'Name',
                                  ),
                                  // The validator receives the text that the user has entered.
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a valid name';
                                    }
                                    return null;
                                  },
                                )),
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: ElevatedButton(
                        child: const Text('Add'),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            log.i(
                                "Form values retrieved:{\nName:${_formControllerName.text}");

                            ListonicLists.addListToMyLists(ListonicList(
                                _formControllerName.text,
                                List<Product>.empty(growable: true)));

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      "Added new list '${_formControllerName.text}'"),
                                  backgroundColor: Colors.green),
                            );

                            _formControllerName.clear();

                            setState(() {
                              Navigator.pop(context);
                            });
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ));
      },
    );
  }

  void openListModal(ListonicList list) {
    currentList = list;
    _formControllerName.text = list.name;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
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
                              list.name,
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
                            onPressed: () => addProductToList(list),
                            icon: const Icon(Icons.add_circle_rounded),
                            color: Colors.green,
                            iconSize: _addListsIconSize,
                          ),
                        ))
                  ],
                ),
              ),
            ));
      },
    );
  }

  void openDeleteModal(String listName) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              height: 500,
              color: Colors.amber,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Are you sure you want to delete the fallowing list?',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 30, bottom: 30),
                              child: Text(
                                listName,
                                style: const TextStyle(
                                    fontSize: 30, color: Colors.green),
                              ),
                            )
                          ],
                        )),
                    Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Column(
                          children: [
                            ElevatedButton(
                              child: const Text('Confirm'),
                              style:
                                  ElevatedButton.styleFrom(primary: Colors.red),
                              onPressed: () {
                                ListonicLists.deleteList(listName);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text("Deleted '$listName'"),
                                      backgroundColor: Colors.red),
                                );
                                setState(() {
                                  Navigator.pop(context);
                                });
                              },
                            ),
                            ElevatedButton(
                              child: const Text('Cancel'),
                              onPressed: () {
                                setState(() {
                                  Navigator.pop(context);
                                });
                              },
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            ));
      },
    );
  }

  Widget createListWidget() {
    return Expanded(
        child: ListView.builder(
      shrinkWrap: true,
      itemCount: _listOfCustomsList.length,
      // Provide a builder function. This is where the magic happens.
      // Convert each item into a widget based on the type of item it is.
      itemBuilder: (context, index) {
        final ListonicList list = _listOfCustomsList[index];

        return Container(
          margin: const EdgeInsets.all(5.0),
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              color: Colors.green,
              border:
                  Border.all(color: Colors.green, style: BorderStyle.solid)),
          child: ListTile(
            dense: true,
            title: list.buildTitle(context),
            onTap: () => openListModal(list),
            onLongPress: () => openDeleteModal(list.name),
          ),
        );
      },
    ));
  }

  Widget getMyListsWidget() {
    return FutureBuilder(
        future: ListonicLists.getMyLists(),
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
            _listOfCustomsList = snapshot.data;
            return createListWidget();
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Stack(
      alignment: AlignmentDirectional.centerStart,
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'Your custom lists',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                getMyListsWidget()
              ],
            ),
          ),
        ),
        Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 5, 15),
              child: IconButton(
                onPressed: openAddListsModal,
                icon: const Icon(Icons.add_shopping_cart),
                color: Colors.amber,
                iconSize: _addListsIconSize,
              ),
            )),
      ],
    ));
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _formControllerName.dispose();
    super.dispose();
  }
}
