import 'package:example/compete.dart';
import 'package:example/signin.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'companion.dart';
import 'discover_feeds.dart';
import 'main.dart';

class profile extends StatefulWidget {
  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  GoogleSignIn googleSignIn = GoogleSignIn();
  String userId = " ";
  int created = 1600983164915137;
  String pic= " ";
  String name= " ";

  @override
  void initState() {
    getUserId();
    super.initState();
  }

  getUserId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userId = sharedPreferences.getString('id');
      print(sharedPreferences.getInt('created_at'));

      pic = sharedPreferences.getString('profile_pic');
      name = sharedPreferences.getString('name');
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: const Text('Profile'),

        actions: [
          IconButton(icon: Icon(Icons.settings, color: Colors.white,), onPressed: null)
        ],
      ),
      body: Container(
        color: Colors.black87,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Spacer(),
                      Center(child:
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 250,
                          height: 250,
                          child: CircleAvatar(
                            radius: 20.0,
                            backgroundImage: NetworkImage(pic),
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      ),
                      ),
                      Spacer(),
                    ],
                  ),
                  Container(height: 20,),
                  Row(
                    children: <Widget>[
                      Spacer(),
                      Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
                      Spacer(),
                    ],
                  ),
                  Divider(color: Colors.black, thickness: 0.5,),

                  Container(height: 20,),
                  Row(
                    children: <Widget>[
                      //Spacer(),
                      Container(width: 20,),
                  Center(
                  child: Text("Achievements: ",
          style: TextStyle(fontSize: 30.0),),
      ),
                      //Spacer(),
                    ],
                  ),
                  Divider(color: Colors.transparent,),
                  Row(
                    children: <Widget>[
                      Spacer(),
                      Center(
                        child: Text("Coming Soon...",
                          style: TextStyle(fontSize: 40.0, color: Colors.grey),),
                      ),
                      Spacer(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Row(
              children: [
                Container(
                  width: 140,
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('images/logo.png'),
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[
                    Spacer(),
                    Text(
                      'Health',
                      style: TextStyle(
                          color: Colors.cyan[800],
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Network',
                      style: TextStyle(
                          color: Colors.cyan[800],
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    Spacer(),
                  ],
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.grey[300],
            ),
          ),
          ListTile(
            leading: Icon(Icons.group),
            title: Text('Companion'),
            onTap: () => Navigator.push(context,
                new MaterialPageRoute(builder: (context) => HomePage())),
          ),
          ListTile(
            leading: Icon(Icons.rss_feed),
            title: Text('Discover'),
            onTap: () => Navigator.push(
                context, new MaterialPageRoute(builder: (context) => MyApp())),
          ),
          ListTile(
            leading: Icon(Icons.compare),
            title: Text('Compete'),
            onTap: () => Navigator.push(
                context, new MaterialPageRoute(builder: (context) => MyStatefulWidget())),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            tileColor: Colors.grey[300],
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => logout(context),
          ),
        ],
      ),
    );
  }

  logout(context) {
    AuthProvider().logOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => home(),
      ),
      (route) => false,
    );
  }
}
