import 'package:flutter/material.dart';
import 'myDrawer.dart';

class WasteEntry extends StatelessWidget {
  final data;

  WasteEntry({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
    title: Text("Wasteagram"), 
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
  endDrawer: MyDrawer(),
  body: Column(children:[
    Padding(padding: EdgeInsets.symmetric(vertical: 16.0), child: Text(data['date'], textScaleFactor: 1.7)),
    Container(width: 400, height: 400, child: Semantics(child: Image.network(data['imageurl'], semanticLabel: "This is a image of waste"))),
    Padding(padding: EdgeInsets.symmetric(vertical: 16.0), child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
      Text(data['latitude'], textScaleFactor: 1.7),
      Text(data['longitude'], textScaleFactor: 1.7)
    ],),),
    Text("Items: ${data['quantity']}", textScaleFactor: 1.7)
  ],)
  
  );
  }
}