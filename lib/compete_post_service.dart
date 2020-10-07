import 'package:example/compete_post.dart';
import 'package:firebase_database/firebase_database.dart';


class CompetePostService{
  String nodeName = "compete";
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference _databaseReference;
  Map post;

  CompetePostService(this.post);

  addPost(){
//    this is going to give a reference to the posts node
    database.reference().child(nodeName).push().set(post);
  }

  deletePost(){
    database.reference().child('$nodeName/${post['key']}').remove();
  }

  updatePost(){
    database.reference().child('$nodeName/${post['key']}').update(
        {"title": post['title'], "date":post['date']}
    );
  }
}