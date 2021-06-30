import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacie/bloc/pharmacy.action.dart';
import 'package:pharmacie/bloc/pharmacy.bloc.dart';
import 'package:pharmacie/bloc/pharmacy.state.dart';
import 'package:pharmacie/enums/enums.dart';
import 'package:pharmacie/ui/anotherhome/constants.dart';

import 'featurred_plants.dart';
import 'header_with_seachbox.dart';
import 'recomend_plants.dart';
import 'title_with_more_bbtn.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // It will provie us total height  and width of our screen
    Size size = MediaQuery.of(context).size;
    // it enable scrolling on small device
    context.read<PharmaciesBloc>().add(LoadAllPharmaciesEvents());
    return Scaffold(body:
        BlocBuilder<PharmaciesBloc, PharmaciesState>(builder: (context, state) {
      return state.requestState == RequestState.LOADING
          ? Container(
              child: Center(child: Text("no data")),
            )
          : Column(children: [
              Row(
                children: [
                  Text("here"),
                ],
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                // crossAxisAlignment: CrossAxisAlignment.start,
                child: GridView.builder(
                    itemCount: state.pharmacies.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      // childAspectRatio: 0.50,
                    ),
                    itemBuilder: (context, index) => RecomendsPlants(
                          product: state.pharmacies[index],
                        )),
                // HeaderWithSearchBox(size: size),
                // TitleWithMoreBtn(title: "Recomended", press: () {}),
                // RecomendsPlants(),
                // TitleWithMoreBtn(title: "Featured Plants", press: () {}),
                // FeaturedPlants(),
                // SizedBox(height: kDefaultPadding),
              ))
            ]);
    }));
  }
}
