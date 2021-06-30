// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// Future<bool> SignIn(String email, String password) async {
//   try {
//     await FirebaseAuth.instance
//         .signInWithEmailAndPassword(email: email, password: password);
//     return true;
//   } catch (e) {
//     print(e);
//     return false;
//   }
// }

// Future<bool> Register(String email, String password) async {
//   try {
//     print("firestor true");
//     print(email);
//     print(password);
//     await FirebaseAuth.instance
//         .createUserWithEmailAndPassword(email: email, password: password);
//     return true;
//   } on FirebaseAuthException catch (e) {
//     if (e.code == 'weak-password') {
//       print('The password provided is too weak.');
//     } else if (e.code == 'email-already-in-use') {
//       print('The account already exists for that email.');
//     }
//     return false;
//   } catch (e) {
//     print(e.toString());
//     return false;
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<String> SignIn(String email, String password) async {
  String value;
  try {
    var credentials = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return credentials.user.uid;
  } catch (e) {
    print(e);
    return "false";
  }
}

Future<bool> Register(String email, String password, String statut, String name,String adress,
    String phone) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      Firestore.instance.collection("Users").doc(value.user.uid).setData({
        'name': name,
        'email': email,
        'statut': statut
      }).catchError((e) {
        print(e);
      });
      if (statut == 'client') {
        Firestore.instance.collection("Clients").doc(value.user.uid).setData({
          'name': name,
          'email': email,
          'adress': adress,
          'phone': phone
        }).catchError((e) {
          print(e);
        });
      }else {
           Firestore.instance.collection("Livreur").doc(value.user.uid).setData({
          'name': name,
          'email': email,
          'adress': adress,
          'phone': phone
        }).catchError((e) {
          print(e);
        });
      }
    });
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
    return false;
  } catch (e) {
    print(e.toString());
    return false;
  }
}
