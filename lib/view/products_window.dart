import 'dart:io';

import 'package:flutter/material.dart';
import 'package:listonic_clone/database/products.dart';
import 'package:logger/logger.dart';

import '../model/product.dart';

final log = Logger(printer: PrettyPrinter(), output: ConsoleOutput());

class ProductsWindow extends StatefulWidget {
  const ProductsWindow({Key? key}) : super(key: key);

  @override
  State<ProductsWindow> createState() => _ProductsWindowState();
}

class _ProductsWindowState extends State<ProductsWindow> {
  final double _addProductsIconSize = 50;
  List<Product> _productsList = List<Product>.empty(growable: true);

  final _formKey = GlobalKey<FormState>();
  final _formControllerName = TextEditingController();
  final _formControllerDefaultQuantity = TextEditingController();
  final _formControllerMeasureUnit = TextEditingController();
  final _formControllerType = TextEditingController();

  void openAddProductsModal() {
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
                      'New Product:',
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
                            SizedBox(
                                width: 200,
                                child: TextFormField(
                                  controller: _formControllerDefaultQuantity,
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    labelText: 'Default Quantity',
                                  ),
                                  // The validator receives the text that the user has entered.
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a valid quality';
                                    }
                                    var myDouble = double.tryParse(value);
                                    log.i(myDouble);
                                    if (myDouble is double) {
                                      return null;
                                    } else {
                                      return "Please insert an number.";
                                    }
                                  },
                                )),
                            SizedBox(
                                width: 200,
                                child: TextFormField(
                                  controller: _formControllerMeasureUnit,
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    labelText: 'Measure Unit',
                                  ),
                                  // The validator receives the text that the user has entered.
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a valid unit';
                                    }
                                    return null;
                                  },
                                )),
                            SizedBox(
                                width: 200,
                                child: TextFormField(
                                  controller: _formControllerType,
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    labelText: 'Type',
                                  ),
                                  // The validator receives the text that the user has entered.
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a valid type';
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
                                "Form values retrieved:{\nName:${_formControllerName.text}\nDefault quantity:${_formControllerDefaultQuantity.text}\nUnit:${_formControllerMeasureUnit.text}\nType:${_formControllerType.text}\n}");

                            Products.addToProducts(Product.withValues(
                                productName: _formControllerName.text,
                                defaultQuantity: double.parse(
                                    _formControllerDefaultQuantity.text),
                                measureUnit: _formControllerMeasureUnit.text,
                                type: _formControllerType.text));

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      "Added new product '${_formControllerName.text}'"),
                                  backgroundColor: Colors.green),
                            );

                            _formControllerName.clear();
                            _formControllerDefaultQuantity.clear();
                            _formControllerMeasureUnit.clear();
                            _formControllerType.clear();

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

  void openEditEntryModal(Product product) {
    _formControllerName.text = product.name;
    _formControllerDefaultQuantity.text = product.defaultQuantity.toString();
    _formControllerMeasureUnit.text = product.measureUnit;
    _formControllerType.text = product.type;

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
                      'Edit product:',
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
                            SizedBox(
                                width: 200,
                                child: TextFormField(
                                  controller: _formControllerDefaultQuantity,
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    labelText: 'Default Quantity',
                                  ),
                                  // The validator receives the text that the user has entered.
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a valid quality';
                                    }
                                    var myDouble = double.tryParse(value);
                                    log.i(myDouble);
                                    if (myDouble is double) {
                                      return null;
                                    } else {
                                      return "Please insert an number.";
                                    }
                                  },
                                )),
                            SizedBox(
                                width: 200,
                                child: TextFormField(
                                  controller: _formControllerMeasureUnit,
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    labelText: 'Measure Unit',
                                  ),
                                  // The validator receives the text that the user has entered.
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a valid unit';
                                    }
                                    return null;
                                  },
                                )),
                            SizedBox(
                                width: 200,
                                child: TextFormField(
                                  controller: _formControllerType,
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    labelText: 'Type',
                                  ),
                                  // The validator receives the text that the user has entered.
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a valid type';
                                    }
                                    return null;
                                  },
                                )),
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: ElevatedButton(
                        child: const Text('Edit'),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            log.i(
                                "Form values retrieved:{\nName:${_formControllerName.text}\nDefault quantity:${_formControllerDefaultQuantity.text}\nUnit:${_formControllerMeasureUnit.text}\nType:${_formControllerType.text}\n}");

                            Products.updateProduct(
                                product.name,
                                Product.withValues(
                                    productName: _formControllerName.text,
                                    defaultQuantity: double.parse(
                                        _formControllerDefaultQuantity.text),
                                    measureUnit:
                                        _formControllerMeasureUnit.text,
                                    type: _formControllerType.text));

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      "Modified '${_formControllerName.text}'"),
                                  backgroundColor: Colors.green),
                            );

                            _formControllerName.clear();
                            _formControllerDefaultQuantity.clear();
                            _formControllerMeasureUnit.clear();
                            _formControllerType.clear();

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

  void openDeleteModal(String productName) {
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
                      'Are you sure you want to delete the fallowing product?',
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
                                productName,
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
                                Products.deleteProduct(productName);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text("Deleted '$productName'"),
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
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _productsList.length,
      // Provide a builder function. This is where the magic happens.
      // Convert each item into a widget based on the type of item it is.
      itemBuilder: (context, index) {
        final Product product = _productsList[index];

        return Container(
          margin: const EdgeInsets.all(1.0),
          padding: const EdgeInsets.all(1.0),
          decoration: BoxDecoration(
              border:
                  Border.all(color: Colors.green, style: BorderStyle.solid)),
          child: ListTile(
            title: product.buildTitle(context),
            subtitle: product.buildSubtitle(context),
            onTap: () => openEditEntryModal(product),
            onLongPress: () => openDeleteModal(product.name),
          ),
        );
      },
    );
  }

  Widget getProductsListWidget() {
    return FutureBuilder(
        future: Products.getProducts(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            sleep(const Duration(milliseconds: 500));
          }
          if (!snapshot.hasData) {
            return const Padding(
                padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: Text("Loading data..."));
          } else {
            _productsList = snapshot.data;
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: createListWidget(),
            );
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
                    'Your registered products',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                getProductsListWidget()
              ],
            ),
          ),
        ),
        Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 5, 15),
              child: IconButton(
                onPressed: openAddProductsModal,
                icon: const Icon(Icons.add_circle_rounded),
                color: Colors.green,
                iconSize: _addProductsIconSize,
              ),
            )),
      ],
    ));
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _formControllerName.dispose();
    _formControllerDefaultQuantity.dispose();
    _formControllerMeasureUnit.dispose();
    _formControllerType.dispose();
    super.dispose();
  }
}
