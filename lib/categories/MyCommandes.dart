// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:pharmacie/categories/model/commande.dart';
// import 'package:pharmacie/categories/model/medModel.dart';

// class MyCommandes extends StatefulWidget {
//   @override
//   _MyCommandesState createState() => _MyCommandesState();
// }

// class _MyCommandesState extends State<MyCommandes> {
//   List<CommandeModel> list = [];
//   List<MedicamentModel> listMedicamenet = [];
//   String idClient;

// //  display() async {
// //    print("Laila");
// //    Future<List<CommandeModel>> liste = await getcommandes() ;
// //    setState(() {
// //      list=liste;
// //    });
// //   // await FirebaseFirestore.instance

// //   //       .collection('commande')
// //   //       .get()
// //   //       .then((QuerySnapshot querySnapshot) {
// //   //     querySnapshot.docs.forEach((result) {
// //   //       print(result);

// //   //     });});
// //  //return liste;
// //  }
// final FirebaseAuth auth = FirebaseAuth.instance;
//   void getcommandes() async {
//     // Future List<CommandeModel> liste = List();
//     // liste =[];
//     // try {
//     // String uid = FirebaseAuth.instance.currentUser.uid;
//   final User user = auth.currentUser;
//    final uid = user.uid;
  
  

//     List<CommandeModel> liste = List();

//     liste = [];


//       final firestoreInstance = FirebaseFirestore.instance;
//       firestoreInstance.collection('commande').get().then((querySnapshot) {
//         querySnapshot.docs.forEach((result) {
//           print("inside commande");

//           if (result.data()['idClient'] == uid) {
//             print(result.documentID);
//             print(result.data()['adress']);
//             print(result.data()['numCommande']);
//             print(result.data()['idClient']);
//             print(result.data()['idPharmacy']);
//             CommandeModel m = CommandeModel(
               
//                 adresse: result.data()["adress"],
//                 qr:result.data()["qr"]);
               
              
               
//             setState(() {
//               idClient = result.data()["idClient"];
//               print("IDD CLIENT HERE");
//               print(idClient);
//             });
           
//             liste.add(m);
//             print(liste);
//             list = liste;
//             FirebaseFirestore.instance
//                 .collection('commande')
//                 .doc(result.documentID)
//                 .collection("medicament")
//                 .get()
//                 .then((querySnapshot) {
//               querySnapshot.docs.forEach((result) {
//                 print("Here");
//                 print(result.data()["medicamentName"]);

//                 MedicamentModel medicament = MedicamentModel(
//                     nomMedicament: result.data()["medicamentName"],
//                     dosage: result.data()["dosage"],
//                     forme: result.data()["forme"],
//                     quantite: result.data()["quantite"]);
//                 listMedicamenet.add(medicament);
//               });
//               m.mediList = listMedicamenet;
//               setState(() {});
//             });
//           }

//           if (liste.isNotEmpty) {
//             setState(() {
//               print("laaaaaaaaaaaaaaaaaaaa");
//               list = liste;
//               print(list);
//               // print(list[1].numCommande);
//               print(list.length);
//               //total =listmovimentacoes.map((item) => item.valor).reduce((a, b) => a + b);
//             });
//           } else {
//             print("emptyyyyyyyyyy");
//           }
//         });
//       });
//     });
//     // String uid = "8eHcfjW3J9Q7xbPUTcK334yzAYk1";
//     // String idPharmacy;
//     // final firestoreInstance = FirebaseFirestore.instance;
//     // print("inside get");
//     // firestoreInstance.collection("Livreur").doc(uid).get().then((value) async {
//     //   print(value.data()['id']);
//     //   idPharmacy = value.data()['id'];
//     //   QuerySnapshot querySnapshot = await FirebaseFirestore.instance

//     //       .collection('commande')
//     //       .get();
//     //       //.then((querySnapshot) {
//     //         print("hhhh");
//     //     querySnapshot.docs.forEach((result) {
//     //       print(result.data()['idPharmacy'] == idPharmacy);
//     //       if (result.data()['idPharmacy'] == idPharmacy) {
//     //         CommandeModel m = CommandeModel(
//     //             numCommande:result.data()["numCommande"],
//     //              adresse:result.data()["adresse"]);

