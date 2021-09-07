import 'package:buyinglist/widgets/loading.dart';
import 'package:buyinglist/widgets/side-menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'buyinglist.dart';

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

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    var activeText = Theme.of(context).textTheme.headline5;

    var inactiveText = Theme.of(context)
        .textTheme
        .headline5!
        .copyWith(color: Colors.grey.shade400);

    var detailText = Theme.of(context)
        .textTheme
        .subtitle2!
        .copyWith(color: Colors.grey.shade400);

    return ListTile(
      title: Row(
        children: [
          Column(
            children: [
              Text(
                document['name'],
                style: document['status'] == 1 ? activeText : inactiveText,
              ),
              Text(
                "Criado em: ${DateFormat('dd/MM/yyyy – kk:mm').format(document['date'].toDate())}",
                style: detailText,
              ),
            ],
          ),
        ],
      ),
      trailing: PopupMenuButton(
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              value: 'edit',
              child: Row(
                children: [
                  Icon(Icons.edit, semanticLabel: "Editar"),
                  Text("Editar")
                ],
              ),
            ),
            PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete, semanticLabel: "Excluir"),
                  Text("Excluir")
                ],
              ),
            )
          ];
        },
        onSelected: (String value) {
          if (value == 'edit')
            print('Editar');
          else if (value == 'delete') print('Remover');
        },
      ),
      onTap: () {
        print("vai pokebola");
      },
    );
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
              return _buildListItem(context, data.docs[index]);
            },
          );
        },
      ),
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
