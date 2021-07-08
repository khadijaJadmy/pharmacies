import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pharmacie/bloc/pharmacy.action.dart';
import 'package:pharmacie/bloc/pharmacy.bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacie/bloc/pharmacy.state.dart';
import 'package:pharmacie/categories/category.dart';
import 'package:pharmacie/enums/enums.dart';
import 'package:pharmacie/ui/detail/detail.dart';
import 'package:pharmacie/ui/detail/detailDesign.dart';
import '../../../constants.dart';

class FeaturedPlants extends StatelessWidget {
  const FeaturedPlants({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<PharmaciesBloc>().add(LoadPharmaciesBylocationEvents(""));
    return BlocBuilder<PharmaciesBloc, PharmaciesState>(
        builder: (context, state) {
      return state.requestState2 != RequestState.LOADED
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  for (int i = 0; i < state.pharmaciesbylocation.length; i++)
                    GestureDetector(
                      child: FeaturePlantCard(
                        image: state.pharmaciesbylocation[i].image,
                        id:state.pharmaciesbylocation[i].id,
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailPage(
                                      product: state.pharmacies[i],
                                    )
                                //  DetailScreen(
                                //   product: state.pharmacies[i],
                                // ),
                                ),
                          );
                        },
                        title: state.pharmaciesbylocation[i].name,
                      ),
                    ),
                ],
              ),
            );
    });
  }
}

class FeaturePlantCard extends StatelessWidget {
  const FeaturePlantCard({
    Key key,
    this.image,
    this.press,
    this.title, this.id,
  }) : super(key: key);
  final String image,id;
  final Function press;
  final String title;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.only(
          left: kDefaultPadding,
          top: kDefaultPadding / 2,
          bottom: kDefaultPadding / 2,
        ),
        width: size.width * 0.8,
        height: 185,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(image),
          ),
        ),
        child: Align(
            alignment: Alignment.lerp(Alignment.bottomCenter, Alignment.bottomLeft, 2),
            child: Container(
              width: size.width * 0.8,
              height: 40,
                
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                   borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                ),
                child: Row(
                  children: [
                   // GestureDetector(child: Container(child: Icon(Icons.shop)),
                    // onTap: (){
                    //      Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) => Category(
                    //           id: id,
                    //         ),
                    //       ),
                    //     );
                    // },
                    // ),
                    Container(
                    height: 25,
                    width:50,
                    child: ElevatedButton(
                      
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Category(
                              id: id,
                            ),
                          ),
                        );
                      },
                      child: Center(child: FaIcon(
                                      FontAwesomeIcons.shoppingCart,
                                      size: 15,
                                      color: kPrimaryColor,
                                    )),
                      // Text('Commander',style: TextStyle(fontSize: 12),textAlign: TextAlign.center,),
                      style:
                       ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          
                          // <-- Radius
                        ),
                        primary: Color.fromRGBO(122, 211, 207, 1)
                      ),
                    ),
                  ),
                    SizedBox(width: 30,),
                    Text(
                      
                      title.toUpperCase(),
                      style: TextStyle(fontSize: 16),textAlign: TextAlign.center,
                    ),
                  ],
                )
                )),
      ),
    );
  }
}
