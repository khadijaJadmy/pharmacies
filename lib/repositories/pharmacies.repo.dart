import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pharmacie/model/pharmacy.model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PharmaciesRepository {
  int PharmacyCount;
  // allPharmacys();
  Map<int, Pharmacy> pharmacies = {
 };

  PharmacysRepository() {
    this.PharmacyCount = pharmacies.length;
  }

  Future<List<Pharmacy>> allPharmacys() async {
    List<Pharmacy> newList = [];
    Pharmacy featureData;
    int index = 0;
    print("here i am stuck");

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore
        .collection('Pharmacies')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((result) {
        print("INSIIIDE HERE");
        print(result);
        featureData = Pharmacy(
            name: result.data()["name"],
            description: result.data()["description"],
            location: result.data()["location"],
            image: result.data()["image"]);
        print(featureData.name);
        // Pharmacys={index:newList};
        pharmacies[index]=featureData;
        index++;
        // newList.add(featureData);
      });
      print("END HERE");
     print(pharmacies);
    //  return Pharmacys.values.toList();
    //  print(index);
    //   if (Pharmacys != null) {
    //   print("VALUES OF PHARMACY");
    //   print(Pharmacys.values.toList());
    //   return Pharmacys.values.toList();
    // } else {
    //   throw new Exception('Internet Error');
    // }
    });

 return pharmacies.values.toList();
   
  }

  Future pharmacyByLocation(String location) async {}
}
