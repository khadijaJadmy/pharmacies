import 'package:flutter/material.dart';
import 'package:pharmacie/bloc/pharmacy.action.dart';
import 'package:pharmacie/bloc/pharmacy.bloc.dart';
import 'package:pharmacie/bloc/pharmacy.state.dart';
import 'package:pharmacie/enums/enums.dart';
import 'package:pharmacie/model/pharmacy.model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:pharmacie/ui/detail/detail.dart';
import 'package:pharmacie/ui/home/item_card.dart';
import 'package:pharmacie/ui/map/map.dart';
import 'package:pharmacie/ui/map/mapview.dart';
import 'package:pharmacie/ui/map/polyline.dart';

class PharmaciesPage extends StatelessWidget {
  // Pharmacy pharmacy;
  // List<Pharmacy> pharmacies;
  // PharmaciesPage({this.pharmacies});
  @override
  Widget build(BuildContext context) {
    //  this.pharmacy = ModalRoute.of(context).settings.arguments;
    context.read<PharmaciesBloc>().add(LoadAllPharmaciesEvents());
    return Scaffold(body: BlocBuilder<PharmaciesBloc, PharmaciesState>(
      builder: (context, state) {
        return state.requestState == RequestState.LOADING
            ? Container()
            : 
            // SingleChildScrollView(
             Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: GridView.builder(
                            itemCount: state.pharmacies.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              // childAspectRatio: 0.50,
                            ),
                            itemBuilder: (context, index) => ItemCard(
                                product: state.pharmacies[index],
                                press: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MapView(),
                                      ));
                                })),
                      ),
                    ),
                  ],
               // ),
            );

      },
    ));
  }
}

class PharmaciesByContactEvent {}
