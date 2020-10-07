import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Requests extends StatefulWidget {
  @override
  _RequestsState createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  GoogleSignIn googleSignIn = GoogleSignIn();
  String userId;
  String userPhoto;

  @override
  void initState() {
    getUserId();
    super.initState();
  }

  getUserId() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userId = sharedPreferences.getString('id');
    userPhoto = sharedPreferences.getString('profile_pic');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Container(
            color: Colors.black87,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('users').snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    return ListView.builder(
                      itemBuilder: (listContext, index) =>
                          buildItem(snapshot.data.docs[index]),
                      itemCount: snapshot.data.docs.length,
                    );
                  }

                  return Container();
                },
              ),
            ),
          ),
      ),
    );
  }
  buildItem(doc) {
    if ((userId != doc.get('id'))) {
      return Card(

      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 40,
          child: Row(
            children: <Widget>[
              CircleAvatar(
                radius: 20.0,
                backgroundImage:
                NetworkImage(doc.get('profile_pic')),
                backgroundColor: Colors.transparent,
              ),

              Container(
                width: 10,
              ),
              Center(
                child: Text(doc.get('name').toUpperCase(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
              ),
              Spacer(),
              MaterialButton(
                minWidth: 10,
                onPressed: (){},
                child: Icon(Icons.done,),
                color: Colors.green[800],

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
              ),
              Container(
                width: 10,
              ),

              MaterialButton(
                minWidth: 10,
                onPressed: (){},
                child: Icon(Icons.not_interested,),
                color: Colors.red[800],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                ),
              )

            ],
          ),
        ),
      ),
    );
    } else {
      return Container(height: 10, width: 10,) ;
    }
  }
  String getCapitalizeString({String str}) {
    if (str.length <= 1) { return str.toUpperCase(); }
    return '${str[0].toUpperCase()}${str.substring(1)}';
  }
}
