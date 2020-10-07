import 'package:flutter/cupertino.dart';

import 'post.dart';
import 'discover_feeds.dart';
import 'package:flutter/material.dart';
import 'PostService.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostView extends StatefulWidget {
  final Post post;

  PostView(this.post);

  @override
  _PostViewState createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post.title),
        backgroundColor: Colors.green,
      ),
      body: Container(
        color: Colors.black87,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black45),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "by: " + widget.post.author,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        Divider(),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              timeago.format(
                                  DateTime.fromMillisecondsSinceEpoch(widget.post.date)),
                              style: TextStyle(fontSize: 14.0, color: Colors.grey),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Divider(),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: AspectRatio(
                          aspectRatio: 5 / 3,
                          child:
                          (widget.post.image != " ")
                              ? Image.network(
                            widget.post.image,
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
                  ),

                    ],
                  ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(

                  //height: 500,
                  width: 400,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black45),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      widget.post.body,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
