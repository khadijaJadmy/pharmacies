import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pharmacie/categories/category.dart';
import 'package:pharmacie/model/pharmacy.model.dart';
import 'package:pharmacie/ui/anotherhome/constants.dart';

class DetailPage extends StatefulWidget {
  final Pharmacy product;

  const DetailPage({Key key, this.product}) : super(key: key);
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: size.height * 0.5,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(widget.product.image), fit: BoxFit.cover),
            ),
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: SvgPicture.asset("assets/images/back_icon.svg")),
                    Row(
                      children: <Widget>[
                        SvgPicture.asset("assets/images/heart_icon.svg"),
                        SizedBox(
                          width: 20,
                        ),
                        SvgPicture.asset("assets/images/share_icon.svg"),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: size.height * 0.45),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(50)),
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    child: Container(
                      width: 150,
                      height: 7,
                      decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      
                      Text(
                        widget.product.name.toUpperCase(),
                        style: TextStyle(fontSize: 20, height: 1.5),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                        color: kPrimaryColor,
                        onPressed: (){
                          //GO TO NAVIGATOR INTERFACE
                           Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Category(
                              id: widget.product.id,
                            ),
                          ),
                        );
                        },
                        child: Text(
                          "Commander Online",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      // Container(
                      //   width: 40,
                      //   height: 40,
                      //   decoration: BoxDecoration(
                      //       shape: BoxShape.circle,
                      //       image: DecorationImage(
                      //           image: NetworkImage(
                      //               "https://images.unsplash.com/photo-1521572267360-ee0c2909d518?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=934&q=80"),
                      //           fit: BoxFit.cover)),
                      // ),
                      // SizedBox(
                      //   width: 20,
                      // ),
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: <Widget>[
                      //     Text(
                      //       "Jean-Luis",
                      //       style: TextStyle(
                      //           fontSize: 16, fontWeight: FontWeight.bold),
                      //     ),
                      //     SizedBox(
                      //       height: 3,
                      //     ),
                      //     Text(
                      //       "Interior Design",
                      //       style: TextStyle(fontSize: 13),
                      //     )
                      //   ],
                      // )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(3)),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text("Télphone: Fax ${widget.product.phone}"),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(3)),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text("Garderie"),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: widget.product.garderie == true
                                    ? Colors.green
                                    : Colors.red),
                            borderRadius: BorderRadius.circular(3)),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(
                            widget.product.garderie == true
                                ? "Ouvert"
                                : 'Fermé',
                            style: TextStyle(
                                color: widget.product.garderie == true
                                    ? Colors.green
                                    : Colors.red),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.product.location,
                    style: TextStyle(height: 1.6),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Wrap(children: [
                    RichText(
                      text: TextSpan(
                        // style: Theme.of(context).textTheme.body1,
                        children: [
                          WidgetSpan(child: Icon(Icons.timelapse)),
                          TextSpan(
                              text: "  Heures d'ouverture",
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300)),
                        ],
                      ),
                    ),
                  ]),
                  // Wrap(children:[ RichText( text: TextSpan( text: "Les heurs d'ouverture :",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w300),))]),
                  SizedBox(
                    height: 7,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Text(
                      "8h -- 20h",
                      style: TextStyle(backgroundColor: Colors.amber[200]),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Photo ",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "https://t4.ftcdn.net/jpg/02/53/70/83/240_F_253708368_pib65h7OnaIL4rkjCeCWMr8sRwIZqYhW.jpg"),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "https://t3.ftcdn.net/jpg/02/65/53/52/240_F_265535255_7n7ZTmjOBXojWrjSOT0y91TyAKIEUyXR.jpg"),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "https://t4.ftcdn.net/jpg/02/92/37/47/240_F_292374742_CQncwMocDXqm4GTBm4f0iEtrmWmliUll.jpg"),
                                    fit: BoxFit.cover)),
                          ),
                        )
                      ],
                    ),
                  ),
                  // Container(
                  //   child: Text("here"),
                  // )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
