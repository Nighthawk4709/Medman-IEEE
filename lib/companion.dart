import 'package:flutter/material.dart';
import './chat.dart';
import './feed.dart';
import './drawer.dart';
import './requests.dart';



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
            children: [Requests(), Feed(), Text('HI')],
          ),
        ),
      ),
    );
  }
}
