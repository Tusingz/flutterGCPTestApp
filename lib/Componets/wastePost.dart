import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'myDrawer.dart';
import '../Models/wasteDBO.dart';
import 'package:location/location.dart';

class WastePost extends StatelessWidget{
  
  final String url;
  final _formKey = GlobalKey<FormState>();
  
  WastePost({Key key, @required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var wasteDBO = WasteDBO.start(url);
    return Scaffold(
    appBar: AppBar(
    title: Text('New Waste'), 
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
  body: Container(
  height: MediaQuery.of(context).size.height,
  width: MediaQuery.of(context).size.width,
  child: Center(
  child:Column(children: [
    Container(width: 400, height: 400, padding: EdgeInsets.all(16.0), child: Semantics(child: Image.network(wasteDBO.url, semanticLabel: "This is a image of waste"))),
    Form(key: _formKey,
    child: TextFormField(
      decoration: InputDecoration(
        labelText: 'Quantity', border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter some number';
        }
        final n = num.tryParse(value);
        if(n == null) {
          return '"$value" is not a valid number';
        }
        return null;
      },
      onSaved: (value){
        wasteDBO.quantity = int.parse(value);
      },
    ),
    ),
    ButtonTheme(
    minWidth: double.infinity,
    height: 100.0,
    child: RaisedButton(
      child: Text('Upload'),
      onPressed: () async {
        var locationService = Location();
        wasteDBO.locationData = await locationService.getLocation();
        wasteDBO.retrieveDate();
        if (_formKey.currentState.validate()) {
          _formKey.currentState.save();
          Firestore.instance.collection('post').add({
            'date': "${wasteDBO.date}",
            'imageurl': "${wasteDBO.url}",
            'quantity': "${wasteDBO.quantity}",
            'latitude': "${wasteDBO.locationData.latitude}",
            'longitude': "${wasteDBO.locationData.longitude}" 
        });
        Navigator.of(context).pop();
        }
      }
      ),
    ), 
  ],
  ),
  ),
  ),
  );
    
    }

}

