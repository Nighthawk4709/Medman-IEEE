import 'package:example/signin.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'discover_feeds.dart';

class signedin extends StatefulWidget {
  @override
  _signedinState createState() => _signedinState();
}

class _signedinState extends State<signedin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          //Image.network(
          //home()._googleSignIn.currentUser.photoUrl,
          //height: 50.0,
          // width: 50.0,
          //),
          //Text(home()._googleSignIn.currentUser.displayName),
          OutlineButton(
            child: Text("Logout"),
            onPressed: () {
              AuthProvider().logOut();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => home(),
                ),
                    (route) => false,
              );
            },
          )
        ],
      ),
    );
  }
}
