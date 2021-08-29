import 'package:buyinglist/widgets/loading.dart';
import 'package:buyinglist/widgets/side-menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Listas de Compras"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('list').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Loading();
          var data = (snapshot.data! as QuerySnapshot);
          return ListView.builder(
            itemExtent: 80.0,
            itemCount: data.docs.length,
            itemBuilder: (context, index) {
              return Text(data.docs[index]['name']);
            },
          );
        },
      ),
      drawer: SideMenuPage(widget.user),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
