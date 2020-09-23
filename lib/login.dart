import 'logout.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main.dart';
import 'signin.dart';
import 'discover_feeds.dart';

class LoginScreen extends StatefulWidget {

  @override

  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Color primaryColor = Color(0xff18203d);
  final Color secondaryColor = Color(0xff232c51);

  final Color logoGreen = Color(0xff25bcbb);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(

        appBar: AppBar(

          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: primaryColor,
        body: Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Sign in to Health Network',
                  textAlign: TextAlign.center,
                  style:
                      GoogleFonts.openSans(color: Colors.white, fontSize: 28),
                ),
                SizedBox(height: 20),
                Text(
                  'Enter your Email and password below to join a network where you can know lots of thing related to your health!!',
                  textAlign: TextAlign.center,
                  style:
                      GoogleFonts.openSans(color: Colors.white, fontSize: 14),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      color: secondaryColor,
                      border: Border.all(color: Colors.blue)),
                  child: TextField(
                    controller: nameController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        labelText: 'Username',
                        labelStyle: TextStyle(color: Colors.white),
                        icon: Icon(
                          Icons.account_circle,
                          color: Colors.white,
                        ),
                        // prefix: Icon(icon),
                        border: InputBorder.none),
                  ),
                ),
                SizedBox(height: 20),
                Container(

                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      color: secondaryColor,
                      border: Border.all(color: Colors.blue)),
                  child: TextField(
                    controller: passwordController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.white),
                        icon: Icon(
                          Icons.lock,
                          color: Colors.white,
                        ),
                        // prefix: Icon(icon),
                        border: InputBorder.none),
                  ),
                ),
                SizedBox(height: 30),
                MaterialButton(
                  elevation: 0,
                  minWidth: double.maxFinite,
                  height: 50,
                  onPressed: () async {
                    if(nameController.text.isEmpty || passwordController.text.isEmpty){
                      print("empty");
                      return;
                    }
                    bool res = await AuthProvider().signInWithEmail(
                        nameController.text,
                        passwordController.text);
                    if (!res) {
                      print("login failed");
                    }
                    else{
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MyApp()));
                    }
                  },
                  color: logoGreen,
                  child: Text('Login',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                  textColor: Colors.white,
                ),
                SizedBox(height: 20),
                MaterialButton(
                  elevation: 0,
                  minWidth: double.maxFinite,
                  height: 50,
                  onPressed: () async {
                    bool res = await AuthProvider().loginwithGoogle();
                    if(!res)
                      print("error");
                    else{
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MyApp()));
                    }
                  },
                  color: Colors.blue,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(FontAwesomeIcons.google),
                      SizedBox(width: 10),
                      Text('Sign-in using Google',
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                    ],
                  ),
                  textColor: Colors.white,
                ),
                SizedBox(height: 100),
              ],
            ),
          ),
        ));
  }
}
