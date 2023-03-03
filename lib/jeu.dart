import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Jeu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new JeuState();
  }
}

class JeuState extends State<Jeu> {
  late TextEditingController controller;
  late TextEditingController controller2;

  late List number_array = ['1', '2', '3', '4', '5', '6', '7', '8', '9'];

  @override
  void initState() {
    controller = TextEditingController()
      ..addListener(() {
        setState(() {});
      });

    controller2 = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    controller2.dispose();
    super.dispose();
  }

  late var gues_array = shuffle(number_array).getRange(0, 4);

  var bulls = 0;
  var cows = 0;
  var tentatives = 0;
  String indice = "";

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Colors.amber.shade200,
        appBar: new AppBar(
          title: Text("Bulls and Cows"),
          centerTitle: true,
          backgroundColor: Colors.amber.shade200,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  elevation: 15.0,
                  shadowColor: Colors.amber.shade900,
                  child: Container(
                    width: width * 0.9,
                    height: height * 0.7,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  left: 10.0, right: 10.0, bottom: 10.0),
                              width: width / 3,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(color: Colors.grey)),
                              child: TextField(
                                onSubmitted: (str) {
                                  setState(() {
                                    jeu();
                                    controller.clear();
                                  });
                                },
                                keyboardType: TextInputType.number,
                                controller: controller,
                                decoration: InputDecoration(
                                  hintText: "Ex : 1309",
                                ),
                              ),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    jeu();
                                    controller.clear();
                                  });
                                },
                                child: Text("OK")),
                          ],
                        ),
                        Divider(
                          thickness: 10.0,
                          indent: 50.0,
                          endIndent: 50.0,
                          color: Colors.amber.shade600,
                        ),
                        Text(indice),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: Colors.grey)),
                          width: width * 0.8,
                          height: height * 0.3,
                          child: TextFormField(
                            minLines: null,
                            maxLines: null,
                            expands: true,
                            controller: controller2,
                            readOnly: true,
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                hoverColor: Colors.white,
                                focusColor: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  List shuffle(List array) {
    var random = Random(); //import 'dart:math';

    // Go through all elementsof list
    for (var i = array.length - 1; i > 0; i--) {
      // Pick a random number according to the lenght of list
      var n = random.nextInt(i + 1);
      var temp = array[i];
      array[i] = array[n];
      array[n] = temp;
    }
    return array;
  }

/*
['1','2','3','4','5','6','7','8','9']
[1,2,3,4,5,6,7,8,9]
 */

  jeu() {
    var guess_numbers_choised_array = gues_array.toList();

    if (tentatives == 40) {
      setState(() {
        indice = "Indice : **${guess_numbers_choised_array[2]}*";
      });
    }
    if (tentatives == 50) {
      setState(() {
        indice =
            "Indice : *${guess_numbers_choised_array[1]}${guess_numbers_choised_array[2]}*";
      });
    }

    bulls = 0;
    cows = 0;
    var guess_numbers_choised = gues_array.toList().join("");
    print(guess_numbers_choised);

    if (controller.text.length != 4) {
      alert("⛔ | Erreur",
          "Votre nombre doit contenir uniquement quatre (4) caractères", false);
    } else if (int.parse(controller.text) == 1234 ||
        int.parse(controller.text) == 6789) {
      alert("⛔ | Erreur", "Votre nombre doit être different de 1234 et 6789",
          false);
    } else {
      tentatives++;
      var number_entred = (controller.text);

      for (var i = 0; i < 4; i++) {
        if (guess_numbers_choised[i] == number_entred[i]) {
          bulls++;
        } else if (guess_numbers_choised.contains(number_entred[i])) {
          cows++;
        }
      }

      controller2.text +=
          "${tentatives} - ${number_entred} ${bulls}bulls | ${cows}cows en ${tentatives} tentatives\n";
    }

    if (tentatives == 60) {
      alert(
          "⛔ | Erreur",
          "Vous avez atteint 60 tentatives. Vous avez perdu ! Le nombre mystère etait ${guess_numbers_choised}",
          true);
    } else if (bulls == 4) {
      alert(
          "🎊 | Félicitaions",
          "Vous avez trouvez le bon nombre qui était ${guess_numbers_choised} en ${tentatives} tentatives",
          true);
    }
  }

  Future<void> alert(title, msg, bool oui) async {
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

    Widget cancelButto = TextButton(
      child: Text(
        "Ok",
        style: TextStyle(color: Colors.amberAccent),
      ),
      onPressed: () {
        setState(() {
          Navigator.pop(context);
          Navigator.pop(context);
        });
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(msg),
      actions: [
        oui ? cancelButto : cancelButton,
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
