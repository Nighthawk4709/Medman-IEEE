import 'package:flutter/material.dart';

class Requests extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ListView.builder(
          itemCount: 50,
          itemBuilder: (context, index) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Icon(
                    Icons.person,
                    color: Colors.grey,
                    size: 60,
                  ),
                  SizedBox(width: 10)
                ],
              ),
              Column(
                children: <Widget>[
                  SizedBox(width: 50),
                  Text("Name"),
                ],
              ),
              Column(
                children: <Widget>[
                  // SizedBox(width: 10),
                  ButtonTheme(
                    minWidth: 100.0,
                    height: 40.0,
                    buttonColor: Colors.green,
                    child: RaisedButton(
                      onPressed: () {},
                      child: Text("Accept"),
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  ButtonTheme(
                    minWidth: 100.0,
                    height: 40.0,
                    buttonColor: Colors.red,
                    child: RaisedButton(
                      onPressed: () {},
                      child: Text("Reject"),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
