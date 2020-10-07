
import 'package:example/AcceptChallenge.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'companion.dart';
import 'write_feeds.dart';
import 'main.dart';
import 'compete_post.dart';
import 'compete_post_service.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_database/firebase_database.dart';
import 'viewPost.dart';
import 'post.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'challenger.dart';
import 'accept_post.dart';

class viewCompete extends StatefulWidget {
  @override
  _viewCompeteState createState() => _viewCompeteState();
}

class _viewCompeteState extends State<viewCompete> {
  GoogleSignIn googleSignIn = GoogleSignIn();
  String username;

  FirebaseDatabase _database = FirebaseDatabase.instance;
  String nodeName = "compete";
  List<ComepetePost> competepostsList = <ComepetePost>[];
  AcceptPost post = AcceptPost(0, " ", " ", " ");
  getUserId() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    username = sharedPreferences.getString('name');
  }

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
                          query: _database.reference().child('compete'),
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
                                          fontSize: 22.0, color: Colors.black),
                                    ),
                                    trailing: Text(
                                      timeago.format(DateTime.fromMillisecondsSinceEpoch(competepostsList[index].date)),
                                      style: TextStyle(fontSize: 14.0, color: Colors.grey),

                                    ),

                                  ),
                                  subtitle: MaterialButton(
                                    onPressed: (){
                                      post.accepter = username;
                                      post.author = competepostsList[index].author;
                                      post.title = competepostsList[index].title;
                                      post.date = DateTime.now().millisecondsSinceEpoch;
                                      ChallengerService postService = ChallengerService(post.toMap());
                                      postService.addPost();

                                    },
                                    color: Colors.grey[800],
                                    child: Text("Start Challenge", style: TextStyle(fontSize: 20, color: Colors.white),),
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
      competepostsList.add(ComepetePost.fromSnapshot(event.snapshot));
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
      competepostsList[competepostsList.indexOf(changedPost)] = ComepetePost.fromSnapshot(event.snapshot);
    });
  }
}

