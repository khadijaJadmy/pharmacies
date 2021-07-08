import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pharmacie/bloc/pharmacy.action.dart';
import 'package:pharmacie/bloc/pharmacy.bloc.dart';
import 'package:pharmacie/bloc/pharmacy.state.dart';
import 'package:pharmacie/categories/category.dart';
import 'package:pharmacie/enums/enums.dart';
import 'package:pharmacie/model/pharmacy.model.dart';
import 'package:pharmacie/ui/anotherhome/screens/details/details_screen.dart';
import 'package:pharmacie/ui/detail/detail.dart';
import 'package:pharmacie/ui/detail/detailDesign.dart';

import '../../../constants.dart';

class RecomendsPlants extends StatelessWidget {
  // final List<Pharmacy> products;
  const RecomendsPlants({
    Key key,
    // this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<PharmaciesBloc>().add(LoadAllPharmaciesEvents(""));
    return BlocBuilder<PharmaciesBloc, PharmaciesState>(
        builder: (context, state) {
      return state.requestState == RequestState.LOADING
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  for (int i = 0; i < state.pharmacies.length; i++)
                    GestureDetector(
                      child: RecomendPlantCard(
                        image: state.pharmacies[i].image,
                        title: state.pharmacies[i].name,
                        country: state.pharmacies[i].location,
                        price: 440,
                        id: state.pharmacies[i].id,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPage(
                              product: state.pharmacies[i],
                            ),
                          ),
                        );
                      },
                    ),
                ],
              ),
            );
    });
  }
}

class RecomendPlantCard extends StatelessWidget {
  const RecomendPlantCard({
    Key key,
    this.image,
    this.title,
    this.country,
    this.price,
    this.press,
    this.id,
  }) : super(key: key);

  final String image, title, country, id;
  final int price;
  final Function press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        margin: EdgeInsets.only(
          left: kDefaultPadding,
          top: kDefaultPadding / 2,
          bottom: kDefaultPadding * 2.5,
        ),
        // width: size.width * 0.5,
        // height: size.height/5,
        child: Column(
          children: <Widget>[
            Container(
              height: 100,
              width: 170,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(image),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            // GestureDetector(
            //   onTap: () {},
            //   child: Container(
            //       // height: 100,
            //   width: 170,
            //     // padding: EdgeInsets.only(
            //         // left: kDefaultPadding / 2, right: kDefaultPadding / 2),
            //     decoration: BoxDecoration(
            //       // color: Colors.grey[200],
            //       color:Color.fromRGBO(1, 177, 174, 0.2),
            //       borderRadius: BorderRadius.only(
            //         bottomLeft: Radius.circular(15),
            //         bottomRight: Radius.circular(15),
            //       ),
            //       // boxShadow: [
            //       //   BoxShadow(
            //       //     offset: Offset(0, 10),
            //       //     // blurRadius: 50,
            //       //     // color: kPrimaryColor.withOpacity(0.23),
            //       //   ),
            //       // ],
            //     ),
            // child: Row(
            //   // mainAxisAlignment: MainAxisAlignment.center,
            //   children: <Widget>[
            //     Align(
            //       alignment: Alignment.topLeft,
            //       child: ElevatedButton(
            //         onPressed: () {
            //           Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //               builder: (context) => Category(
            //                 id: id,
            //               ),
            //             ),
            //           );
            //         },
            //         child: Center(
            //           child: Icon(Icons.shop)
            //           ),
            //         // Text('Commander',style: TextStyle(fontSize: 12),textAlign: TextAlign.center,),
            //         style: ElevatedButton.styleFrom(
            //             shape: RoundedRectangleBorder(
            //               borderRadius: BorderRadius.circular(12),

            //               // <-- Radius
            //             ),
            //             primary: Color.fromRGBO(122, 211, 207, 1)),
            //       ),
            //     ),
            // SizedBox(height: 5,),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0, left: 12),
                child: Flexible(
                  child: RichText(
                    overflow: TextOverflow.visible,
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                            child: GestureDetector(
                                child: Align(
                                    alignment: Alignment.topLeft,
                                    child: FaIcon(
                                      FontAwesomeIcons.shoppingCart,
                                      size: 15,
                                      color: kPrimaryColor,
                                    )),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Category(
                                        id: id,
                                      ),
                                    ),
                                  );
                                })),
                      
                        TextSpan(
                            text: "$title\n".toUpperCase(),
                            style:
                                TextStyle(color: Colors.black, fontSize: 17)),
                        // TextSpan(
                        //   text: "$country".toUpperCase(),
                        //   style: TextStyle(
                        //     color: kPrimaryColor.withOpacity(0.5),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Spacer(),
            // RaisedButton(
            //   color: Colors.green[200],

            //   child:Text("Commander",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w400),),
            //   onPressed: () {

            // },),

            // Text(
            //   '\$$price',
            //   style: Theme.of(context)
            //       .textTheme
            //       .button
            //       .copyWith(color: kPrimaryColor),
            // )
          ],
        ));

    //    ),
    //    )
    // ],
    // ),
    // );
  }
}
