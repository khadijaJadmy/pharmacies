import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharmacie/categories/database/db.dart';
import 'package:pharmacie/categories/generate.dart';
import 'package:pharmacie/categories/model/medModel.dart';
import 'package:pharmacie/ui/anotherhome/constants.dart';

import 'package:random_string/random_string.dart';

import 'commandeForm.dart';

class MedicamentFormScreen extends StatefulWidget {
  final String commandeId;
  String jsonString;

  MedicamentFormScreen(this.commandeId, this.jsonString);
  @override
  State<StatefulWidget> createState() {
    return MedicamentFormScreenState();
  }
}

class MedicamentFormScreenState extends State<MedicamentFormScreen> {
  String medicamentName;
  String quantite;
  String dosage;
  String forme;
  String phoneNumber;
  DatabaseService databaseService = new DatabaseService();
  final _formKey = GlobalKey<FormState>();
  bool circular = false;
  bool isLoading;
  String commandeId;
  bool centerCircle;
  List<MedicamentModel> medicaments = [];
  MedicamentModel medicament;
  TextEditingController dosageController = new TextEditingController();

  TextEditingController nameController = new TextEditingController();
  TextEditingController formController = new TextEditingController();
  TextEditingController quantityController = new TextEditingController();

  // Future<void> getMedList() async {
  //   // print(query);
  //   // if (query != "") {
  //   // queryData(widget.searchText);

  //   QuerySnapshot featureSnapShot1 = await FirebaseFirestore.instance
  //       .collection("commande")
  //       .doc(widget.commandeId)
  //       .collection("medicament")
  //       .get();
  //   print(commandeId);
  //   featureSnapShot1.docs.forEach(
  //     (element) {
  //       medicament = MedicamentModel(
  //           nomMedicament: element.data()["medicamentName"],
  //           quantite: element.data()['quantite']);
  //       setState(() {
  //         medicaments.add(medicament);
  //       });
  //     },
  //   );
  // }

