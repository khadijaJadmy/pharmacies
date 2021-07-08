import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharmacie/categories/camera.dart';
import 'package:pharmacie/categories/commandeForm.dart';
import 'package:pharmacie/categories/qrScan.dart';
import 'package:pharmacie/categories/scanForm.dart';
import 'package:pharmacie/ui/anotherhome/constants.dart';
// import 'package:pharmacie/ui/anotherhome/screens/details/components/body.dart';
import 'package:pharmacie/ui/anotherhome/screens/home/components/body.dart';
import 'package:pharmacie/ui/anotherhome/screens/home/components/header_with_seachbox.dart';

class Category extends StatefulWidget {
  String id;
  Category({this.id});

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  String adresse;

  void getAdressInitial() async {
    print("inside adress");
    // ignore: missing_return
    await Firestore.instance
        .collection('Client')
        .document(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((value) {
      setState(() {
        adresse = value.data()['adress'];
        print(adresse);
      });
      //return adresse;
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
          title:Text("Commander",style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white),),
          backgroundColor: kPrimaryColor,
        ),
        body:
         Column(mainAxisAlignment: MainAxisAlignment.center, children: <
            Widget>[
        //  HeaderWithSearchBox(size: MediaQuery.of(context).size),
          SizedBox(
            height: 10,
          ),
          Row(
            //ROW 1
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                    left: 50, top: 8.0, bottom: 8.0, right: 12.0),
                width: 15.0,
                height: 15.0,
              ),
              Image(
                image: AssetImage('assets/images/form.png'),
                height: 65.0,
                width: 65.0,
              ),
              SizedBox(
                width: 20.0,
              ),
              Column(
                children: <Widget>[
                  Text(
                    'Formulaire ',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                ],
              ),
              SizedBox(
                width: 22,
              ),
              Column(
                children: <Widget>[
                  new IconButton(
                    icon: new Icon(Icons.navigate_next_rounded),
                    highlightColor: Colors.pink,
                    onPressed: () {
                      print("INSIDE CATEGORY");
                      print(adresse);
                      getAdressInitial();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FormScreen(
                                id: widget.id, adress_initial: adresse)),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            //ROW 2
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                    left: 50, top: 8.0, bottom: 8.0, right: 12.0),
                width: 15.0,
                height: 15.0,
              ),
              Image(
                image: AssetImage('assets/images/camera.png'),
                height: 65.0,
                width: 65.0,
              ),
              SizedBox(
                width: 20.0,
              ),
              Column(
                children: <Widget>[
                  Text(
                    'Camera',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                ],
              ),
              SizedBox(
                width: 50,
              ),
              Column(
                children: <Widget>[
                  new IconButton(
                    icon: new Icon(Icons.navigate_next_rounded),
                    highlightColor: Colors.pink,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CameraPage()),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                    left: 50, top: 8.0, bottom: 8.0, right: 12.0),
                width: 15.0,
                height: 15.0,
              ),
              Image(
                image: AssetImage('assets/images/scan.png'),
                height: 65.0,
                width: 65.0,
              ),
              SizedBox(
                width: 20.0,
              ),
              Column(
                children: <Widget>[
                  Text(
                    'Scan',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                ],
              ),
              SizedBox(
                width: 70,
              ),
              Column(
                children: <Widget>[
                  new IconButton(
                    icon: new Icon(Icons.navigate_next_rounded),
                    highlightColor: Colors.pink,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ScanForm(
                                id: widget.id, adress_initial: adresse)),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ]));
  }
  Widget bar(){
  return  Container(
              padding: EdgeInsets.only(
                left: kDefaultPadding,
                right: kDefaultPadding,
                bottom: 36 + kDefaultPadding,
              ),
              height:MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(36),
                  bottomRight: Radius.circular(36),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top:20),
                child: Row(
                  
                  children: <Widget>[
                    
                    Text(
                      'Pharmacy Online!',
                      style: Theme.of(context).textTheme.headline5.copyWith(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                    // Spacer(),
                    // Image.asset("assets/images/logo.png")
                  ],
                ),
              ),
            );
}
}
