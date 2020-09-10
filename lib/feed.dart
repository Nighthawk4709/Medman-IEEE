import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Feed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) => Card(
            child: Container(
              height: 350.0,
              color: Colors.lightBlue,
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(),
                    title: Text("Feed title"),
                    subtitle: Text("Author name"),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              "https://previews.123rf.com/images/dizanna/dizanna1509/dizanna150900512/45100714-health-word-cloud-heart-concept.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(Icons.thumb_up, color: Colors.white),
                          SizedBox(width: 8.0),
                          Text("Like"),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Icon(Icons.comment, color: Colors.white),
                          SizedBox(width: 8.0),
                          Text("Comment"),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Icon(Icons.share, color: Colors.white),
                          SizedBox(width: 8.0),
                          Text("Share"),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 12.0),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
