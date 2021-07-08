import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:pharmacie/categories/commandeForm.dart';
import 'package:pharmacie/categories/model/medModel.dart';
import 'package:pharmacie/ui/anotherhome/constants.dart';
// import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'category.dart';

class GeneratePage extends StatefulWidget {
  String dataMed, commandeId;
  GeneratePage(this.dataMed, this.commandeId);

  @override
  State<StatefulWidget> createState() => GeneratePageState();
}

class GeneratePageState extends State<GeneratePage> {
  // TextEditingController name;
  // TextEditingController price;
  // TextEditingController forme;
  // TextEditingController ppt;
  // TextEditingController dosage;
  List<MedicamentModel> medicaments = [];
  MedicamentModel medicament;
  TextEditingController name;
  TextEditingController quantite;
  TextEditingController forme;
  TextEditingController dosage;

  Future<void> getMedList() async {
    // print(query);
    // if (query != "") {
    // queryData(widget.searchText);
    print('INSIDEEEEEEEEEEEEEEEEEE  ');
    print(widget.commandeId);
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
            quantite: element.data()['quantite'],
            dosage: element.data()['dosage'],
            forme: element.data()['forme']);
        print(medicament.nomMedicament);

        setState(() {
          medicaments.add(medicament);
        });
        print("CMAS ");
        print(medicaments);
        print(medicament.nomMedicament);
        // String dataM =
        //     " Medicament :${medicament.nomMedicament} , quantité: ${medicament.quantite} \n";
        // print("dokhlo");
        // print(dataM);
        // List<MedicamentModel> m = medicaments;
        // String myData = m.join();
        // print(myData.toString());
      },
    );
    // List<String> MaList = List();
    // for (var ele in medicaments) {
    //   MaList.add(
    //       " Medicament:" + ele.nomMedicament + " , quantité:" + ele.quantite);
    // }

    // String listData =
    //     widget.jsonString + "Infos Sur la commande \n " + MaList.join("\n");
    // Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //         // builder: (context) => GeneratePage(listData, commandeId)));
    //         builder: (context) => GeneratePage(commandeId)));
  }

  @override
  initState() {
    super.initState();
    // getListProf();
    getMedList();
    print(medicaments);
  }

  @override
  Widget build(BuildContext context) {
    // getMedList();
    return Scaffold(
      appBar:  AppBar(
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
          title:Text("Scanner vos médicamenets",style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white),),
          backgroundColor: kPrimaryColor,
        ),
      body: Column(
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 0.0),
              child: QrImage(
                //plce where the QR Image will be shown
                data: widget.dataMed,
                size: 150,
                padding: EdgeInsets.only(left: 20, top: 30),
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.all(10),

                  // controller: scrollController,
                  itemCount: medicaments.length,
                  itemBuilder: (context, index) {
                    int index1 = index + 1;
                    name = TextEditingController(
                        text: medicaments[index].nomMedicament);
                    quantite = TextEditingController(
                        text: medicaments[index].quantite);
                    forme =
                        TextEditingController(text: medicaments[index].forme);
                    dosage =
                        TextEditingController(text: medicaments[index].dosage);

                    return Container(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(1, 177, 174, 0.2),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12.0)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Colors.white.withOpacity(0.6),
                              offset: const Offset(4, 4),
                              blurRadius: 16,
                            ),
                          ],
                        ),
                        child: Column(children: [
                          new ListTile(
                            // title: new Text(items[index].nom),

                            // trailing: new Text(items[index].ppv),
                            title: Text(
                              'Medicament N° $index1',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.teal),
                              textAlign: TextAlign.center,
                            ),
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
                          SizedBox(
                            height: 20,
                          ),
                          new ListTile(
                              leading:
                                  const Icon(Icons.production_quantity_limits),
                              // title: new Text(items[index].nom),

                              // trailing: new Text(items[index].ppv),
                              title: Text('Quantite',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w500)),
                              subtitle: TextFormField(
                                controller: quantite,
                              )),
                          new ListTile(
                              leading: const Icon(Icons.description),
                              // title: new Text(items[index].nom),

                              // trailing: new Text(items[index].ppv),
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
                              title: Text('Dosage',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w500)),
                              subtitle: TextFormField(
                                controller: dosage,
                              )),
                        ]));
                  }))
        ],
      ),
    );
    //     }),
  }
  //   // separatorBuilder: (context, index) {
  //   // return Divider();
  // ),
  // ListView.builder(
  //   shrinkWrap: true,
  //   itemCount: list.length,

  //   itemBuilder: (context, index) {
  //     print(list);
  //     return ListTile(
  //       trailing: Text(list[index].adresse,
  //                      style: TextStyle(
  //                        color: Colors.green,fontSize: 15),),
  //       leading: Icon(Icons.list),
  //       title: Text(list[index].numCommande),
  //       onTap : (){
  //         Navigator.push(
  //                                 context,
  //                                 MaterialPageRoute(
  //                                     builder: (context) => DetailCommande(medicaments:list[index].mediList)));
  //       }
  //     );

}
//));




























// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// import 'dart:ui';
// import 'package:flutter/rendering.dart';
// import 'package:pharmacie/categories/model/medModel.dart';
// import 'package:expansion_tile_card/expansion_tile_card.dart';
// import 'package:qr_flutter/qr_flutter.dart';

// class GeneratePage extends StatefulWidget {
//   String dataMed, dataClient, commandeId;
//   GeneratePage(this.dataMed, this.commandeId);

//   @override
//   State<StatefulWidget> createState() => GeneratePageState();
// }

// class GeneratePageState extends State<GeneratePage> {
//   TextEditingController name;
//   TextEditingController price;
//   TextEditingController forme;
//   TextEditingController ppt;
//   TextEditingController dosage;
//   List<MedicamentModel> medicaments = [];
//   MedicamentModel medicament;
//   List<String> MaList = List();
//   ScrollController scrollController = new ScrollController();
//   final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();

//   Future<void> getMedList() async {
//     print("GET MED LIST");
//     // if (query != "") {
//     // queryData(widget.searchText);
//     print(widget.commandeId);
//     List<MedicamentModel> listMedicamenet = [];
//     QuerySnapshot featureSnapShot2 = await FirebaseFirestore.instance
//         .collection("commande")
//         .doc(widget.commandeId)
//         .collection("medicament")
//         .get();
//     print(widget.commandeId);
//     featureSnapShot2.docs.forEach(
//       (element) {
//         medicament = MedicamentModel(
//             nomMedicament: element.data()["medicamentName"],
//             quantite: element.data()['quantite']);
//         print('Nom');
//         print(medicament.nomMedicament);
//         setState(() {
//           medicaments.add(medicament);
//         });
//         print("CMA");
//         print(MaList);
//         // String dataM =
//         //     " Medicament :${medicament.nomMedicament} , quantité: ${medicament.quantite} \n";
//         // print("dokhlo");
//         // print(dataM);
//         // List<MedicamentModel> m = medicaments;
//         // String myData = m.join();
//         // print(myData.toString());
//       },
//     );

//     // for (var ele in medicaments) {
//     //   MaList.add(
//     //       " Medicament:" + ele.nomMedicament + " , quantité:" + ele.quantite);
//     // }
//   }

//   // already generated qr code when the page opens
//   // Future<void> getMedList() async {
//   //   // print(query);
//   //   // if (query != "") {
//   //   // queryData(widget.searchText);

//   //   QuerySnapshot featureSnapShot1 = await FirebaseFirestore.instance
//   //       .collection("commande")
//   //       .doc(widget.commandeId)
//   //       .collection("medicament")
//   //       .get();
//   //   print(widget.commandeId);
//   //   featureSnapShot1.docs.forEach(
//   //     (element) {
//   //       medicament = MedicamentModel(
//   //           nomMedicament: element.data()["medicamentName"],
//   //           quantite: element.data()['quantite']);

//   //       setState(() {
//   //         medicaments.add(medicament);
//   //       });
//   //       String dataM =
//   //           " Medicament :${medicament.nomMedicament} , quantité: ${medicament.quantite} \n";
//   //       print(dataM);
//   //     },
//   //   );
//   // }

