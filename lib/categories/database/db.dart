import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  // final String uid;
  // UserCredential result;

  // DatabaseService({this.uid});
  final FirebaseAuth auth = FirebaseAuth.instance;
  Future<void> addcommandeData(Map commandeData, String commandeId) async {
    await Firestore.instance
        .collection("commande")
        .document(commandeId)
        .setData(commandeData)
        .catchError((e) {
      print(e);
    });
  }

  Future<void> addMedData(Map medData, String commandeId) async {
    await Firestore.instance
        .collection("commande")
        .document(commandeId)
        .collection("medicament")
        .add(medData)
        .catchError((e) {
      print(e);
    });
    print("SUCCEFFFF");
  }

  getCommandeData() async {
    return await Firestore.instance.collection("commande").snapshots();
  }

  getMedData(String commandeId) async {
    return await Firestore.instance
        .collection("commande")
        .document(commandeId)
        .collection("medicament")
        .getDocuments();
  }
}
