
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:google_sign_in/google_sign_in.dart';


class AuthProvider{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  signInWithEmail(String email, String password) async{
    try {
      User user = (await _auth.signInWithEmailAndPassword(
          email: email, password: password)).user;
      if (user != null){
        return true;
      }
      else{
        return false;
      }
    }
    catch(e){
      return false;
    }
  }

  Future<void> logOut() async{
    try {
      await _auth.signOut();
    }
    catch(e) {
      print("logout failed");
    }
  }

  Future<dynamic> loginwithGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    try
         {
      GoogleSignInAccount account = await googleSignIn.signIn();
      if (account == null) {
        return false;
      }
      UserCredential res = await _auth.signInWithCredential(
          GoogleAuthProvider.credential(
              idToken: (await account.authentication).idToken,
              accessToken: (await account.authentication).accessToken));
      if (res.user == null)
        return false;
      return true;
    }
    catch(e){
      print("login failed");
    }
  }
}