//   @override
//   initState() {
//     super.initState();
//     // getListProf();
//     getMedList();
//     print(medicaments);
//   }

//   Widget build(BuildContext context) {
//     print("INSIDE WIDGET");
//     getMedList();
//     return Scaffold(
//         body: Column(children: [
//       Padding(
//         padding: const EdgeInsets.symmetric(vertical: 10),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 Text(
//                   "Find your ",
//                   style: TextStyle(color: Colors.black87, fontSize: 20),
//                 ),
//               ],
//             ),
//             // Spacer(),
//             Row(
//               children: [
//                 SizedBox(
//                   width: 70,
//                 ),
//                 Text(
//                   "Commands",
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 35,
//                   ),
//                 ),
//               ],
//             ),
//             Column(
//               children: [
//                 Divider(
//                   color: Colors.black,
//                   thickness: 2,
//                   endIndent: 140,
//                   indent: 100,
//                 )
//               ],
//             )
//           ],
//         ),
//       ),
//       medicaments == null
//           ? Container()
//           : Expanded(
//               child: ListView.builder(
//                   itemCount: medicaments.length,
//                   controller: scrollController,
//                   itemBuilder: (context, index) {
//                     return Column(
//                       children: <Widget>[
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 20.0, vertical: 20),
//                           child: ExpansionTileCard(
//                             baseColor: Color.fromRGBO(9, 189, 180, 0.2),
//                             expandedColor: Colors.grey[100],
//                             key: new GlobalKey(),
//                             // trailing: Icon(Icons.question_answer),
//                             leading: Icon(
//                               Icons.question_answer,
//                               color: Color.fromRGBO(9, 189, 180, 1),
//                             ),

//                             title: Text(
//                               "Nom_Medicament : " +
//                                   medicaments[index].nomMedicament,
//                               style: TextStyle(
//                                   fontSize: 15,
//                                   // fontFamily: "Schyler",
//                                   fontWeight: FontWeight.w700),
//                             ),

//                             // subtitle: Text(products[index].category,style: TextStyle(backgroundColor: Colors.blue,color: Colors.white,fontSize: 15),),
//                             children: <Widget>[
//                               Divider(
//                                 thickness: 1.0,
//                                 height: 1.0,
//                               ),
//                               Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                     horizontal: 16.0,
//                                     vertical: 8.0,
//                                   ),
//                                   child: Column(
//                                     children: [
//                                       Text(
//                                         'Dosage:' + medicaments[index].dosage,
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .bodyText2
//                                             .copyWith(fontSize: 16),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               // ButtonBar(
//                               //   alignment: MainAxisAlignment.spaceAround,
//                               //   buttonHeight: 52.0,
//                               //   buttonMinWidth: 90.0,
//                               //   children: <Widget>[
//                               //     FlatButton(
//                               //       shape: RoundedRectangleBorder(
//                               //           borderRadius:
//                               //               BorderRadius.circular(4.0)),
//                               //       onPressed: () {
//                               //         Navigator.pushReplacement(
//                               //           context,
//                               //           MaterialPageRoute(
//                               //             builder: (context) =>
//                               //                 //MyNavigationBar(),
//                               //                 UpdateAnnounceScreen(
//                               //                     announce:
//                               //                         products[index]),
//                               //           ),
//                               //         ); // cardA.currentState?.expand();
//                               //       },
//                               //       child: Column(
//                               //         children: <Widget>[
//                               //           Icon(Icons
//                               //               .settings_applications_rounded),
//                               //           Padding(
//                               //             padding:
//                               //                 const EdgeInsets.symmetric(
//                               //                     vertical: 2.0),
//                               //           ),
//                               //           Text('Update'),
//                               //         ],
//                               //       ),
//                               //     ),
//                               //     FlatButton(
//                               //       shape: RoundedRectangleBorder(
//                               //           borderRadius:
//                               //               BorderRadius.circular(4.0)),
//                               //       onPressed: () {
//                               //         print('IIIDDD');
//                               //         print(products[index].id);
//                               //         Future<bool> result = removeAnnounce(
//                               //             products[index].id);
//                               //         //  if(result==true){
//                               //         //  products.remove(products[index]);
//                               //           ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                               //         setState(() {
//                               //           products.remove(products[index]);
//                               //           //  getSearchResult();
//                               //         });

