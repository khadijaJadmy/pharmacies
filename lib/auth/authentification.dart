import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as Auth;
// import 'package:crypto_wallet/model/Professor.dart';
// import 'package:crypto_wallet/model/user.dart';
// import 'package:crypto_wallet/net/flutterfire.dart';
// import 'package:crypto_wallet/ui/auth/inscription.dart';
// import 'package:crypto_wallet/ui/home/components/body.dart';
// import 'package:crypto_wallet/ui/home/home_screen.dart';
// import 'package:crypto_wallet/ui/pages/professors.page.dart';
// import 'package:crypto_wallet/ui_professor/annonce_student_list.dart';
// import 'package:crypto_wallet/widgets/animation.dart';
import 'package:flutter/material.dart';
import 'package:pharmacie/auth/inscription.dart';
import 'package:pharmacie/firestore/auth.dart';
import 'package:pharmacie/model/client.dart';
import 'package:pharmacie/model/user.dart';
import 'package:pharmacie/ui/anotherhome/screens/home/components/body.dart';
import 'package:pharmacie/ui/anotherhome/screens/home/home_screen.dart'
    as Homee;
import 'package:pharmacie/ui/home/home.dart';

// import '../../widgets/navBar.dart';
// import '../home/home_view.dart';

class Authentification extends StatefulWidget {
  Authentification({Key key}) : super(key: key);

  @override
  _AuthentificationState createState() => _AuthentificationState();
}

class _AuthentificationState extends State<Authentification> {

  final snackBar = SnackBar(content: Text('Mot de passe ou email est incorrect!'),backgroundColor: Colors.red[200]);

  Future<List<Client>> getListOfUsers() async {
    List<Client> newList = [];
    // List<Widget> newList=[];
    Client featureData;
    String id;
    String uid = Auth.FirebaseAuth.instance.currentUser.uid;
    // var docRef = db.collection("cities").doc("SF");
    QuerySnapshot featureSnapShot =
        await FirebaseFirestore.instance.collection("Professors").get();

    featureSnapShot.docs.forEach(
      (element) {
        featureData = Client(
          name: element.data()["name"],
          adress: element.data()["adress"],
          phone: element.data()["phone"],
          email: element.data()["email"],
        );
        // final documentID = userDocument.documentID;
        newList.add(featureData);
      },
    );
    // print(newList[0].category);
    return newList;
  }

  Future<void> getList() async {
    List<Client> products = [];
    List<Client> list = await getListOfUsers();
    products = list;
    print(products);
    print(true);
    return products;
  }

