import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:pharmacie/categories/data.dart';
import 'package:pharmacie/categories/database/db.dart';
import 'package:pharmacie/categories/generate.dart';
import 'package:pharmacie/categories/model/medModel.dart';
import 'package:pharmacie/ui/anotherhome/constants.dart';

import 'category.dart';

class QRCodePage extends StatefulWidget {
  String commandeId, listClient;
  QRCodePage(this.commandeId, this.listClient);

  @override
  _QRCodePageState createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage> {
  String result;
  Items item;
  List<Items> items = [];
  ScrollController scrollController = new ScrollController();

  TextEditingController name;
  TextEditingController price;
  TextEditingController forme;
  TextEditingController dosage;
  TextEditingController ppt;
  TextEditingController quantite = new TextEditingController();

  DatabaseService databaseService = new DatabaseService();
  final _formKey = GlobalKey<FormState>();
  bool circular = false;
  bool isLoading;
  String commandeId;
  bool centerCircle;
  List<MedicamentModel> medicaments = [];
  MedicamentModel medicament;

  Future<String> loadFromAssets() async {
    return await rootBundle.loadString('assets/data.json');
  }

  @override
  void initState() {
    super.initState();
    loadYourData();
  }

  loadYourData() async {
    String jsonString = await loadFromAssets();
    final yourDataModel = itemsFromJson(jsonString);

    for (int i = 0; i < yourDataModel.length; i++) {
      print(result);
      print(yourDataModel[i].code);
      if (yourDataModel[i].code == result) {
        print("NOMMMMMMMMM");
        print(yourDataModel[i].nom);
        items.add(yourDataModel[i]);

        print(items);
        // Do your stuff
      }
    }
  }

  createCommandeMed() {
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      Map<String, dynamic> medData = {
        "medicamentName": name.text,
        "quantite": quantite.text,
        "dosage": dosage.text,
        "forme": forme.text,
      };
      print("DAAAAAAAAAAATAAAAAAAA");
      print(medData);
      // String data =
      //     " Medicament :${medicamentName} \n quantit??: ${quantite} \n ${widget.jsonString}";
      // print(data);
      databaseService.addMedData(medData, widget.commandeId).then((value) {
        setState(() {
          isLoading = false;
          name.clear();
          dosage.clear();
          forme.clear();
          price.clear();
          ppt.clear();
          quantite.clear();
        });
        print("ADDDDDD suc");

        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => GeneratePage(widget.commandeId)));
      });
      // getMedList();
    }
  }

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
        widget.listClient + "Infos Sur la commande \n " + MaList.join("\n");
    print('MALISTTTTTTTTTTTTTTTTTTT' + listData);
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

  Future scanQR() async {
    try {
      String scanResult = await BarcodeScanner.scan();
      setState(() {
        result = scanResult;
        loadYourData();
      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          result = "Camera permission was denied";
        });
      } else {
        setState(() {
          result = "Unkown error";
        });
      }
    } on FormatException catch (e) {
      result = "Yo pressed de back button befor scanning";
    } catch (e) {
      setState(() {
        result = "Other error";
      });
    }
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
                    builder: (context) => Category(),
                  ));
            },
          ),
          title:Text("Scanner vos m??dicamenets",style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white),),
          backgroundColor: kPrimaryColor,
        ),
      body: Center(
        child: Column(children: [
          Row(children: []),
          items == null
              ? Container()
              : Expanded(
                  child: ListView.builder(
                      itemCount: items.length,
                      controller: scrollController,
                      itemBuilder: (context, index) {
                        name = TextEditingController(text: items[index].nom);
                        price = TextEditingController(text: items[index].ppv);
                        forme = TextEditingController(text: items[index].forme);
                        dosage =
                            TextEditingController(text: items[index].dosage1);
                        ppt = TextEditingController(
                            text: items[index].presentation);
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 20,
                            ),
                            new ListTile(
                                leading: const Icon(Icons.medication),
                                // title: new Text(items[index].nom),

                                // trailing: new Text(items[index].ppv),
                                title: Text('Nom_Medicament',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500)),
                                subtitle: TextFormField(
                                  controller: name,
                                )),
                            new ListTile(
                                leading: const Icon(Icons.monetization_on),
                                // title: new Text(items[index].nom),

                                // trailing: new Text(items[index].ppv),
                                title: Text('PPV',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500)),
                                subtitle: TextFormField(
                                  controller: price,
                                )),
                            new ListTile(
                                leading: const Icon(Icons.description),
                                title: Text('Forme',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500)),
                                subtitle: TextFormField(
                                  controller: forme,
                                )),
                            new ListTile(
                                leading: const Icon(Icons.description),
                                // title: new Text(items[index].nom),

                                // trailing: new Text(items[index].ppv),
                                title: Text('Pr??sentation',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500)),
                                subtitle: TextFormField(
                                  controller: ppt,
                                )),
                            new ListTile(
                                leading: const Icon(Icons.description),
                                // title: new Text(items[index].nom),

                                // trailing: new Text(items[index].ppv),
                                title: Text('Dosage',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500)),
                                subtitle: TextFormField(
                                  controller: dosage,
                                )),
                            new Container(
                                child: Form(
                                    key: _formKey,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        new ListTile(
                                            leading: const Icon(Icons
                                                .production_quantity_limits),
                                            // title: new Text(items[index].nom),

                                            // trailing: new Text(items[index].ppv),
                                            title: Text('Quantit??',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            subtitle: TextFormField(
                                              controller: quantite,
                                              decoration: InputDecoration(
                                                  hintText:
                                                      'Entrer la quantit??'),
                                              // validator: (String value) {
                                              //   if (value.isEmpty) {
                                              //     return 'Quantit?? is required';
                                              //   }

                                              //   return null;
                                              // },
                                              // onChanged: (String value) {
                                              //   quantite = value;
                                              // },
                                            )),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              child: Row(
                                                // mainAxisAlignment:
                                                // MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      createCommandeMed();
                                                    },
                                                    child: Container(
                                                      width: 100,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        // color: Color.fromRGBO(9, 189, 180, 0.4),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                15),
                                                        border: Border.all(
                                                            color: Color.fromRGBO(
                                                                9, 189, 180, 0.4),
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
                                                  SizedBox(
                                                    width: 20,
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
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                15),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          "Valider",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ))),
                          ],
                        );
                      }),
                ),
        ]),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: scanQR,
        label: Text(
          'Scan',
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
        backgroundColor: Color.fromRGBO(9, 189, 180, 0.4),
      ),
    );
  }
}
