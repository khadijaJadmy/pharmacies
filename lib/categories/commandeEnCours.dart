import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharmacie/categories/camera.dart';
import 'package:pharmacie/categories/commandeForm.dart';
import 'package:pharmacie/categories/model/commande.dart';
import 'package:pharmacie/categories/model/medModel.dart';
import 'package:pharmacie/categories/qrScan.dart';
import 'package:pharmacie/categories/scanForm.dart';
// import 'package:pharmacie/ui/anotherhome/screens/details/components/body.dart';
import 'package:pharmacie/ui/anotherhome/screens/home/components/body.dart';
import 'package:qr_flutter/qr_flutter.dart';

class EnCoursCommande extends StatefulWidget {
  // String id;
  // Category({this.id});

  @override
  _EnCoursCommandeState createState() => _EnCoursCommandeState();
}

class _EnCoursCommandeState extends State<EnCoursCommande> {
String adresse;
CommandeModel commande;
String qrCode;
List<MedicamentModel> medicaments=[];
  void getAdressInitial() async {
    print("inside adress");
      // ignore: missing_return
  //   await Firestore.instance.collection('commande').where('idClient', isEqualTo: FirebaseAuth.instance.currentUser.uid).where('statut', isEqualTo: "En cours").get().then((value) {
  //   print(value);
  //   print(value.documents);
  //    await Firestore.instance.collection('commande').document(value.documents)
  // print("INSIDE EN COURS COMMANDE");

  //    //return adresse;
  //     });
      FirebaseFirestore firestore = FirebaseFirestore.instance;
  print(qrCode);
      await firestore
        .collection('commande')
        .where('idClient', isEqualTo: FirebaseAuth.instance.currentUser.uid).where('statut', isEqualTo: "encours")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((result) {
        print("INSIIIDE HERE");
        print(result);
        commande = CommandeModel(
            numCommande: result.data()["numCommande"],
            qrcode: result.data()["qrCode"],
            statut: result.data()["statut"],
            uid: result.data()["uid"],
            mediList: result.data()["mediList"],
            adresse: result.data()["adresse"],
            
            );
        print(commande.qrcode);
        setState(() {
          qrCode=commande.qrcode;
        });
        print("COMMANDE EN COURS");
 
        // Pharmacys={index:newList};
     
        // newList.add(featureData);
      });
 
       
  });
  }
  
@override
void initState() { 
  getAdressInitial();
  
}
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
     appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            // Navigator.of(context).pop();
            Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Body(),
                            ));
          },
        ),
        title: Text("Commande en cours",style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white)),
        backgroundColor: Color.fromRGBO(1, 177, 174, 1),
      ),
        body:Container(

          child:Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Wrap(children:[ Text("Veuiller scanner ce code barre pour confirmer la récépetion du commande",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Color.fromRGBO(1, 177, 174, 1)),)]),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: Center(
                    child: qrCode==null?Text("No commande found"):QrImage(
                      //plce where the QR Image will be shown
                      data: qrCode==null?"": qrCode,
                      size: 300,
                      padding: EdgeInsets.only(left: 20, top: 30),
                    ),
                  ),
                ),
            ],
          ),
        ),
     
    );
  }
}
