
import 'dart:io';

import 'PostService.dart';
import 'post.dart';
import 'discover_feeds.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';


class AddPost extends StatefulWidget {
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final GlobalKey<FormState> formkey = new GlobalKey();
  final GlobalKey<FormState> keyloader = new GlobalKey();
  static File img;
  Post post = Post(0, " ", " ", " ", " ");
  File image = img;
  String uploadFileURL;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add post"),
        backgroundColor: Colors.green,
        elevation: 0.0,
      ),
      body: Form(
          key: formkey,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "Post Title",
                      border: OutlineInputBorder()
                  ),
                  onSaved: (val) => post.title = val,
                  validator: (val){
                    if(val.isEmpty){
                      return "title field cant be empty";
                    }else if(val.length > 16){
                      return "title cannot have more than 16 characters ";
                    }
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "Author Name",
                      border: OutlineInputBorder()
                  ),
                  onSaved: (val) => post.author = val,
                  validator: (val){
                    if(val.isEmpty){
                      return "Name field cant be empty";
                    }else if(val.length > 16){
                      return "Name cannot have more than 16 characters";
                    }
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: image == null ? RaisedButton(onPressed: (){chooseFile();},
                    child: Text('Choose Theme Image'),
                  ):Container(
                    child: AspectRatio(
                        aspectRatio: 5/3,
                        child: Image.file(image, width: 500, height: 300, fit: BoxFit.fill,)),
                  )
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 400,

                  child: TextFormField(
                    maxLines: 500,
                    decoration: InputDecoration(
                        hintText: "Post Body",
                        border: OutlineInputBorder(),
                    ),
                    onSaved: (val) => post.body = val,
                    validator: (val){
                      if(val.isEmpty){
                        return "body field cant be empty";
                      }
                    },
                  ),
                ),
              ),
            ],
          )),
      floatingActionButton: FloatingActionButton(onPressed: (){
        insertPost(context);

        //Navigator.pop(context);
//        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
      },

        child: Icon(Icons.add, color: Colors.white,),
        backgroundColor: Colors.green,
        tooltip: "add a post",),
    );
  }

  void insertPost(context) async{
    final FormState form = formkey.currentState;
    if(form.validate()){
      form.save();
      form.reset();
      post.date = DateTime.now().millisecondsSinceEpoch;
      if(image != img) {
        print(post.date.toString() + '.jpg');
        final StorageReference firebaseStorage = FirebaseStorage.instance.ref()
            .child(post.date.toString() + '.jpg');
        final StorageUploadTask task = firebaseStorage.putFile(image);
        Dialogs.showLoadingDialog(context, keyloader);
        await task.onComplete;
        uploadFileURL = await firebaseStorage.getDownloadURL();

        print(uploadFileURL);
        if (uploadFileURL.isNotEmpty) {
          post.image = uploadFileURL;
        }

        Navigator.of(keyloader.currentContext,rootNavigator: true).pop();
      }
      PostService postService = PostService(post.toMap());
      postService.addPost();
      Navigator.pop(context);
    }
  }

  Future chooseFile() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((images) async{
      setState(() {
        image = images;
      });
    });
  }

}

class Dialogs {
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: key,
                  backgroundColor: Colors.black54,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 10,),
                        Text("Please Wait....",style: TextStyle(color: Colors.blueAccent),)
                      ]),
                    )
                  ]));
        });
  }
}