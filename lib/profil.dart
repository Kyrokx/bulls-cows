import 'dart:async';

import 'package:bulls_and_cows/Mdels/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Mdels/firebaseServices.dart';
import 'Mdels/member.dart';

class Profil extends StatefulWidget {
  late String memberUid;
  Profil({required this.memberUid});
  @override
  State<StatefulWidget> createState() {
    return new ProfilState();
  }
}

class ProfilState extends State<Profil> {
  late StreamSubscription streamSubscription;
  Member? member;
  final current_user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    streamSubscription = FirebaseServices()
        .fire_user
        .doc(current_user!.uid)
        .snapshots()
        .listen((event) {
      setState(() {
        member = Member(event);
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Users').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
                appBar: AppBar(
                  title: Text(member!.username),
                ),
                body: ListView(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    return ListTile(
                      leading: Icon(Icons.account_circle),
                      title: Text("🧑 | Speudonyme : ${data['username']}"),
                      subtitle:
                          Text("🏆 | Record: ${data['tentative_record']}"),
                    );
                  }).toList(),
                ));
          } else {
            return Loading();
          }
        });
  }
}
