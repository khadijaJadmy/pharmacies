import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:pharmacie/categories/model/medModel.dart';

import 'package:qr_flutter/qr_flutter.dart';

class GeneratePage extends StatefulWidget {
  String dataMed, dataClient;
  GeneratePage(this.dataMed);

  @override
  State<StatefulWidget> createState() => GeneratePageState();
}

class GeneratePageState extends State<GeneratePage> {
  List<MedicamentModel> medicaments = [];
  MedicamentModel medicament;
  ScrollController scrollController = new ScrollController();
  // already generated qr code when the page opens
  // Future<void> getMedList() async {
  //   // print(query);
  //   // if (query != "") {
  //   // queryData(widget.searchText);

  //   QuerySnapshot featureSnapShot1 = await FirebaseFirestore.instance
  //       .collection("commande")
  //       .doc(widget.commandeId)
  //       .collection("medicament")
  //       .get();
  //   print(widget.commandeId);
  //   featureSnapShot1.docs.forEach(
  //     (element) {
  //       medicament = MedicamentModel(
  //           nomMedicament: element.data()["medicamentName"],
  //           quantite: element.data()['quantite']);

  //       setState(() {
  //         medicaments.add(medicament);
  //       });
  //       String dataM =
  //           " Medicament :${medicament.nomMedicament} , quantité: ${medicament.quantite} \n";
  //       print(dataM);
  //     },
  //   );
  // }

  // @override
  // Future<void> initState() {
  //   super.initState();
  //   // getListProf();
  //   getMedList();
  //   print(medicaments);
  // }

  @override
  Widget build(BuildContext context) {
    print(widget.dataMed);
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Command'),
        actions: <Widget>[],
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              QrImage(
                //plce where the QR Image will be shown
                data: widget.dataMed,
              ),

              SizedBox(
                height: 40.0,
              ),
              Text(
                " Scan Your QR Code To Get Command Infos",
                style: TextStyle(fontSize: 20.0),
              ),

              // TextField(
              //   controller: qrdataFeed,
              //   decoration: InputDecoration(
              //     hintText: "Input your link or data",
              //   ),
              // ),
              // Padding(
              //   padding: EdgeInsets.fromLTRB(40, 20, 40, 0),
              //   child: FlatButton(
              //     padding: EdgeInsets.all(15.0),
              //     onPressed: () async {
              //     //   if (qrdataFeed.text.isEmpty) {
              //     //     //a little validation for the textfield
              //     //     setState(() {
              //     //       qrData = "";
              //     //     });
              //     //   } else {
              //     //     setState(() {
              //     //       qrData = qrdataFeed.text;
              //     //     });
              //     //   }
              //     // },
              //   //   child: Text(
              //   //     "Generate QR",
              //   //     style: TextStyle(
              //   //         color: Colors.blue, fontWeight: FontWeight.bold),
              //   //   ),
              //   //   shape: RoundedRectangleBorder(
              //   //       side: BorderSide(color: Colors.blue, width: 3.0),
              //   //       borderRadius: BorderRadius.circular(20.0)),
              //   // ),
              // )
            ],
          ),
        ),
      ),
    );
  }

  // final qrdataFeed = TextEditingController();
}
