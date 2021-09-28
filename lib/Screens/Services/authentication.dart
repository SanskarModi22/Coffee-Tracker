import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firestore/Models/user.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  MyUser? _userfromFirebase(User user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }
  Stream <MyUser?> get user{

    return _auth.authStateChanges().map((User? user) => _userfromFirebase(user!));
  }

  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userfromFirebase(user!);
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return null;
    }
  }
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}