//                               //         // getSearchResult();
//                               //         //  }
//                               //       },
//                               //       child: Column(
//                               //         children: <Widget>[
//                               //           Icon(Icons.delete),
//                               //           Padding(
//                               //             padding:
//                               //                 const EdgeInsets.symmetric(
//                               //                     vertical: 2.0),
//                               //           ),
//                               //           Text('Delete'),
//                               //         ],
//                               //       ),
//                               //     ),
//                               //   ],
//                               // ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     );
//                   }),
//             )
//       //)
//     ]));
//   }
//   // @override
//   // Widget build(BuildContext context) {
//   //   print(widget.dataMed);
//   //   return Scaffold(
//   //     appBar: AppBar(
//   //       title: Text('QR Code Command'),
//   //       actions: <Widget>[],
//   //     ),
//   //     body: Container(
//   //       child: Column(
//   //         children: [
//   //           new ListTile(
//   //             title: Text(medicament.nomMedicament),
//   //           )
//   //         ],
//   //       ),
//   //     ),
//   //   );
//   // body: ListView.builder(
//   //     itemCount: medicaments.length,
//   //     itemBuilder: (context, index) {
//   //       name =
//   //           TextEditingController(text: medicaments[index].nomMedicament);
//   //       price = TextEditingController(text: medicaments[index].quantite);
//   //       forme = TextEditingController(text: medicaments[index].forme);
//   //       dosage = TextEditingController(text: medicaments[index].dosage);
//   //       print('THISSSSS NAME');
//   //       print(name);

//   //       return Container(
//   //         child: Text('hiiiiiii'),
//   //       );
//   //     }));
// }
//   //(children: <Widget>[
//   //   Container(
//   //     height: 200,
//   //     child: QrImage(
//   //       //plce where the QR Image will be shown
//   //       data: widget.dataMed,
//   //       size: 150,
//   //       padding: EdgeInsets.only(left: 20, top: 30),
//   //     ),
//   //   ),
//   //   Container(
//   //     child: Text(
//   //       " Scan Your QR Code To Get Command Infos",
//   //       style: TextStyle(fontSize: 20.0),
//   //     ),
//   //   ),

//   // ])
//   // ListView.builder(
//   //     itemCount: medicaments.length,
//   //     itemBuilder: (context, index) {
//   //       name = TextEditingController(
//   //           text: medicaments[index].nomMedicament);
//   //       price =
//   //           TextEditingController(text: medicaments[index].quantite);
//   //       forme = TextEditingController(text: medicaments[index].forme);
//   //       dosage =
//   //           TextEditingController(text: medicaments[index].dosage);
//   //       return Column(
//   //         crossAxisAlignment: CrossAxisAlignment.start,
//   //         children: <Widget>[
//   //           SizedBox(
//   //             height: 20,
//   //           ),
//   //           new ListTile(
//   //               leading: const Icon(Icons.medication),
//   //               // title: new Text(items[index].nom),

//   //               // trailing: new Text(items[index].ppv),
//   //               title: Text('Nom_Medicament',
//   //                   style: TextStyle(fontWeight: FontWeight.w500)),
//   //               subtitle: TextFormField(
//   //                 controller: name,
//   //               )),
//   //           new ListTile(
//   //               leading: const Icon(Icons.monetization_on),
//   //               // title: new Text(items[index].nom),

//   //               // trailing: new Text(items[index].ppv),
//   //               title: Text('PPV',
//   //                   style: TextStyle(fontWeight: FontWeight.w500)),
//   //               subtitle: TextFormField(
//   //                 controller: price,
//   //               )),
//   //           new ListTile(
//   //               leading: const Icon(Icons.description),
//   //               title: Text('Forme',
//   //                   style: TextStyle(fontWeight: FontWeight.w500)),
//   //               subtitle: TextFormField(
//   //                 controller: forme,
//   //               )),
//   //           new ListTile(
//   //               leading: const Icon(Icons.description),
//   //               // title: new Text(items[index].nom),

