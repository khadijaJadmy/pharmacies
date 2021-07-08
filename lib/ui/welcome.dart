import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pharmacie/auth/authentification.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    var d = Duration(seconds: 6);
    // delayed 3 seconds to next page
    Future.delayed(d, () {
      // to next page and close this page
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) {
            return Authentification();
          },
        ),
        (route) => false,
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromRGBO(9, 189, 180, 0.3),
          Color.fromRGBO(9, 189, 180, 0.2),
          Color.fromRGBO(9, 189, 180, 0.5),
          Color.fromRGBO(9, 189, 180, 0.3),
        ])
            // image: DecorationImage(
            //     image: AssetImage('assets/images/bg2.jpg'),
            //     fit: BoxFit.fitHeight),
            ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(children: <Widget>[
                Image.asset(
                  'assets/images/YaMedia.png',
                  alignment: Alignment.topCenter,
                ),
                SizedBox(height: 10,),
                Center(
                  child: Column(
                    children: [
                      Text(
                        "Welcome to PharmaCity",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                      ),
                      Text("Your Professor Online"),
                      Align(
                        child: Container(
                          width: 150,
                          height: 3,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      SizedBox(height: 20,)
                    ],
                  ),
                )
              ]),
              //  Align(
              //    alignment: Alignment.center,
              //    child:
              //    ),

              // ),
              // SizedBox(height: 20,),

              //  SvgPicture.asset('assets/images/cademy2.png'),
            ],
          ),
        ),
      ),
    );
  }
}
