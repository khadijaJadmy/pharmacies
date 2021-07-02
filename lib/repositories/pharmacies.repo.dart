import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pharmacie/model/pharmacy.model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PharmaciesRepository {
  int PharmacyCount;
  // allPharmacys();
  Map<int, Pharmacy> pharmacies = {};
   Map<int, Pharmacy> pharmaciesbylocation = {};
 Map<int, Pharmacy> pharmaciesresultsearch = {};
  PharmacysRepository() {
    this.PharmacyCount = pharmacies.length;
  }

  Future<List<Pharmacy>> allPharmacys() async {
    List<Pharmacy> newList = [];
    Pharmacy featureData;
    int index = 0;
    print("here i am stuck");

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore
        .collection('Pharmacies')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((result) {
        print("INSIIIDE HERE");
        print(result);
        featureData = Pharmacy(
            id: result.data()["id"],
            name: result.data()["name"],
            description: result.data()["description"],
            location: result.data()["location"],
            image: result.data()["image"],
            phone: result.data()["phone"],
            garderie: result.data()["garderie"]);
        print(featureData.name);
        // Pharmacys={index:newList};
        pharmacies[index] = featureData;
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

  Future pharmacyByLocation() async {
    String location;
    List<Pharmacy> newList = [];
    Pharmacy featureData;
    int index = 0;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
  
    print("here there is location");
    await firestore
        .collection('Client')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((result) {
        print(result);

        location = result.data()["ville"];
      });
    });
  print(FirebaseAuth.instance.currentUser.uid);
print("LOOOCATION");
print(location);
    await firestore
        .collection('Pharmacies')
        .where('Ville', isEqualTo: location)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((result) {
        print("INSIIIDE HERE");
        print(result);
        featureData = Pharmacy(
            id: result.data()["id"],
            name: result.data()["name"],
            description: result.data()["description"],
            location: result.data()["location"],
            image: result.data()["image"],
            phone: result.data()["phone"],
            garderie: result.data()["garderie"]);
        print(featureData.name);
        // Pharmacys={index:newList};
        pharmaciesbylocation[index] = featureData;
        index++;
        
        // newList.add(featureData);
      });
      print("END HERE");
      print(pharmaciesbylocation);
    });

    return pharmaciesbylocation.values.toList();
  }

  Future pharmacyByName(String name) async {
    List<Pharmacy> newList = [];
    Pharmacy featureData;
    int index = 0;
    print("SEARCH BY NAME");
    print(name);
    // name="";
// if(name==""){
//    List<Pharmacy>  data =await allPharmacys();
//     // pharmaciesresultsearch=data;
//     int i=0;
//     data.forEach((element) => pharmaciesresultsearch[i++]=element);
//     print("VEEEEEEERSIONH ");
//     print(pharmaciesresultsearch);
//    return pharmaciesresultsearch.values.toList();
// }else{


    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore
        .collection('Pharmacies')
        .where('name', isEqualTo: name.toUpperCase())
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((result) {
        print("INSIIIDE HERE");
        print(result);
        featureData = Pharmacy(
            id: result.data()["id"],
            name: result.data()["name"],
            description: result.data()["description"],
            location: result.data()["location"],
            image: result.data()["image"],
            phone: result.data()["phone"],
            garderie: result.data()["garderie"]);
        print(featureData.name);
        pharmaciesresultsearch[index] = featureData;
        index++;
      });
      print("END HERE");
      print(pharmaciesresultsearch);
    
    });

    return pharmaciesresultsearch.values.toList();
  }
  //}
}
