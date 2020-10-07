
import 'compete_post.dart';
import 'compete_post_service.dart';
import 'package:flutter/material.dart';

class AddCompete extends StatefulWidget {
  @override
  _AddCompeteState createState() => _AddCompeteState();
}

class _AddCompeteState extends State<AddCompete> {
  final GlobalKey<FormState> formkey = new GlobalKey();
  ComepetePost post = ComepetePost(0, " ", " ");
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
                      labelText: "Compete Title(For ex: pushups, running etc)",
                      border: OutlineInputBorder()
                  ),
                  onSaved: (val) => post.title = val,
                  validator: (val){
                    if(val.isEmpty){
                      return "title field cant be empty";
                    }else if(val.length > 20){
                      return "title cannot have more than 16 characters ";
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "Challenger",
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
            ],
          )),
      floatingActionButton: FloatingActionButton(onPressed: (){
        insertPost(context);

        //Navigator.pop(context);
//        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
      },

        child: Icon(Icons.add, color: Colors.white,),
        backgroundColor: Colors.green,
        tooltip: "Add a post",),
    );
  }

  void insertPost(context) {
    final FormState form = formkey.currentState;
    if(form.validate()){
      form.save();
      form.reset();
      post.date = DateTime.now().millisecondsSinceEpoch;
      CompetePostService postService = CompetePostService(post.toMap());
      postService.addPost();
      Navigator.pop(context);
    }
  }
}
