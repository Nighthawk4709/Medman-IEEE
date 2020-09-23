import 'package:example/write_feeds.dart';
import 'package:example/signin.dart';
import 'package:flutter/material.dart';
import 'companion.dart';
import 'write_feeds.dart';
import 'main.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Health Network",
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 8,
        child: Scaffold(
          drawer: NavDrawer(),
          appBar: AppBar(

              backgroundColor: Colors.lightBlue,

              title: Text("HEALTH NETWORK"),
              actions: <Widget>[
                IconButton(icon: Icon(Icons.search), onPressed: () {}),
              ],
              bottom: TabBar(tabs: <Widget>[
                Tab(icon: Icon(Icons.category)),
                Text("1"),
                Tab(icon: Icon(Icons.category)),
                Text("2"),
                Tab(icon: Icon(Icons.category)),
                Text("3"),
                Tab(icon: Icon(Icons.category)),
                Text("4"),
              ])),
          body: ListView.builder(
            itemCount: 10,
              itemBuilder: (context,index) =>
                  Card(
                    child: Container(
                      height: 350.0,
                      color: Colors.lightBlue,
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            leading: CircleAvatar(backgroundImage: NetworkImage("https://cdn3-www.comingsoon.net/assets/uploads/2016/12/bossbabytrailer.jpg"),),

                            title: Text("Feed title"),
                            subtitle: Text("Author name"),
                          ),
                          //In this part use this part to show articles
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
                                  RaisedButton.icon(onPressed: () {}, icon: Icon(Icons.thumb_up, color: Colors.lightBlueAccent ), label: Text("Like") ,color: Colors.white,),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  RaisedButton.icon(onPressed: () {}, icon: Icon(Icons.comment, color: Colors.lightBlueAccent ), label: Text("Comment") ,color: Colors.white,),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  RaisedButton.icon(onPressed: () {}, icon: Icon(Icons.share, color: Colors.lightBlueAccent ), label: Text("Share") ,color: Colors.white,),
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 12.0),
                        ],
                      ),
                    ),
                  ),
          ),
           floatingActionButton: FloatingActionButton(
               onPressed: (){Navigator.push(context,
                   MaterialPageRoute(builder: (context) => AddPost()));},
              child : Icon(Icons.add),
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
            onTap: () => Navigator.push(context, new MaterialPageRoute
              (builder: (context)=> HomePage() )),
          ),
          ListTile(
            leading: Icon(Icons.rss_feed),
            title: Text('Discover'),
            onTap: () => {Navigator.of(context).pop()},
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
