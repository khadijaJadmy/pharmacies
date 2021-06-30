  
// import 'package:pharmacie/model/pharmacy.model.dart';
// import 'package:flutter/material.dart';

// import '../../constant.dart';


// class ItemCard extends StatelessWidget {
//   final Pharmacy product;
//   final Function press;
//   const ItemCard({
//     Key key,
//     this.product,
//     this.press,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: press,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Expanded(
//             child: Container(
//               padding: EdgeInsets.all(kDefaultPaddin),
//               // For  demo we use fixed height  and width
//               // Now we dont need them
//               // height: 180,
//               // width: 160,
//               decoration: BoxDecoration(
//                 color: Colors.blue[100],
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: Hero(
//                 tag: "${product.description}",
//                 child: Image.network(product.image,fit: BoxFit.fill,),
//                 //Image.asset("assets/images/"+product.image),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin / 4),
//             child: Text(
//               // products is out demo list
//               product.name,
//               style: TextStyle(color: kTextLightColor),
//             ),
//           ),
//           Text(
//             product.location,
//             style: TextStyle(fontWeight: FontWeight.bold),
//           )
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pharmacie/model/pharmacy.model.dart';
import '../../../constant.dart';

class ItemCard extends StatelessWidget {
  final Pharmacy product;
  final Function press;
  const ItemCard({
    Key key,
    this.product,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print(product.course.nom_formation);
    return GestureDetector(
      onTap: press,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Expanded(
          //   // flex: 2,
          //   child: 
          Container(
              // padding: EdgeInsets.all(kDefaultPaddin),
               height: 100,
               width: 150,
              decoration: BoxDecoration(
                  // color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20),
                  shape: BoxShape.rectangle,
                  image: 
                  DecorationImage(
                    fit: BoxFit.fill,
                    image: 
                    NetworkImage(
                     product.image
                    ),
                  )
              ),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient:
                        LinearGradient(begin: Alignment.bottomRight, stops: [
                      0.3,
                      0.9
                    ], colors: [
                      Colors.grey.withOpacity(.5),
                      Colors.grey.withOpacity(.2),
                    ])
                  ),
              ), 
                  // child: Hero(),

                // child: Align(
                //   alignment: Alignment.bottomLeft,
                //   child: Padding(
                //     padding: const EdgeInsets.all(15),
                //     child: Text( "${product.formation.toUpperCase()}",style:
                //      TextStyle(fontWeight: FontWeight.w700,color: Colors.white,backgroundColor: Colors.grey[500]),)
                //   ),
                // ),

                // child: Hero(
                //   tag: "${product.formation}",
                //   child: Image.asset(
                //     "assets/images/" + product.image,
                //     width: 100,
                //     height: 50,
                //     fit: BoxFit.cover,
                //   )
                //   ),
            //  ),
           // ),
          ),
          SizedBox(
            height: 15,
          ),
          Wrap(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      text: "${product.name.toUpperCase()}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black),
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Row(
          //   // mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          //   children: [
          //     Text(
          //       // products is out demo list
          //       product.name,
          //       style: TextStyle(color: Colors.grey[500]),
          //     ),
          //   ],
          // ),
          // Row(
          //   children: [
          //     Wrap(children: [
          //       RichText(
          //         text: TextSpan(
          //           // style: Theme.of(context).textTheme.body1,
          //           children: [
          //             TextSpan(
          //               text: product.formation.toUpperCase(),style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)
          //             ),
          //           ],
          //         ),
          //       ),
          //     ]
          //     ),
          //   ],
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              RatingBar.builder(
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 19,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
            ],
          ),
          // Row(
          //   children: [
          //     Text(
          //       "product",
          //       style: TextStyle(
          //           fontWeight: FontWeight.bold,
          //           backgroundColor: Colors.orange[200]),
          //     ),
          //     // SizedBox(
          //     //   height: 20,
          //     // )
          //   ],
          // ),
        ],
      ),
    );
  }
}

          // Expanded(
          //     child: Column(
          //   children: [
          //     Text(
          //       // products is out demo list
          //       product.name,
          //       style: TextStyle(color: kTextLightColor),
          //     ),
          //     Divider(
          //       height: 7,
          //     ),
          //     Text(
          //       "${product.formation}",
          //       style: TextStyle(fontWeight: FontWeight.bold),
          //     ),
          //   ],
          // )
          // ),
