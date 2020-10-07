

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
                Center(
                  child: Visibility(
                    visible: postsList.isEmpty,
                    child: Center(
                      child: Container(
                        alignment: Alignment.center,
                        child: Center(child: CircularProgressIndicator()),
                      ),
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
                                  subtitle: Column(
                                    children: <Widget>[
                                      Container(
                                        child: AspectRatio(
                                            aspectRatio: 5 / 3,
                                            child:
                                            (postsList[index].image != " ")
                                                ? Image.network(
                                              postsList[index].image,
                                              fit: BoxFit.fill,
                                              width: 500,
                                              height: 300,
                                            )
                                                : Image.asset(
                                              'images/na.jpg',
                                              fit: BoxFit.fill,
                                              width: 500,
                                              height: 300,
                                            )),
                                      ),
                                      /*
                                      Row(
                                        children: <Widget>[
                                          MaterialButton(
                                            onPressed: (){},
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.thumb_up,
                                                ),
                                                Container(
                                                  width: 10,
                                                ),
                                                Center(child: Text("Like"),)
                                              ],
                                            ),
                                            minWidth: 110,
                                            color: Colors.white60,
                                          ),
                                          Spacer(),
                                          MaterialButton(
                                            onPressed: (){},
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.comment,
                                                ),
                                                Container(
                                                  width: 10,
                                                ),
                                                Center(child: Text("Comment"),)
                                              ],
                                            ),
                                            minWidth: 110,
                                            color: Colors.white60,
                                          ),
                                          Spacer(),
                                          MaterialButton(
                                            onPressed: (){},
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.share,
                                                ),
                                                Container(
                                                  width: 10,
                                                ),
                                                Center(child: Text("Share"),)
                                              ],
                                            ),
                                            minWidth: 110,
                                            color: Colors.white60,
                                          ),

                                        ],
                                      ),

                                       */
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              RaisedButton.icon(onPressed: () {}, icon: Icon(Icons.thumb_up, color: Colors.green[800] ), label: Text("Like") ,color: Colors.white,),
                                            ],
                                          ),
                                          Row(
                                            children: <Widget>[
                                              RaisedButton.icon(onPressed: () {}, icon: Icon(Icons.comment, color: Colors.green[800] ), label: Text("Comment") ,color: Colors.white,),
                                            ],
                                          ),
                                          Row(
                                            children: <Widget>[
                                              RaisedButton.icon(onPressed: () {}, icon: Icon(Icons.share, color: Colors.green[800] ), label: Text("Share") ,color: Colors.white,),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })),
                )
              ],
            ),
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
