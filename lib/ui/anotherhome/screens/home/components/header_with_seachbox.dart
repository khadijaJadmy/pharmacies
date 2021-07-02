import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pharmacie/bloc/pharmacy.action.dart';
import 'package:pharmacie/bloc/pharmacy.bloc.dart';
import 'package:pharmacie/bloc/pharmacy.state.dart';
import 'package:pharmacie/enums/enums.dart';

import '../../../constants.dart';

class HeaderWithSearchBox extends StatelessWidget {
  HeaderWithSearchBox({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  TextEditingController searchController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    context.read<PharmaciesBloc>().add(LoadPharmaciesBySearchName(""));
    return BlocBuilder<PharmaciesBloc, PharmaciesState>(
        builder: (context, state) {
      return
          // state.requestState!=RequestState.LOADED?Container():
          // return
          Container(
        margin: EdgeInsets.only(bottom: kDefaultPadding * 2.5,top: kDefaultPadding),
        // It will cover 20% of our total height
        height: size.height * 0.2,
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                left: kDefaultPadding,
                right: kDefaultPadding,
                bottom: 36 + kDefaultPadding,
              ),
              height: size.height * 0.2 - 27,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(36),
                  bottomRight: Radius.circular(36),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top:20),
                child: Row(
                  
                  children: <Widget>[
                    
                    Text(
                      'Pharmacy Online!',
                      style: Theme.of(context).textTheme.headline5.copyWith(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                    // Spacer(),
                    // Image.asset("assets/images/logo.png")
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                height: 54,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: kPrimaryColor.withOpacity(0.23),
                    ),
                  ],
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Column(
                      children: [
                        // child:
                        TextField(
                          controller: searchController,
                          onSubmitted: (value) {
                            //  context.read<PharmaciesBloc>().add(
                            //    LoadPharmaciesBySearchName()
                            //    );
                            print("YOU HAVE JUST TAPPED SOMETHING");
                           // context.read<PharmaciesBloc>().add(LoadPharmaciesBySearchName());
                            // LoadPharmaciesBySearchName();
                          },
                          decoration: InputDecoration(
                            hintText: "Search",
                            hintStyle: TextStyle(
                              color: kPrimaryColor.withOpacity(0.5),
                            ),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            // suffixIcon: Icons.search
                            // surffix isn't working properly  with SVG
                            // thats why we use row
                            // suffixIcon:SvgPicture.asset("assets/icons/search.svg"),
                          ),
                        ),
                      ],
                    )),
                    // SvgPicture.asset("assets/icons/search.svg"),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

}
