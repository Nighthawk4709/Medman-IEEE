

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:example/write_feeds.dart';
import 'package:example/signin.dart';
import 'companion.dart';
import 'write_feeds.dart';
import 'main.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_database/firebase_database.dart';
import 'viewPost.dart';
import 'post.dart';
import 'package:timeago/timeago.dart' as timeago;

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  FirebaseDatabase _database = FirebaseDatabase.instance;
  String nodeName = "posts";
  List<Post> postsList = <Post>[];


  @override
  void initState() {
    _database.reference().child(nodeName).onChildAdded.listen(_childAdded);
    _database.reference().child(nodeName).onChildRemoved.listen(_childRemoves);
    _database.reference().child(nodeName).onChildChanged.listen(_childChanged);


  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Health Network",
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 8,
        child: Scaffold(

          body: Container(
            color: Colors.black87,
            child: Column(
              children: <Widget>[
                Visibility(
                  visible: postsList.isEmpty,
                  child: Center(
                    child: Container(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),

                Visibility(
                  visible: postsList.isNotEmpty,
                  child: Flexible(
                      child: FirebaseAnimatedList(
                          query: _database.reference().child('posts'),
                          itemBuilder: (_, DataSnapshot snap, Animation<double> animation, int index){
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                child: ListTile(
                                  title: ListTile(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => PostView(postsList[index])));
                                    },
                                    title: Text(
                                      postsList[index].title,
                                      style: TextStyle(
                                          fontSize: 22.0, fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                      "by: "+postsList[index].author,
                                      style: TextStyle(
                                          fontSize: 22.0, color: Colors.black),
                                    ),
                                    trailing: Text(
                                      timeago.format(DateTime.fromMillisecondsSinceEpoch(postsList[index].date)),
                                      style: TextStyle(fontSize: 14.0, color: Colors.grey),
                                    ),
                                  ),

                                ),
                              ),
                            );
                          })),
                )
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.green,
            onPressed: (){Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddPost()));},
            child : Icon(Icons.add),
          ),
        ),
      ),
    );
  }
  _childAdded(Event event) {
    setState(() {
      postsList.add(Post.fromSnapshot(event.snapshot));
    });
  }

  void _childRemoves(Event event) {
    var deletedPost = postsList.singleWhere((post){
      return post.key == event.snapshot.key;
    });

    setState(() {
      postsList.removeAt(postsList.indexOf(deletedPost));
    });
  }

  void _childChanged(Event event) {
    var changedPost = postsList.singleWhere((post){
      return post.key == event.snapshot.key;
    });

    setState(() {
      postsList[postsList.indexOf(changedPost)] = Post.fromSnapshot(event.snapshot);
    });
  }
}

/*
class Feed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          color: Colors.black87,
          child: Column(
            children: <Widget>[
              Visibility(
                visible: postsList.isEmpty,
                child: Center(
                  child: Container(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),

              Visibility(
                visible: postsList.isNotEmpty,
                child: Flexible(
                    child: FirebaseAnimatedList(
                        query: _database.reference().child('posts'),
                        itemBuilder: (_, DataSnapshot snap, Animation<double> animation, int index){
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              child: ListTile(
                                title: ListTile(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => PostView(postsList[index])));
                                  },
                                  title: Text(
                                    postsList[index].title,
                                    style: TextStyle(
                                        fontSize: 22.0, fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    "by: "+postsList[index].author,
                                    style: TextStyle(
                                        fontSize: 22.0, color: Colors.black),
                                  ),
                                  trailing: Text(
                                    timeago.format(DateTime.fromMillisecondsSinceEpoch(postsList[index].date)),
                                    style: TextStyle(fontSize: 14.0, color: Colors.grey),
                                  ),
                                ),

                              ),
                            ),
                          );
                        })),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: (){Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddPost()));},
          child : Icon(Icons.add),
        ),
      ),
    ),
    );
  }
  _childAdded(Event event) {
    setState(() {
      postsList.add(Post.fromSnapshot(event.snapshot));
    });
  }

  void _childRemoves(Event event) {
    var deletedPost = postsList.singleWhere((post){
      return post.key == event.snapshot.key;
    });

    setState(() {
      postsList.removeAt(postsList.indexOf(deletedPost));
    });
  }

  void _childChanged(Event event) {
    var changedPost = postsList.singleWhere((post){
      return post.key == event.snapshot.key;
    });

    setState(() {
      postsList[postsList.indexOf(changedPost)] = Post.fromSnapshot(event.snapshot);
    });
  }
  }
}
*/