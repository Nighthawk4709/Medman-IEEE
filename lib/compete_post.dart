import 'package:firebase_database/firebase_database.dart';
class ComepetePost{

  static const KEY = "key";
  static const DATE = "date";
  static const TITLE = "title";
  static const AUTHOR = "author";

  int date;
  String key;
  String title;

  String author;

  ComepetePost(this.date, this.title, this.author);

//  String get key  => _key;
//  String get date  => _date;
//  String get title  => _title;
//  String get body  => _body;


  ComepetePost.fromSnapshot(DataSnapshot snap):
        this.key = snap.key,
        this.date = snap.value[DATE],
        this.author = snap.value[AUTHOR],
        this.title = snap.value[TITLE];

  Map toMap(){
    return {TITLE: title, AUTHOR:author, DATE: date, KEY: key};
  }
}