  Future<void> verifyStatutOfUser(String uid) async {
    print("VALUEEE FALSE");
    print(uid);
    User featureData;
    QuerySnapshot featureSnapShot =
        await FirebaseFirestore.instance.collection("Users").get();
    featureSnapShot.docs.forEach(
      (element) {
        if (element.id == uid) {
          featureData = User(
            name: element.data()["name"],
            statut: element.data()["statut"],
            email: element.data()["email"],
          );
        }
      },
    );
    if (featureData.statut == "Client") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              // ProfessorsPage()
              //MyNavigationBar(),
              // Homee.HomeScreen(),
              Body(),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              // ProfessorsPage()
              //MyNavigationBar(),
              // Inscription(),
              Inscription(),
        ),
      );
    }
  }

  TextEditingController _emailField = TextEditingController();
  TextEditingController _passwordField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return
        // Scaffold(
        //   body: Container(
        //     width: MediaQuery.of(context).size.width,
        //     height: MediaQuery.of(context).size.height,
        //     decoration: BoxDecoration(
        //       color: Colors.grey[400],
        //     ),
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Container(
        //           width: MediaQuery.of(context).size.width / 1.3,
        //           child: TextFormField(
        //             style: TextStyle(color: Colors.white),
        //             controller: _emailField,
        //             decoration: InputDecoration(
        //               hintText: "something@email.com",
        //               hintStyle: TextStyle(
        //                 color: Colors.white,
        //               ),
        //               labelText: "Email",
        //               labelStyle: TextStyle(
        //                 color: Colors.white,
        //               ),
        //             ),
        //           ),
        //         ),
        //         SizedBox(height: MediaQuery.of(context).size.height / 35),
        //         Container(
        //           width: MediaQuery.of(context).size.width / 1.3,
        //           child: TextFormField(
        //             style: TextStyle(color: Colors.white),
        //             controller: _passwordField,
        //             obscureText: true,
        //             decoration: InputDecoration(
        //               hintText: "password",
        //               hintStyle: TextStyle(
        //                 color: Colors.white,
        //               ),
        //               labelText: "Password",
        //               labelStyle: TextStyle(
        //                 color: Colors.white,
        //               ),
        //             ),
        //           ),
        //         ),
        //         SizedBox(height: MediaQuery.of(context).size.height / 35),
        //         Container(
        //           width: MediaQuery.of(context).size.width / 1.4,
        //           height: 45,
        //           decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(15.0),
        //             color: Colors.white,
        //           ),
        //           child: MaterialButton(
        //             onPressed: () async {
        //               bool shouldNavigate =
        //                   await Register(_emailField.text, _passwordField.text);
        //               if (shouldNavigate) {
        //                 Navigator.push(
        //                   context,
        //                   MaterialPageRoute(
        //                     builder: (context) => Body(),
        //                   ),
        //                 );
        //               }
        //             },
        //             child: Text("Register"),
        //           ),
        //         ),
        //         SizedBox(height: MediaQuery.of(context).size.height / 35),
        //         Container(
        //           width: MediaQuery.of(context).size.width / 1.4,
        //           height: 45,
        //           decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(15.0),
        //             color: Colors.white,
        //           ),
        //           child: MaterialButton(
        //               onPressed: () async {
        //                 bool shouldNavigate =
        //                     await SignIn(_emailField.text, _passwordField.text);

        //                 if (shouldNavigate) {

        //                   Navigator.push(
        //                     context,
        //                     MaterialPageRoute(
        //                       builder: (context) =>
        //                       // ProfessorsPage()
        //                       //MyNavigationBar(),
        //                      Body(),
        //                     ),
        //                   );
        //                 }
        //               },
        //               child: Text("Login")),
        //         ),
        //       ],
        //     ),
        //   ),
        // );
        Scaffold(
            backgroundColor: Colors.white,
            //backgroundColor: Color.fromRGBO(136, 170, 195, 1),
            body: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 350,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://t4.ftcdn.net/jpg/02/77/54/11/240_F_277541160_F43wshVmxNkzfNoV70qvpl2EMsS7qMov.jpg'),
                            fit: BoxFit.fitWidth),
                        //  color:Color.fromRGBO(212, 234, 248,1),
                      ),
                      child: Stack(
                        children: <Widget>[
                          // Positioned(
                          //     left: 30,
                          //     width: 80,
                          //     height: 200,
                          //     child:
                          //         // FadeAnimation(1,
                          //         Container(
                          //       decoration: BoxDecoration(
                          //           image: DecorationImage(
                          //               image: AssetImage(
                          //                   'assets/images/light-1.png'))),
                          //     )
                          //     //),
                          //     ),
                          // Positioned(
                          //     left: 140,
                          //     width: 80,
                          //     height: 150,
                          //     child:
                          //         // FadeAnimation(1.3,
                          //         Container(
                          //       decoration: BoxDecoration(
                          //           image: DecorationImage(
                          //               image: AssetImage(
                          //                   'assets/images/light-2.png'))),
                          //     )
                          //     //),
                          //     ),
                          // Positioned(
                          //     right: 40,
                          //     top: 40,
                          //     width: 80,
                          //     height: 150,
                          //     child:
                          //         //FadeAnimation(1.5,
                          //         Container(
                          //       decoration: BoxDecoration(
                          //           image: DecorationImage(
                          //               image: AssetImage(
                          //                   'assets/images/clock.png'))),
                          //     )
                          //     //),
                          //     ),
                          // Positioned(
                          //     child:
                          //         // FadeAnimation(1.6,

                          //     //),
                          // )
                        ],
                      ),
                    ),
                    Container(
                      // margin: EdgeInsets.only(top: 320),
                      decoration:BoxDecoration(
                        gradient: LinearGradient(colors: [
                                    // Color.fromRGBO(155, 178, 161, 1),
 Color.fromRGBO(72, 219, 211, 0),
                                    Color.fromRGBO(1, 177, 174, 1),
                                    Color.fromRGBO(72, 219, 211, 0),])
                      ),
                      child: Center(
                        child: Text(
                          "Online Pharmacy",
                          style: TextStyle(
                              color: Colors.black,
                              
                              fontSize: 35,
                              fontWeight: FontWeight.w300,),
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: 50,
                    // ),
                    Padding(
                      padding: EdgeInsets.all(30.0),
                      child: Column(
                        children: <Widget>[
                          //   FadeAnimation(1.8,
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromRGBO(177, 177, 198, .2),
                                      blurRadius: 20.0,
                                      offset: Offset(0, 10))
                                ]),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey[100]))),
                                  child: TextField(
                                    controller: _emailField,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Email",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400])),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextField(
                                    controller: _passwordField,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Password",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400])),
                                  ),
                                )
                              ],
                            ),
                          ),
                          //),
                          SizedBox(
                            height: 30,
                          ),
                          //   FadeAnimation(2,
                          GestureDetector(
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(colors: [
                                    // Color.fromRGBO(155, 178, 161, 1),

                                    Color.fromRGBO( 1, 177, 174, 1),
                                   
                                    Color.fromRGBO( 1, 177, 174, 1),
                                    // Color.fromRGBO(155, 178, 161, .6),
                                  ])),
                              child: Center(
                                  child: Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                            ),
                            onTap: () async {
                              String shouldNavigate = await SignIn(
                                  _emailField.text, _passwordField.text);
                                  if(shouldNavigate=="false"){
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  }
                              verifyStatutOfUser(shouldNavigate);
                            },
                          ),

                          //),
                          SizedBox(
                            height: 70,
                          ),

                          //FadeAnimation(1.5,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Forgot Password?",
                                style: TextStyle(
                                    color: Color.fromRGBO(143, 148, 251, 1)),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              GestureDetector(
                                child: Text(
                                  "Create acount,",
                                  style: TextStyle(
                                      color: Color.fromRGBO(143, 148, 251, 1)),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          // ProfessorsPage()
                                          //MyNavigationBar(),
                                          Inscription(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),

                          //),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ));
  }
}
