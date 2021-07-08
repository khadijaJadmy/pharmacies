import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharmacie/categories/database/db.dart';

import 'package:pharmacie/categories/model/client.dart';
import 'package:pharmacie/categories/qrscan.dart';
import 'package:pharmacie/ui/anotherhome/constants.dart';

import 'package:random_string/random_string.dart';

import 'category.dart';

class ScanForm extends StatefulWidget {
  final String id;
  final String adress_initial;
  ScanForm({this.id, this.adress_initial});

  @override
  State<StatefulWidget> createState() {
    return ScanFormState();
  }
}

class ScanFormState extends State<ScanForm> {
  String fullName;
  String adresse;
  String medicamentName;
  String quantite;
  String phoneNumber;
  ClientModel client;
  DatabaseService databaseService = new DatabaseService();
  TextEditingController adressInitialController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool circular = false;
  bool isLoading;
  bool centerCircle;
  String commandeId;
  String userUid;
  final FirebaseAuth auth = FirebaseAuth.instance;
  // void getUserUid() {
  // //   User myUser = FirebaseAuth.instance.currentUser;
  // //   userUid = myUser.uid;
  // //   print('USERRRRRRRRR' + userUid);
  // // }
  String name, adress, phone;

  void createCommande() async {
    final User user = auth.currentUser;
    final uid = user.uid;
    print(uid);
    commandeId = randomAlphaNumeric(16);
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      setState(() {
        centerCircle = true;
      });

      Map<String, String> profData = {
        "idClient": uid,
        "numCommande": commandeId,
        "adress":
            widget.adress_initial == null ? adresse : widget.adress_initial,
        "idPharmacy": widget.id,
        "qrCode": ""
      };
      DocumentSnapshot ds =
          await Firestore.instance.collection('Client').document(uid).get();
      name = ds.data()['name'];
      adresse = ds.data()['adress'];
      phone = ds.data()['phone'];
      List<String> MaList = List();
      MaList.add("Name:" +
          name +
          "\n" +
          " Adresse:" +
          adresse +
          "\n" +
          " Phone:" +
          phone +
          "\n");
      print(MaList);
      String listData = "Infos Sur Client \n " + MaList.join("\n");

      // String jsonString = jsonEncode(profData);
      // print(jsonString);
      // String dataClient =
      //     "Infos sur le Client : \n Nom_Client :${fullName}\n  Adresse: ${adresse}\n  Télé: ${phoneNumber}\n";

      databaseService.addcommandeData(profData, commandeId).then((value) {
        setState(() {
          isLoading = false;
        });
        // Future<void> getMedList() async {
        //   // print(query);
        //   // if (query != "") {
        //   // queryData(widget.searchText);
        //   final User user = auth.currentUser;
        //   final uid = user.uid;

        //   DocumentSnapshot ds =
        //       await Firestore.instance.collection('Client').document(uid).get();
        //   name = ds.data()['name'];
        //   adresse = ds.data()['adress'];
        //   phone = ds.data()['phone'];
        //   List<String> MaList = List();
        //   MaList.add("Name:" +
        //       name +
        //       "\n" +
        //       "Adresse:" +
        //       adresse +
        //       "\n" +
        //       "Phone:" +
        //       phone);
        //   print(MaList);
        //   String listData = "Infos Sur Client \n " + MaList.join("\n");
        // }

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => QRCodePage(commandeId, listData)));
      });
    }
  }

  Widget _buildAdress() {
    return TextFormField(
      initialValue: widget.adress_initial,
      decoration: InputDecoration(
          labelText: 'Entrer une adresse de livraison ',
          icon: Icon(Icons.home_work_outlined)),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Adress is Required';
        }

        return null;
      },
      onChanged: (String value) {
        adresse = value;
      },
    );
  }

  // Widget _builmedicamentName() {
  //   return TextFormField(
  //     decoration: InputDecoration(
  //         labelText: 'Medicament', icon: Icon(Icons.medical_services)),
  //     keyboardType: TextInputType.url,
  //     validator: (String value) {
  //       if (value.isEmpty) {
  //         return 'Medicament is Required';
  //       }

  //       return null;
  //     },
  //     onSaved: (String value) {
  //       _medicamentName = value;
  //     },
  //   );
  // }

  // Widget _buildquantite() {
  //   return TextFormField(
  //     decoration: InputDecoration(
  //         labelText: 'Quantité', icon: Icon(Icons.production_quantity_limits)),
  //     keyboardType: TextInputType.number,
  //     validator: (String value) {
  //       if (value.isEmpty) {
  //         return 'Quantité is Required';
  //       }

  //       return null;
  //     },
  //     onSaved: (String value) {
  //       _quantite = value;
  //     },
  //   );
  // }

  // Widget _buildphoneNumber() {
  //   return TextFormField(
  //     decoration: InputDecoration(
  //         labelText: 'Numéro téléphone', icon: Icon(Icons.phone_iphone)),
  //     keyboardType: TextInputType.phone,
  //     validator: (String value) {
  //       return null;
  //     },
  //     onChanged: (String value) {
  //       phoneNumber = value;
  //     },
  //   );
  // }

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
                    builder: (context) => Category(),
                  ));
            },
          ),
          title:Text("Confirmer votre adresse",style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white),),
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
                // _buildName(),
                // SizedBox(
                //   height: 10,
                // ),
                _buildAdress(),
                SizedBox(
                  height: 18,
                ),
                // _buildphoneNumber(),
                GestureDetector(
                  onTap: () {
                    createCommande();
                    circular = true;
                  },
                  // _builmedicamentName(),
                  // SizedBox(
                  //   height: 10,
                  // ),a
                  // _buildquantite(),
                  child: Container(
                    child: Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(9, 189, 180, 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: circular
                              ? CircularProgressIndicator()
                              : Text(
                                  "Valider",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
