import 'dart:ui';

import 'package:bulls_and_cows/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

import 'connection.dart';
import 'jeu.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack);
    return true;
  };

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bulls and Cows',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      /*routes: {
        '/': (context) => MyApp(),
        '/jeu': (context) => Jeu(),
        '/home' : (context) => Home(),
      },*/
      debugShowCheckedModeBanner: false,
      //initialRoute: '/',
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.userChanges(),
          builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
            if(snapshot.hasData) {
              return Home();
            } else {
              return Connection();
            }
          },
        )
    );
  }
}
