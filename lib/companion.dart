import 'package:flutter/material.dart';
import './chat.dart';
import './feed.dart';
import './drawer.dart';
import './requests.dart';
import 'signin.dart';
import 'tiles.dart';
import 'main.dart';
import 'discover_feeds.dart';



class HomePage extends StatelessWidget {
  Function person;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          drawer: NavDrawer(),
          appBar: AppBar(
            backgroundColor: Colors.green,
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.face),
                  text: 'Requests',
                ),
                Tab(
                  icon: Icon(Icons.image),
                  text: 'Feed',
                ),
                Tab(
                  icon: Icon(Icons.chat),
                  text: 'Chat',
                ),
              ],
            ),
            title: Text('Companion'),
          ),
          body: TabBarView(
            children: [Requests(), Feed(), Home()],
          ),
        ),
      ),
    );
  }
}


class NavDrawer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(

            child: Text(
              'Assets',
              style: TextStyle(color: Colors.blue, fontSize: 25),
            ),
            decoration: BoxDecoration(
              color: Colors.lightBlue,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage("https://image.freepik.com/free-photo/stethoscope-blue-background-top-view-space-text_185193-6316.jpg"),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Companion'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.rss_feed),
            title: Text('Discover'),
            onTap: () => Navigator.push(context, new MaterialPageRoute
              (builder: (context)=> MyApp() )),
          ),
          ListTile(
            leading: Icon(Icons.compare),
            title: Text('Compete'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
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
  logout(context){
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