//     //         setState(() {

//     //             list.add(m);
//     //             print(m);
//     //         });
//     //         print("Laila");
//     //         print(list);
//     //       }
//     //     });
//     //   });

//     // });
// // firestore.collection('Users')
// //           .doc(uid)
// //           .collection('commande').get();
// //           firestore.docs

//     // } catch (e) {

//     // }
//     // return liste;
//   }

//   @override
//   void initState() {
//     getcommandes();

//     super.initState();
//   }

//   final db = FirebaseFirestore.instance;
//   @override
//   Widget build(BuildContext context) {
//     // String uid = FirebaseAuth.instance.currentUser.uid;
//     // Future<List> liste = display();

// //getcommandes();
//     var index1;
//     String uid = "8eHcfjW3J9Q7xbPUTcK334yzAYk1";
//     return Scaffold(
//       appBar: AppBar(
//         leading: Icon(Icons.menu),
//         title: Text(
//           'Commandes',
//           style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white),
//         ),
//         actions: [
//           // Padding(
//           //   padding: EdgeInsets.symmetric(horizontal: 16),
//           //   child: Icon(Icons.search),
//           // ),
//         ],
//         backgroundColor: Color.fromRGBO(1, 177, 174, 1),
//       ),

//       body: ListView.separated(
//         padding: EdgeInsets.all(10),
//         separatorBuilder: (context, index) => Divider(height: 15),
//         // controller: scrollController,
//         itemCount: list.length,
//         itemBuilder: (context, index) {
//           index1 = index + 1;
//           return Container(
//             height: 100,
//             decoration: BoxDecoration(
//                 gradient: LinearGradient(colors: [
//                   Colors.green[100],
//                   Color.fromRGBO(1, 177, 174, 0.5),
//                   Colors.green[100],
//                 ]),
//                 borderRadius: BorderRadius.circular(8)),
//             child: Column(
//               children: [
//                 ListTile(
//                     title: Text("Commande n° :  ${list[index].numCommande}"),
//                     trailing: Icon(Icons.keyboard_arrow_right,
//                         color: Color.fromRGBO(1, 177, 174, 1), size: 40.0),
//                     onTap: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => DetailCommande(
//                                   medicaments: list[index].mediList,
//                                   commande: list[index],
//                                   idClient: idClient)));
//                     }),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 18.0),
//                   child: Align(
//                       alignment: Alignment.topLeft,
//                       child: Row(
//                         children: [
//                           Text(
//                             "Statut : ",
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                           SizedBox(
//                             width: 15,
//                           ),
//                           Container(
//                               height: 30,
//                               width: 80,
//                               decoration: BoxDecoration(
//                                   border: Border.all(
//                                 color: Colors.green,
//                               )),
//                               child: Center(
//                                   child: Text(
//                                 list[index].statut,
//                                 style: TextStyle(color: Colors.green),
//                               ))),
//                           // SizedBox(height: 15,),
//                         ],
//                       )),
//                 )
//               ],
//             ),
//           );
//         },
//         // separatorBuilder: (context, index) {
//         // return Divider();
//       ),
//       // ListView.builder(
//       //   shrinkWrap: true,
//       //   itemCount: list.length,

//       //   itemBuilder: (context, index) {
//       //     print(list);
//       //     return ListTile(
//       //       trailing: Text(list[index].adresse,
//       //                      style: TextStyle(
//       //                        color: Colors.green,fontSize: 15),),
//       //       leading: Icon(Icons.list),
//       //       title: Text(list[index].numCommande),
//       //       onTap : (){
//       //         Navigator.push(
//       //                                 context,
//       //                                 MaterialPageRoute(
//       //                                     builder: (context) => DetailCommande(medicaments:list[index].mediList)));
//       //       }
//       //     );
//     );
//   }
// //));
// }

// //}