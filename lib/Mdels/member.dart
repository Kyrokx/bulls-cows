

import 'package:cloud_firestore/cloud_firestore.dart';

class Member{
  late String uid;
  late String username;
  late int date_created;
  late int tentative_record;


  late DocumentReference ref;

  Member(DocumentSnapshot snapshot) {
    ref = snapshot.reference;
    uid = snapshot.id;
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
    username = data?["username"];
    date_created = data?["date_created"];
    tentative_record = data?["tentative_record"];
  }

}