import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:listonic_clone/windows/my_lists_window.dart';
import 'package:listonic_clone/windows/products_window.dart';
import 'package:logger/logger.dart';

final log = Logger(printer: PrettyPrinter(), output: ConsoleOutput());

class HomeWindow extends StatefulWidget {
  const HomeWindow({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomeWindow> createState() => _HomeWindowState();
}

class _HomeWindowState extends State<HomeWindow> {
  late Widget _body;
  Color _navMyListsColor = Colors.white;
  Color _navProductsColor = Colors.white;
  static const Color _onclickButtonColor = Colors.orange;

  _HomeWindowState() {
    _body = const Expanded(
        child: Align(
            child: Center(
      child: Text("Body text"),
    )));
  }

  void switchToEmptyBody() {
    log.i("switchToEmptyBody called");
    setState(() {
      _navMyListsColor = Colors.white;
      _navProductsColor = Colors.white;
      _body = const ProductsWindow();
    });
  }

  void switchToMyLists() {
    log.i("switchToMyLists called");
    setState(() {
      _navProductsColor = Colors.white;
      _navMyListsColor = _onclickButtonColor;
      _body = const MyListsWindow();
    });
  }

  void switchToProducts() {
    log.i("switchToProducts called");
    setState(() {
      _navMyListsColor = Colors.white;
      _navProductsColor = _onclickButtonColor;
      _body = const Expanded(
        child: Align(
            child: Center(
          child: Text("My Products"),
        )),
      );
    });
  }

  Widget getNavbar() {
    return SizedBox(
      child: Container(
          color: Colors.green,
          child: Center(
              heightFactor: 1,
              child: Row(children: [
                Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0, shadowColor: Colors.transparent),
                        onPressed: switchToMyLists,
                        child: Text(
                          "My Lists",
                          maxLines: 1,
                          textScaleFactor: 1.5,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: _navMyListsColor),
                        ))),
                const Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 10)),
                Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0, shadowColor: Colors.transparent),
                      onPressed: switchToProducts,
                      child: Text(
                        "Products",
                        maxLines: 1,
                        textScaleFactor: 1.5,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _navProductsColor),
                      )),
                )
              ]))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.home_filled),
            onPressed: switchToEmptyBody,
          ),
          title: Text(widget.title, style: const TextStyle(fontSize: 30)),
        ),
        body: Column(
          verticalDirection: VerticalDirection.down,
          children: [getNavbar(), _body],
        ));
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}
