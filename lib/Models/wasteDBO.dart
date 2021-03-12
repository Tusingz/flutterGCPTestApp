import 'package:location/location.dart';

class WasteDBO {
  String url;
  LocationData locationData;
  String date;
  int quantity;

  WasteDBO.start(this.url);

  void retrieveDate() {
    DateTime today = new DateTime.now();
    String dateTrans ="${today.month.toString().padLeft(2,'0')}-${today.day.toString().padLeft(2,'0')}-${today.year.toString()}";
    this.date = dateTrans;
  }
}
