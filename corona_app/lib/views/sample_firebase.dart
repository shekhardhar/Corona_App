import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:corona_app/scopped_models/home_scoped_model.dart';
import 'package:corona_app/views/base_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewsPage extends StatefulWidget {
  NewsPage({Key key}) : super(key: key);
  // final String title;

  @override
  _NewsPageState createState() {
    return _NewsPageState();
  }
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return BaseView<HomeScopedModel>(
      builder: (context, child, model) => Scaffold(
        body: SafeArea(
            child: StreamBuilder(
          stream: Firestore.instance.collection('covid19Info').snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) return Text('Loading...');
            try {
              return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) =>
                    _buildListItem(context, snapshot.data.documents[index]),
              );
            } catch (e) {
              print(e);
            }
          },
        )),
      ),
    );
  }

  _buildListItem(BuildContext context, DocumentSnapshot document) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Expanded(
            child: Text(document['name']),
          ),
          Expanded(
            child: Text(document['roll_no'].toString()),
          ),
          Expanded(
            child: Text(document['college']),
          )
        ],
      ),
      onTap: () {
        Firestore.instance.runTransaction((transaction) async {
          // get fresh snapshot of the data of the document
          DocumentSnapshot freshSnap =
              await transaction.get(document.reference);
          await transaction.update(freshSnap.reference, {
            'name': freshSnap['name'] + 'Shah',
          });
        });
      },
    );
  }
}
