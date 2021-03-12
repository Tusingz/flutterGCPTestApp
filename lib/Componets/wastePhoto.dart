import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'wastePost.dart';

class WastePhotoScreen extends StatefulWidget {
  @override
  _WastePhotoScreenState createState() => _WastePhotoScreenState();
}

class _WastePhotoScreenState extends State<WastePhotoScreen> {
  File image;
  String urlString;

  @override
  Widget build(BuildContext context) {
    if(image == null){
      return Card(child: Center(
        child: RaisedButton(
          child: Text('Take a photo'),
          onPressed: (){
            getImage();
          },
        ),
      ));
    }
    else{
      return Scaffold(
    appBar: AppBar(
    title: Text('Wasteagram'), 
    centerTitle: true),
    body: Center(
        child: Padding(padding: EdgeInsets.all(16.0), child: Column(
          children: [
            Container(width: 400, height: 400, child: Semantics(child: Image.file(image), label: "This is a image of waste",)),
            SizedBox(height: 40,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
              Semantics(
              child: RaisedButton(
                child: Text('Take a photo'),
                onPressed: (){
                  getImage();
                },
              ),
                onTapHint: "This button takes you to post the photo",
                button: true,
              ), 
              Semantics(child: RaisedButton(
              child: Text('Post It!'),
              onPressed: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => WastePost(url: urlString)));
              },
              ),
                onTapHint: "This button takes you to post the photo",
                button: true,
              )            
              ],)
          ],),
      )
      )
      );
    }

  }
  void getImage() async {
    DateTime today = new DateTime.now();

    this.image = await ImagePicker.pickImage(source: ImageSource.camera);
    StorageReference storageReference = FirebaseStorage.instance.ref().child(today.toString());
    StorageUploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.onComplete;
    this.urlString = await storageReference.getDownloadURL();
    setState((){});
  }
}
