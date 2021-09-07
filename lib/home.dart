import 'package:buyinglist/widgets/side-menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'buyinglist.dart';
import 'listbuyinglists.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _goList(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => BuyingListPage(user: widget.user)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Listas de Compras"),
      ),
      body: ListBuyingListWidget(),
      drawer: SideMenuPage(widget.user),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _goList(context);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
