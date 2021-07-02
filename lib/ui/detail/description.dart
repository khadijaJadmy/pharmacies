import 'package:pharmacie/model/pharmacy.model.dart';
import 'package:flutter/material.dart';

import '../../constant.dart';


class Description extends StatelessWidget {
  const Description({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Pharmacy product;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Column(

            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Informations: ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 40),
                    decoration: BoxDecoration(
                        //  color: Colors.green[400],
                        borderRadius: BorderRadius.circular(5)),
                    child: RaisedButton(
                        child: Text(
                          "Commander Online",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.green[400],
                        onPressed: () {}),
                  ),
                ],
              ),
              // Wrap(
              //   children: [
              //     Padding(
              //       padding:
              //           const EdgeInsets.symmetric(vertical: kDefaultPaddin),
              //       child: Wrap(children: [
              //         RichText(
              //           text: TextSpan(
              //             style: Theme.of(context).textTheme.body1,
              //             children: [
              //               TextSpan(text: product.description),
              //             ],
              //           ),
              //         ),
              //       ]),
              //     ), wfvwsdv        //   ],
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Téléphone :', style: TextStyle(fontWeight: FontWeight.bold),),
                  Text('05 22 33 44 55'),
                ],
              ),
              Wrap(children:[ 
                // child:Wrap(RichText( text:TextSpan(text:'Services proposés par la pharmacie : '))
                
                
                
                     Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: kDefaultPaddin),
                    child: Wrap(children: [
                      RichText(
                        text: TextSpan(
                          style: Theme.of(context).textTheme.body1,
                          children: [
                            TextSpan(text: 'Services proposés par la pharmacie'),
                          ],
                        ),
                      ),
                    ]),
                  ),]),
              Row(
                
                children: [
                  
                  Text('Langues parlées à la pharmacie :', style: TextStyle(fontWeight: FontWeight.bold),),
                  
                ],
              ),
              Row(
                children: [
                  Text('Horaires d’ouverture :', style: TextStyle(fontWeight: FontWeight.bold),),
                  Text('Moyens de paiement acceptés : ')
                ],
              )
            ]));
  }
}