  // already generated qr code when the page opens
  Future<void> getMedList() async {
    // print(query);
    // if (query != "") {
    // queryData(widget.searchText);

    QuerySnapshot featureSnapShot1 = await FirebaseFirestore.instance
        .collection("commande")
        .doc(widget.commandeId)
        .collection("medicament")
        .get();
    print(widget.commandeId);
    featureSnapShot1.docs.forEach(
      (element) {
        medicament = MedicamentModel(
            nomMedicament: element.data()["medicamentName"],
            quantite: element.data()['quantite']);

        setState(() {
          medicaments.add(medicament);
        });
        print("CMAS CME");
        print(medicaments);
        // String dataM =
        //     " Medicament :${medicament.nomMedicament} , quantit??: ${medicament.quantite} \n";
        // print("dokhlo");
        // print(dataM);
        // List<MedicamentModel> m = medicaments;
        // String myData = m.join();
        // print(myData.toString());
      },
    );
    List<String> MaList = List();
    for (var ele in medicaments) {
      MaList.add(
          " Medicament:" + ele.nomMedicament + " , quantit??:" + ele.quantite);
    }

    String listData =
        widget.jsonString + "Infos Sur la commande \n " + MaList.join("\n");
    FirebaseFirestore.instance
        .collection('commande')
        .doc(widget.commandeId)
        .update({'qrCode': listData});
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            // builder: (context) => GeneratePage(listData, commandeId)));
            builder: (context) => GeneratePage(listData, widget.commandeId)));
  }

  createCommandeMed() {
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      Map<String, dynamic> medData = {
        // "medicamentName": medicamentName,
        // "quantite": quantite,
        // "dosage": dosage,
        // "forme": forme
        "medicamentName": nameController.text,
        "quantite": quantityController.text,
        "dosage": dosageController.text,
        "forme": formController.text
      };

      // String data =
      //     " Medicament :${medicamentName} \n quantit??: ${quantite} \n ${widget.jsonString}";
      // print(data);
      databaseService.addMedData(medData, widget.commandeId).then((value) {
        setState(() {
          isLoading = false;

          dosageController.clear();
          formController.clear();
          quantityController.clear();
          nameController.clear();
        });

        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => GeneratePage(widget.commandeId)));
      });
      // getMedList();
    }
  }

  Widget _builmedicamentName() {
    return TextFormField(
      controller: nameController,
      decoration: InputDecoration(
          labelText: 'Medicament', icon: Icon(Icons.medical_services)),
      keyboardType: TextInputType.url,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Medicament is Required';
        }

        return null;
      },
      // onChanged: (String value) {
      //   medicamentName = value;
      // },
    );
  }

  Widget _buildquantite() {
    return TextFormField(
      controller: quantityController,
      decoration: InputDecoration(
          labelText: 'Quantit??', icon: Icon(Icons.production_quantity_limits)),
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Quantit?? is Required';
        }

        return null;
      },
      // onChanged: (String value) {
      //   quantite = value;
      // },
    );
  }

  Widget _buildDosage() {
    return TextFormField(
      controller: dosageController,
      decoration:
          InputDecoration(labelText: 'Dosage', icon: Icon(Icons.description)),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Dosage is Required';
        }

        return null;
      },
      // onChanged: (String value) {
      //   dosage = value;
      // },
    );
  }

  Widget _buildForme() {
    return TextFormField(
      controller: formController,
      decoration:
          InputDecoration(labelText: 'Forme', icon: Icon(Icons.description)),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Forme is Required';
        }

        return null;
      },
      // onChanged: (String value) {
      //   forme = value;
      // },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: BackButton(
            color: Colors.white,
            onPressed: () {
              // Navigator.of(context).pop();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FormScreen(),
                  ));
            },
          ),
          title:Text("Ajouter les medicaments",style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white),),
          backgroundColor: kPrimaryColor,
        ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _builmedicamentName(),
                SizedBox(
                  height: 10,
                ),
                _buildquantite(),
                SizedBox(
                  height: 10,
                ),
                _buildDosage(),
                SizedBox(
                  height: 10,
                ),
                _buildForme(),
                SizedBox(
                  height: 100,
                ),

                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          createCommandeMed();
                        },
                        child: Container(
                          width: 130,
                          height: 50,
                          decoration: BoxDecoration(
                            // color: Color.fromRGBO(9, 189, 180, 0.4),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                color: Color.fromRGBO(9, 189, 180, 0.4),
                                width: 2),
                          ),
                          child: Center(
                              child: Icon(
                            Icons.plus_one,
                            size: 30,
                            color: Colors.green,
                          )),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          getMedList();
                          circular = true;
                        },
                        child: Container(
                          width: 130,
                          height: 50,
                          decoration: BoxDecoration(
                            // gradient: LinearGradient(colors: [
                            //   Color.fromRGBO(9, 189, 180, 0.3),
                            //   Color.fromRGBO(9, 189, 180, 0.6),
                            //   Color.fromRGBO(9, 189, 180, 1),
                            //   Color.fromRGBO(9, 189, 180, 0.2),
                            // ]),
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(
                              "Valider",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // GestureDetector(
                //   onTap: () {
                //     createCommandeMed();
                //   },
                //   child: Container(
                //     child: Center(
                //       child: Container(
                //         width: 120,
                //         height: 40,
                //         decoration: BoxDecoration(
                //           color: Colors.teal,
                //           borderRadius: BorderRadius.circular(10),
                //         ),
                //         child: Center(
                //           child: circular
                //               ? CircularProgressIndicator()
                //               : Text(
                //                   "Ajouter",
                //                   style: TextStyle(
                //                     color: Colors.white,
                //                     fontSize: 18,
                //                     fontWeight: FontWeight.bold,
                //                   ),
                //                 ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: 30,
                // ),
                // GestureDetector(
                //   onTap: () {
                //     getMedList();
                //   },
                //   child: Container(
                //     child: Center(
                //       child: Container(
                //         width: 120,
                //         height: 40,
                //         decoration: BoxDecoration(
                //           color: Colors.teal,
                //           borderRadius: BorderRadius.circular(10),
                //         ),
                //         child: Center(
                //           child: circular
                //               ? CircularProgressIndicator()
                //               : Text(
                //                   "Valider",
                //                   style: TextStyle(
                //                     color: Colors.white,
                //                     fontSize: 18,
                //                     fontWeight: FontWeight.bold,
                //                   ),
                //                 ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
