import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: Firestore.instance.collection('bandnames').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Text("Loading.....");
            } else {
              return ListView(
                children:
                    snapshot.data.documents.map((DocumentSnapshot document) {
                  return  _listBuildItem(context, document);
                }).toList(),
              );
            }
          }),
    );
  }

  Widget _listBuildItem(BuildContext context, DocumentSnapshot document) {
    return ListTile(
      title: (
         Text(document['name'])
      ),
      trailing:  Text(document['votes'].toString()),
      onTap: () {
        document.reference.updateData({
          'votes': document['votes']+1
        });
      },
    );
  }
}
