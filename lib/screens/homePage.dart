import 'package:flutter/material.dart';
import 'package:wasteagram/Componets/wastePhoto.dart';
import '../Componets/wasteList.dart';
import '../Componets/myDrawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder(
        stream: Firestore.instance.collection('post').snapshots(),
        builder: (content, snapshot){
          if (snapshot.hasData && snapshot.data.documents.length > 0){
            return Text('Wasteagram: ${snapshot.data.documents.length}');
          }
          else{
            return Text('Wasteagram');
          }
        }
      ),
        centerTitle: true, 
        actions: [
          Builder(
            builder: (context) => IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                  tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                ),
          ),
        ],
      ),
      body: WasteList(),
      floatingActionButton: Semantics(
        child: FloatingActionButton(
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => WastePhotoScreen()));
          },
          child: const Icon(Icons.camera_alt),
          ),
        button: true,
        enabled: true,
        onTapHint: "Take a photo",),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      endDrawer: MyDrawer(),
    );
  }
}