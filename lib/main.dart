import 'package:flutter/material.dart';

import 'jeu.dart';

void main() {
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
      routes: {
        '/': (context) => MyHomePage(),
        '/jeu': (context) => Jeu(),
      },
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("🐮 Bulls and Cows"),
        centerTitle: true,
        elevation: 10.0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "BIENVENUE SUR LE JEU 🐮 (meuuuh)",
              style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 3.0),
            ),
            SizedBox(
              width: 512 / 2,
              height: 512 / 2,
              child: Image.asset("assets/bull.png"),
            ),
            Divider(
              thickness: 10.0,
              indent: 50.0,
              endIndent: 50.0,
              color: Colors.amber.shade900,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  alert("📖 | Règle",
                      "L'algorithme génère automatiquement un nombre aléatoire à 4 chiffres.\nLe but est de retrouver ce nombre si dans votre proposotion un chiffre est à la bonne place alors il renvera 'bulls' si le chiffre est mal placé 'cows' et le chiffre est incorrect rien du tout\n\n Le jeu s'arrête à 60 tentatives");
                });
              },
              child: Text("Règles"),
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    Navigator.pushNamed(context, '/jeu');
                  });
                },
                child: Text("Commencer")),
          ],
        ),
      ),
    );
  }

  Future<void> alert(
      title,
      msg,
      ) async {
    Widget cancelButton = TextButton(
      child: Text(
        "Ok",
        style: TextStyle(color: Colors.amberAccent),
      ),
      onPressed: () {
        setState(() {
          Navigator.pop(context);
        });
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(msg),
      actions: [
        cancelButton,
      ],
    );

    // show the dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
