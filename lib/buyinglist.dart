import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BuyingListPage extends StatefulWidget {
  const BuyingListPage({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  _BuyingListPageState createState() => _BuyingListPageState();
}

class _BuyingListPageState extends State<BuyingListPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Lista de Compras'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print('salvar');
          },
          tooltip: 'Increment',
          child: Icon(Icons.save),
        ),
      ),
    );
  }
}
