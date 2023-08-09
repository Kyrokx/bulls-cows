import 'package:bulls_and_cows/Mdels/firebaseServices.dart';
import 'package:flutter/material.dart';

class Connection extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ConnectionState();
  }
}

class ConnectionState extends State<Connection> {

  late TextEditingController username_controller;

  @override
  void initState() {
    super.initState();
    username_controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    username_controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Inscrivez vous anonimement",
              style: TextStyle(
                fontSize: 25.0,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(color: Colors.amber)),
              width: MediaQuery.of(context).size.width / 1.5,
              child: TextField(
                textInputAction: TextInputAction.done,
                controller: username_controller,
                decoration: InputDecoration(
                  label: Text("Entrez votre speudonyme"),
                  icon: Icon(Icons.supervised_user_circle),
                  hintText: "@",
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 15,
              width: MediaQuery.of(context).size.width / 1.5,
              decoration: BoxDecoration(
                //color: Colors.black,//Color(0xffFCFCFC),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    check();
                  });
                },
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            side: BorderSide(color: Colors.amber))),
                    backgroundColor: MaterialStatePropertyAll(Colors.white)),
                child: Text(
                  "C'est parti",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  check() {
    if(username_controller.text.length != 0 && username_controller.text != "") {
      if(username_controller.text.length > 14) {
        alert("Erruer", "Le nombre de caractère doit être inférieur à 14");
      } else {
        FirebaseServices().signUp(username_controller.text);
      }
    } else {
      alert("Erreur", "Entrez une valeur");
    }
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
