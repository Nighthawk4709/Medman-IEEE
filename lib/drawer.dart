import 'package:flutter/material.dart';
import 'discover_feeds.dart';


class NavDrawer extends StatelessWidget {
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
                image: NetworkImage(
                    "https://image.freepik.com/free-photo/stethoscope-blue-background-top-view-space-text_185193-6316.jpg"),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Companion'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.rss_feed),
            title: Text('Discover'),
            onTap: () => Navigator.push(context,new MaterialPageRoute
              (builder: (context) => MyApp(),)
            ),
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
            onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }
}
