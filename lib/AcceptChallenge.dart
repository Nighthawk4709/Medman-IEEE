
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_database/firebase_database.dart';
import 'post.dart';
import 'challenger.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'accept_post.dart';
class AcceptCompete extends StatefulWidget {
  @override
  _AcceptCompeteState createState() => _AcceptCompeteState();
}

class _AcceptCompeteState extends State<AcceptCompete> {
  GoogleSignIn googleSignIn = GoogleSignIn();
  String username;

  @override

  getUserId() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    username = sharedPreferences.getString('name');
  }

  FirebaseDatabase _database = FirebaseDatabase.instance;
  String nodeName = "challenge";
  List<AcceptPost> competepostsList = <AcceptPost>[];


  @override
  void initState() {
    _database.reference().child(nodeName).onChildAdded.listen(_childAdded);
    _database.reference().child(nodeName).onChildRemoved.listen(_childRemoves);
    _database.reference().child(nodeName).onChildChanged.listen(_childChanged);

    getUserId();
    super.initState();


  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      child: Column(
        children: <Widget>[
          Center(
            child: Visibility(
              visible: competepostsList.isEmpty,
              child: Center(
                child: Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ),

          Visibility(
            visible: competepostsList.isNotEmpty,
            child: Flexible(
                child: FirebaseAnimatedList(
                    query: _database.reference().child('challenge'),
                    itemBuilder: (_, DataSnapshot snap, Animation<double> animation, int index){
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: ListTile(
                            title: ListTile(
                              title: Text(
                                competepostsList[index].title,
                                style: TextStyle(
                                    fontSize: 22.0, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                "Challenger: "+competepostsList[index].author,
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.black),
                              ),
                              trailing: Text(
                                timeago.format(DateTime.fromMillisecondsSinceEpoch(competepostsList[index].date)),
                                style: TextStyle(fontSize: 14.0, color: Colors.grey),

                              ),

                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: Center(
                                  child: Text(
                                    "Accepted by: "+competepostsList[index].accepter,
                                    style: TextStyle(fontSize: 18, color: Colors.black),
                                  ),
                                ),
                              ),
                            ),

                          ),
                        ),
                      );
                    })),
          )
        ],
      ),
    );
  }
  _childAdded(Event event) {
    setState(() {
      competepostsList.add(AcceptPost.fromSnapshot(event.snapshot));
    });
  }

  void _childRemoves(Event event) {
    var deletedPost = competepostsList.singleWhere((post){
      return post.key == event.snapshot.key;
    });

    setState(() {
      competepostsList.removeAt(competepostsList.indexOf(deletedPost));
    });
  }

  void _childChanged(Event event) {
    var changedPost = competepostsList.singleWhere((post){
      return post.key == event.snapshot.key;
    });

    setState(() {
      competepostsList[competepostsList.indexOf(changedPost)] = AcceptPost.fromSnapshot(event.snapshot);
    });
  }
}
