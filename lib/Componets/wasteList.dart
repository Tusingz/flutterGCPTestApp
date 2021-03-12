import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'wasteEntry.dart';
//import 'package:firebase_storage/firebase_storage.dart';

class WasteList extends StatefulWidget {
  @override
  _WasteListState createState() => _WasteListState();
}

class _WasteListState extends State<WasteList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('post').snapshots(),
      builder: (content, snapshot){
        if (snapshot.hasData && snapshot.data.documents.length > 0){
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index){
            var post = snapshot.data.documents[index];
            return Semantics (child: ListTile(
              //leading: FlutterLogo(),
              trailing: Text(post['quantity'].toString()),
              title: Text(post['date']),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => WasteEntry(data: post.data)));
              }),
              onTapHint: 'Will display indivdual post',
              );
            }
          );
        }
        else{
          return Center(child: CircularProgressIndicator());
        }
      }
    );
  }
}