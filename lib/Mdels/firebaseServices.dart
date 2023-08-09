

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  final FirebaseAuth user_instance = FirebaseAuth.instance;

  Future signUp(String username) async {
    try {
      UserCredential userCredential = await user_instance.signInAnonymously();
      final User? user = userCredential.user;

      Map<String, dynamic> memberMap = {
        "username": username,
        "uid": user?.uid,
        "date_created": DateTime.now().millisecondsSinceEpoch,
        "tentative_record": 0,
      };

      addUserToFirebase(memberMap);
      return user;
    } on FirebaseAuthException catch (e) {
      print("${e.code} : ${e.message}");
    }

  }

  static final firestroreInstance = FirebaseFirestore.instance;
  final fire_user = firestroreInstance.collection("Users");

  addUserToFirebase(Map<String, dynamic> mapp) {
    fire_user.doc(mapp["uid"]).set(mapp);
  }

  changeRecord(int new_record){
    fire_user.doc(user_instance.currentUser!.uid).update({'tentative_record' : new_record});
  }

}