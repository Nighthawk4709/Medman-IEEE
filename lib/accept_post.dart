import 'package:firebase_database/firebase_database.dart';
class AcceptPost{

  static const KEY = "key";
  static const DATE = "date";
  static const TITLE = "title";
  static const AUTHOR = "author";
  static const ACCEPTER = "accepter";

  int date;
  String key;
  String title;
  String author;
  String accepter;

  AcceptPost(this.date, this.title, this.author, this.accepter);

//  String get key  => _key;
//  String get date  => _date;
//  String get title  => _title;
//  String get body  => _body;


  AcceptPost.fromSnapshot(DataSnapshot snap):
        this.key = snap.key,
        this.date = snap.value[DATE],
        this.author = snap.value[AUTHOR],
        this.title = snap.value[TITLE],
        this.accepter = snap.value[ACCEPTER];

  Map toMap(){
    return {TITLE: title, AUTHOR:author,ACCEPTER: accepter, DATE: date, KEY: key};
  }
}