import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

switchToMyLists() {}

switchToProducts() {}

getNavbar() {
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
                      child: const Text(
                        "My Lists",
                        maxLines: 1,
                        textScaleFactor: 1.5,
                      ))),
              const Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 10)),
              Expanded(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0, shadowColor: Colors.transparent),
                    onPressed: switchToProducts,
                    child: const Text(
                      "Products",
                      maxLines: 1,
                      textScaleFactor: 1.5,
                    )),
              )
            ]))),
  );
}

emptyBody() {}

getHomeBody() {
  return Container();
}

getBody() {
  return Column(
    verticalDirection: VerticalDirection.down,
    children: [getNavbar(), getHomeBody()],
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          leading: const IconButton(
            icon: Icon(Icons.list),
            onPressed: emptyBody,
          ),
          title: Text(widget.title, style: const TextStyle(fontSize: 30)),
        ),
        body: getBody());
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}