//   //               // trailing: new Text(items[index].ppv),
//   //               title: Text('Présentation',
//   //                   style: TextStyle(fontWeight: FontWeight.w500)),
//   //               subtitle: TextFormField(
//   //                 controller: ppt,
//   //               )),
//   //         ],
//   //       );
//   //     })

// //                     ListView.builder(
// //                         itemCount: medicaments.length,
// //                         itemBuilder: (context, index) {
// //                           name = TextEditingController(
// //                               text: medicaments[index].nomMedicament);
// //                           price = TextEditingController(
// //                               text: medicaments[index].quantite);
// //                           forme = TextEditingController(
// //                               text: medicaments[index].forme);
// //                           dosage = TextEditingController(
// //                               text: medicaments[index].dosage);
// //                           return Column(
// //                             children: <Widget>[
// //                               Container(
// //                                   width: double.infinity,
// //                                   // height: 200,
// //                                   margin: const EdgeInsets.all(0),

// //                                   // height: 148,
// //                                   decoration: BoxDecoration(
// //                                     borderRadius: const BorderRadius.all(
// //                                         Radius.circular(80.0)),
// //                                     // boxShadow: <BoxShadow>[
// //                                     //   BoxShadow(
// //                                     //     color: Colors.white
// //                                     //         .withOpacity(0.6),
// //                                     //     offset: const Offset(4, 4),
// //                                     //     blurRadius: 16,
// //                                     //   ),
// //                                     // ],
// //                                   ),
// //                                   padding: EdgeInsets.all(8.0),
// //                                   // decoration: BoxDecoration(),
// //                                   child: Align(
// //                                       alignment: Alignment.bottomLeft,
// //                                       child: Text(
// //                                         'Nom_Medicament',
// //                                         style: TextStyle(
// //                                             fontWeight: FontWeight.bold,
// //                                             fontSize: 20),
// //                                       ))),
// //                               SizedBox(
// //                                 height: 10,
// //                               ),
// //                               Align(
// //                                   alignment: Alignment.bottomLeft,
// //                                   child: Padding(
// //                                     padding: EdgeInsets.only(left: 10),
// //                                     child: TextFormField(
// //                                         controller: name,
// //                                         style: TextStyle(
// //                                             fontWeight: FontWeight.w400,
// //                                             fontSize: 17,
// //                                             fontFamily: 'Varela')),
// //                                   )),

// //                               // TextField(
// //                               //   controller: qrdataFeed,
// //                               //   decoration: InputDecoration(
// //                               //     hintText: "Input your link or data",
// //                               //   ),
// //                               // ),
// //                               // Padding(
// //                               //   padding: EdgeInsets.fromLTRB(40, 20, 40, 0),
// //                               //   child: FlatButton(
// //                               //     padding: EdgeInsets.all(15.0),
// //                               //     onPressed: () async {
// //                               //     //   if (qrdataFeed.text.isEmpty) {
// //                               //     //     //a little validation for the textfield
// //                               //     //     setState(() {
// //                               //     //       qrData = "";
// //                               //     //     });
// //                               //     //   } else {
// //                               //     //     setState(() {
// //                               //     //       qrData = qrdataFeed.text;
// //                               //     //     });
// //                               //     //   }
// //                               //     // },
// //                               //   //   child: Text(
// //                               //   //     "Generate QR",
// //                               //   //     style: TextStyle(
// //                               //   //         color: Colors.blue, fontWeight: FontWeight.bold),
// //                               //   //   ),
// //                               //   //   shape: RoundedRectangleBorder(
// //                               //   //       side: BorderSide(color: Colors.blue, width: 3.0),
// //                               //   //       borderRadius: BorderRadius.circular(20.0)),
// //                               //   // ),
// //                               // )
// //                             ],
// //                           );
// //                         })
// //                   ]))),
// //         ));
// //   }
// // }

