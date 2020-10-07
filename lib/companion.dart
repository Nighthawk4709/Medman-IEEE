import 'package:example/profile.dart';
import 'package:flutter/material.dart';
import './chat.dart';
import './feed.dart';
import './drawer.dart';
import './requests.dart';
import 'compete.dart';
import 'signin.dart';
import 'tiles.dart';
import 'main.dart';
import 'discover_feeds.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    Requests(), Feed(), Home()
  ];
  _onItemTapped(int index) {
    setState(() {
      _selectedIndex  = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          drawer: NavDrawer(),
          appBar: AppBar(
            backgroundColor: Colors.green[700],
            title: Text('Companion'),

            actions: [
              IconButton(icon: Icon(Icons.search, color: Colors.white,), onPressed: null)
            ],
          ),
          body: Container(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.green[700],
            items: <BottomNavigationBarItem>[

              BottomNavigationBarItem(
                icon: Icon(Icons.face),
                label: 'Requests',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.image),
                label: 'Feed',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                label: 'Chat',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.white,
            onTap: _onItemTapped,
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
                      style: TextStyle(color: Colors.cyan[800], fontSize: 22, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Network',
                      style: TextStyle(color: Colors.cyan[800], fontSize: 22, fontWeight: FontWeight.bold),
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
            tileColor: Colors.grey[300],
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
            onTap: () => Navigator.push(context, new MaterialPageRoute
              (builder: (context)=> MyStatefulWidget() )),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () => Navigator.push(context, new MaterialPageRoute
              (builder: (context)=> profile() )),
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
