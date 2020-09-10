import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'main.dart';
import 'login.dart';

class tile extends StatefulWidget {
  @override
  _tileState createState() => _tileState();
}

class _tileState extends State<tile> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/bg1.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        //color: Colors.lightBlueAccent,
        //child: Padding(
        //padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
        child: StaggeredGridView.count(
          crossAxisCount: 1,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          staggeredTiles: [
            StaggeredTile.extent(1, 650),
            StaggeredTile.extent(1, 650),
            StaggeredTile.extent(1, 650),
            StaggeredTile.extent(1, 650),
          ],
          children: <Widget>[
            first(context),
            second(),
            third(),
            forth(),
          ],
        ),
      ),
    );
  }
}

Widget first(BuildContext context) {
  return Material(
    color: Colors.black12,
    elevation: 14.0,
    shadowColor: Colors.black,
    borderRadius: BorderRadius.circular(25.0),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Center(
              child: Image.asset(
                'images/logo1.png',
                height: 250,
              )),
          Text(
            "HEALTH \n NETWORK",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 50, color: Colors.white),
          ),
          SizedBox(
            height: 40,
          ),
          RaisedButton(

            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            child: Text(
              "Sign up",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget second() {
  return Material(
    color: Colors.black12,
    elevation: 14.0,
    shadowColor: Colors.black,
    borderRadius: BorderRadius.circular(25.0),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Text(
            "VISION",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 40, color: Colors.white),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "A network of people can be created which will connect people"
                " through by their journeys and these will be able to sh"
                "are their experiences which will help them bond with ea"
                "ch other and make their path towards healthiness more en"
                "joyable. AWARENESS being the key to achieve health goals"
                ", our primary goal is to let people know about the reali"
                "ty of the health maintenance.Understanding how humans react"
                " to competitive improvement and supporting mechanism we can"
                " easily influence them to be more a ware of their health.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
        ],
      ),
    ),
  );
}

Widget third() {
  return Material(
    color: Colors.black12,
    elevation: 30.0,
    shadowColor: Colors.black,
    borderRadius: BorderRadius.circular(25.0),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Text(
            "WHY IT'S NECESSARY",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Growing up, we might hear the phrase ‘health is wealth’, but in today’s"
                " world, people are more focusing on money, not on their real wealth. "
                "The coronavirus outbreak suggests that health is the most crucial aspect of life. "
                "If it is affected, it can cause a lot of other elements like mental well being, economy, social life to suffer. ",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25, color: Colors.white),
          )
        ],
      ),
    ),
  );
}

Widget forth() {
  return Material(
    color: Colors.black12,
    elevation: 14.0,
    shadowColor: Colors.black,
    borderRadius: BorderRadius.circular(25.0),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Text(
            "OUR TEAM",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 40, color: Colors.white),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 260,
                  width: 150,
                  color: Colors.black12,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                          child: Image.asset(
                            'images/dk.png',
                            width: 150,
                            height: 200,
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SignInButton(
                            Buttons.LinkedIn,
                            mini: true,
                            onPressed: () {},
                          ),
                          SignInButton(
                            Buttons.Email,
                            mini: true,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 260,
                  width: 150,
                  color: Colors.black12,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                          child: Image.asset(
                            'images/jp.png',
                            width: 150,
                            height: 200,
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SignInButton(
                            Buttons.LinkedIn,
                            mini: true,
                            onPressed: () {},
                          ),
                          SignInButton(
                            Buttons.Email,
                            mini: true,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 260,
                  width: 150,
                  color: Colors.black12,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                          child: Image.asset(
                            'images/vd.png',
                            width: 150,
                            height: 200,
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SignInButton(
                            Buttons.LinkedIn,
                            mini: true,
                            onPressed: () {},
                          ),
                          SignInButton(
                            Buttons.Email,
                            mini: true,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 260,
                  width: 150,
                  color: Colors.black12,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                          child: Image.asset(
                            'images/at.png',
                            width: 150,
                            height: 200,
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SignInButton(
                            Buttons.LinkedIn,
                            mini: true,
                            onPressed: () {},
                          ),
                          SignInButton(
                            Buttons.Email,
                            mini: true,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

