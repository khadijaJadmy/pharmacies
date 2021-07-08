import 'package:barcode_scan/barcode_scan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pharmacie/categories/model/commande.dart';
import 'package:pharmacie/categories/model/medModel.dart';
import 'package:pharmacie/model/client.dart';

class DetailCommande extends StatefulWidget {
  final List<MedicamentModel> medicaments;
  final CommandeModel commande;
  final String idClient;
  DetailCommande({this.medicaments, this.commande, this.idClient});
  @override
  _LivreurState createState() => _LivreurState();
}

class _LivreurState extends State<DetailCommande> {
//GlobalKey<FormState> _key=new GlobalKey()
  Client client;
  String result;
  bool expanded = false;
  Future displayInfoClient() async {
    print("inside display");
    print(widget.idClient);
    print("WWIIIDGETTT");
    QuerySnapshot featureSnapShot =
        await FirebaseFirestore.instance.collection("Client").get();
    featureSnapShot.docs.forEach((element) {
      if (element.id == widget.idClient) {
        client = Client(
          phone: element.data()["phone"],
          name: element.data()["name"],
          email: element.data()["email"],
          postalCode: element.data()["postalCode"],
          ville: element.data()["ville"],

          // statut: element.data()["statut"],
          // email: element.data()["email"],
        );
        //    Client({  this.name,   this.email,   this.adress,this.phone,this.postalCode,this.ville});

        print(client.phone);
        print("WE ARE HERE");
      }
    });

    // if (value.data()['numCommande'] == result) {
//Khadiiiiiija ana jaya

    // }
    // });
  }

  void scanQr(String uid) async {
    
    //  String uid = "8eHcfjW3J9Q7xbPUTcK334yzAYk1";

    try {
      String scanResult = await BarcodeScanner.scan();
      setState(() {
        result = scanResult;
      });
      
    print(result);
    print("REESULT");

      //loadYourData();

//Il faut récupérer uid de la commande
//chercher la commande et récupérer son qrcode
//comparer celui avec celui scanner

      FirebaseFirestore.instance
          .collection("commande")
          .doc(uid)
          .get()
          .then((value) async {
        print(value.data()['id']);

//Comparer les qr codes
        if (widget.commande.qrcode == result) {
          setState(() {
            final firestoreInstance = FirebaseFirestore.instance;

            firestoreInstance
                .collection("commande")
                .doc(uid)
                .update({"statut": "Terminé"});
            print("statut changed");
          });

          Fluttertoast.showToast(
              msg: "Le Qr Code est bien scanné, votre commande est validée ",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);

        } else {
          Fluttertoast.showToast(
              msg: "Le Qr Code ne correspond pas à la commande ",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
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
  void initState() {
    super.initState();
    print("inside init");
    displayInfoClient();
  }

  final db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    print(widget.medicaments);
    // display();
    var index1;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Medicaments commandés",
            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(1, 177, 174, 1),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            ExpansionPanelList(
              expansionCallback: (int index, bool isExpanded) {},
              children: [
                ExpansionPanel(
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return GestureDetector(
                      child: ListTile(
                        title: Text(
                          'Informations sur le client',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            expanded = !expanded;
                            print(expanded);
                          });
                        },
                      ),
                    );
                  },
                  body: Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                            alignment: Alignment.topLeft,
                            child: Row(
                              children: [
                                Icon(Icons.location_on,color:Colors.blue[300],),
                                SizedBox(
                                  width: 8,
                                ),
                                Wrap(children: [
                                  Text(
                                    "Adresse du client : " +
                                        widget.commande.adresse,
                                    textAlign: TextAlign.left,
                                  )
                                ]),
                              ],
                            )),
                            SizedBox(height: 6,),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Row(
                              children: [
                                Icon(Icons.phone,color: Colors.blue[300],),
                                SizedBox(
                                  width: 8,
                                ),
                                Wrap(children: [
                                  Text(
                                      "Téléphone  : ${client == null ? "066" : client.phone}")
                                ]),
                              ],
                            )),
                            SizedBox(height: 6,),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Row(
                              children: [
                                Icon(Icons.person,color: Colors.blue[300],),
                                SizedBox(
                                  width: 8,
                                ),
                                Wrap(children: [Text("Nom :  : ${client == null ? "nom" : client.name}")]),
                              ],
                            )),
                        SizedBox(
                          height: 9,
                        ),
                      ],
                    ),
                  ),
                  isExpanded: expanded,
                ),
              ],
            ),
            Expanded(
              child: ListView.separated(
                  padding: EdgeInsets.all(10),
                  separatorBuilder: (context, index) => Divider(height: 15),
                  // controller: scrollController,
                  itemCount: widget.medicaments.length,
                  itemBuilder: (context, index) {
                    index1 = index + 1;
                    return Container(
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(1, 177, 174, 0.3),
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Médicament n°: $index1",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text("Nom du médicament : " +
                                      widget.medicaments[index].nomMedicament)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Row(
                                    children: [
                                      Text("Quantité : "),
                                      Container(
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.green),
                                            shape: BoxShape.circle),
                                        child: CircleAvatar(
                                          backgroundColor: Colors.green[100],
                                          child: Text(
                                            widget.medicaments[index].quantite,
                                            style:
                                                TextStyle(color: Colors.green),
                                          ),
                                          radius: 13,
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Row(
                                    children: [
                                      Text("Dosage  : "),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      Text(widget.medicaments[index].dosage),
                                    ],
                                  )),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Row(
                                    children: [
                                      Text("Format   : "),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      Text(widget.medicaments[index].forme),
                                    ],
                                  )),
                            ),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            GestureDetector(
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(colors: [Colors.green[300],Colors.green[600],Color.fromRGBO(1, 177, 174, 0.3),])),
                child: Center(
                  child: Text(
                    "Valider la livraison",
                    style: new TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              onTap: () {
                // onPressed: () {
                //context.read<UtilisateursBloc>().add(SeConnecterEvent(username.text, password.text));
                scanQr(widget.commande.uid);
                // },
              },
            ),
          ],
        ));
  }
}
