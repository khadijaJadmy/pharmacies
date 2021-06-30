import 'package:flutter/material.dart';
import 'package:pharmacie/auth/authentification.dart';
import 'package:pharmacie/firestore/auth.dart';
import 'package:pharmacie/model/client.dart';
import 'package:pharmacie/ui/home/home.dart';
import 'package:select_form_field/select_form_field.dart';

class Inscription extends StatefulWidget {
  Inscription({Key key}) : super(key: key);

  @override
  _InscriptionState createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  final List<Map<String, dynamic>> _items = [
    {
      'value': 'client',
      'label': 'Client',
      'icon': Icon(Icons.people),
    },
    {
      'value': 'livreur',
      'label': 'Livreur',
      'icon': Icon(Icons.school),
      'textStyle': TextStyle(color: Colors.red),
    },
  ];
  TextEditingController _emailField = TextEditingController();
  TextEditingController _passwordField = TextEditingController();
  TextEditingController _nameField = TextEditingController();
  TextEditingController _statutField = TextEditingController();
    TextEditingController _fullnameField = TextEditingController();
  TextEditingController _phoneField = TextEditingController();  
TextEditingController _adressField = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/pharmacy.jpg'),
                          fit: BoxFit.fill)),
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
                      // ),
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
                      //               image:
                      //                   AssetImage('assets/images/clock.png'))),
                      //     )
                      //     //),
                      //     ),
                      Positioned(
                          child:
                              // FadeAnimation(1.6,
                              Container(
                        margin: EdgeInsets.only(top: 130),
                        child: Center(
                          child: Text(
                            "SignIn",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 35,
                                fontWeight: FontWeight.w400
                                ),
                          ),
                        ),
                      )
                          //),
                          )
                    ],
                  ),
                ),
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
                            //          Container(
                            //   padding: EdgeInsets.all(8.0),
                            //   decoration: BoxDecoration(
                            //       border: Border(
                            //           bottom: BorderSide(
                            //               color: Colors.grey[100]))),
                            //   child: TextField(
                            //     controller: _nameField,
                            //     decoration: InputDecoration(
                            //         border: InputBorder.none,
                            //         hintText: "Name",
                            //         hintStyle:
                            //             TextStyle(color: Colors.grey[400])),
                            //   ),
                            // ),
                                    Container(
                              padding: EdgeInsets.all(8.0),
                              child: TextField(
                                controller: _fullnameField,
                                obscureText: false,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Full name",
                                    hintStyle:
                                        TextStyle(color: Colors.grey[400])),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom:
                                          BorderSide(color: Colors.grey[100]))),
                              child: TextField(
                                controller: _emailField,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Email",
                                    hintStyle:
                                        TextStyle(color: Colors.grey[400])),
                              ),
                            ),

                            SelectFormField(
                                // controller: _statutField,
                                initialValue: 'Client',
                                icon: Icon(Icons.stacked_bar_chart_outlined),
                                labelText: 'Statut',
                                items: _items,
                                onChanged: (val) {
                                  print(val);
                                  setState(() {
                                    _statutField.text = val;
                                  });
                                },
                                onSaved: (val) {
                                  setState(() {
                                    _statutField.text = val;
                                  });
                                }

                                // controller: _statutField,
                                ),
                    
                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: TextField(
                                controller: _phoneField,
                                obscureText: false,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Phone number",
                                    hintStyle:
                                        TextStyle(color: Colors.grey[400])),
                              ),
                            ),
                                Container(
                              padding: EdgeInsets.all(8.0),
                              child: TextField(
                                controller: _adressField,
                                obscureText: false,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Adress",
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
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: TextField(
                                controller: _passwordField,
                                obscureText: true,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Confirm password",
                                    hintStyle:
                                        TextStyle(color: Colors.grey[400])),
                              ),
                            )
                          ],
                        ),
                      ),

                      //),
                      SizedBox(
                        height: 20,
                      ),
                      //   FadeAnimation(2,
                      GestureDetector(
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(colors: [
                                // Color.fromRGBO(155, 178, 161, 1),
                                // Color.fromRGBO(155, 178, 161, .6),
                                      Color.fromRGBO(136, 170, 195,1),
                                      Color.fromRGBO(212, 234, 248,1),
                              ])),
                          child: Center(
                              child: Text(
                            "Sing In",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                        onTap: () async {
                          bool shouldNavigate = await Register(_emailField.text,
                              _passwordField.text, _statutField.text,_fullnameField.text,_phoneField.text,_adressField.text);

                          if (shouldNavigate) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    // ProfessorsPage()
                                    //MyNavigationBar(),
                                    //    Body(),
                                    HomeScreen(),
                              ),
                            );
                          }
                        },
                      ),

                      //),
                      SizedBox(
                        height: 30,
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
                              "Already have acount,",
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
                                      Authentification(),
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
