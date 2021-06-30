
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pharmacie/ui/pages/pharmacy/pharmacy.page.dart';

import '../../constant.dart';


class HomeScreen extends StatelessWidget {
  // HomeScreen(Future<void> list);

  // HomeScreen(Future<List<Professor>> listProf);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: PharmaciesPage(),
 
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset("assets/icons/back.svg"),
        onPressed: () {},
      ),
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset(
            "assets/icons/search.svg",
            // By default our  icon color is white
            color: kTextColor,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: SvgPicture.asset(
            "assets/icons/menu.svg",width: 25,
            // By default our  icon color is white
            color: kTextColor,
          ),
          onPressed: () {},
        ),
        SizedBox(width: kDefaultPaddin / 2)
      ],
    );
  }
}