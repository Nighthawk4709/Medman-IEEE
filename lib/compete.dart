import 'package:example/profile.dart';
import 'package:flutter/material.dart';
import 'AcceptChallenge.dart';
import 'AddCompete.dart';
import 'viewCompete.dart';
import 'signin.dart';
import 'tiles.dart';
import 'main.dart';
import 'discover_feeds.dart';
import 'companion.dart';

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    viewCompete(),
    AcceptCompete(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: const Text('Compete'),
        actions: [
          IconButton(icon: Icon(Icons.search, color: Colors.white,), onPressed: null)
        ],
      ),
      body: Container(
        color: Colors.black87,
        child: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green[700],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Challenges'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done_all_rounded),
            title: Text('Accepted'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green[700],
        onPressed: (){Navigator.push(context,
            MaterialPageRoute(builder: (context) => AddCompete()));},
        child : Icon(Icons.add),
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
            onTap: () => Navigator.push(context, new MaterialPageRoute
              (builder: (context)=> HomePage() )),
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
            tileColor: Colors.grey[300],
            onTap: () => {Navigator.of(context).pop()},
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
