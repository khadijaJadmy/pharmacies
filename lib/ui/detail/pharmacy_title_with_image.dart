import 'package:pharmacie/model/pharmacy.model.dart';
import 'package:flutter/material.dart';

import '../../constant.dart';



class ProductTitleWithImage extends StatelessWidget {
  const ProductTitleWithImage({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Pharmacy product;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.black,
      height: 180,
      padding: EdgeInsets.only(top: 50,left:10),
      decoration: BoxDecoration(
         image: DecorationImage(
            image: NetworkImage(product.image),
            fit: BoxFit.cover,
          ),
      ),
      // child: Padding(
      // padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
         
       
          SizedBox(height: kDefaultPaddin),
          Row(
            children: <Widget>[
              
              RichText(
                text: TextSpan(
                  children: [
                    
                    TextSpan(text: "Pharmacy\n",style: TextStyle(color: Colors.black,fontSize: 20)),
                    TextSpan(
                      text: "${product.name}",
                      style: Theme.of(context).textTheme.headline6.copyWith(
                          color: Colors.black, fontWeight: FontWeight.bold,fontSize: 40),
                    ),
                  
                  ],
                ),
              ),

              // SizedBox(
              //   height: 6,
              // ),
             // Spacer(),

              // Row(
              //   children: [
              //     ClipRRect(
              //       borderRadius: BorderRadius.circular(18.0),
              //       child: Image.asset("assets/images/solution_pharmacy.jpg"
              //        ,
              //         // fit: BoxFit.cover,
              //         width: 106,
              //         height: 100,
              //       ),
              //     ),
              //   ],
              // ),
            ],
          )
        ],
      ),
      //  ),
    );
  }
}
