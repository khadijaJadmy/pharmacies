import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pharmacie/bloc/pharmacy.action.dart';
import 'package:pharmacie/bloc/pharmacy.bloc.dart';
import 'package:pharmacie/bloc/pharmacy.state.dart';
import 'package:pharmacie/enums/enums.dart';
import 'package:pharmacie/ui/anotherhome/constants.dart';
import 'package:pharmacie/ui/map/map2.dart';
import 'package:pharmacie/ui/map/mapview.dart';

import 'featurred_plants.dart';
import 'header_with_seachbox.dart';
import 'recomend_plants.dart';
import 'title_with_more_bbtn.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // It will provie us total height  and width of our screen
    Size size = MediaQuery.of(context).size;
    TextEditingController searchController = new TextEditingController();

    // it enable scrolling on small device
    // context.read<PharmaciesBloc>().add(LoadPharmaciesBySearchName(searchController.text));
    return Scaffold(

        drawer: buildDraweer(context),
        body:
            //   BlocBuilder<PharmaciesBloc, PharmaciesState>(builder: (context, state) {
            // return state.requestState == RequestState.LOADING
            //     ? Container(
            //         child: Center(child: Text("no data")),
            //       )
            //     :
            SingleChildScrollView(
                child: Column(children: [
          //  HeaderWithSearchBox(size: size),
          Container(
            margin: EdgeInsets.only(
                bottom: kDefaultPadding * 2.5, top: kDefaultPadding),
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
                    padding: const EdgeInsets.only(top: 20,left:24),
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
                GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.only(top:33.0,left:8),
                    child: Icon(Icons.menu,color:Colors.white,size: 30,),
                    
                  ),
                
              onTap: () => Scaffold.of(context).openDrawer()

                  
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
                                // searchController.text=value;
                                context
                                    .read<PharmaciesBloc>()
                                    .add(LoadPharmaciesBySearchName(value));
                                // // LoadPharmaciesBySearchName();
                                
                             
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
          ),

          TitleWithMoreBtn(
              title: "Liste des pharmacies", press: () {}, line: true),
          SizedBox(height: 10),
          RecomendsPlants(),
          TitleWithMoreBtn(
              title: "Pharmacies près de chez vous ", press: () {}, line: false),
          SizedBox(height: 10),
          FeaturedPlants(),
          SizedBox(height: kDefaultPadding),
          //
          // )
        ]))
        // })
        );
  }

  Widget buildDraweer(context) {
    return Drawer(
      child: Material(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            //   buildHeader(
            //     urlImage: urlImage,
            //     name: name,
            //     email: email,
            //     onClicked: () => Navigator.of(context).push(MaterialPageRoute(
            //       builder: (context) => UserPage(
            //         name: 'Sarah Abs',
            //         urlImage: urlImage,
            //       ),
            //     )),
            //  ),
            Align(
              child: Container(
                width: 150,
                height: 7,
                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://as1.ftcdn.net/v2/jpg/02/77/54/10/1000_F_277541068_AWyUajW9TxNUrqhda3aCmNbAXITdKZBL.jpg"),
                      fit: BoxFit.fitHeight)),
            ),
            Container(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  // const SizedBox(height: 6),
                  // buildSearchField(),
                  const SizedBox(height: 20),
                  buildMenuItem(
                      text: 'Track your commande',
                      icon: Icons.book,
                      onClicked: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MapView(),
                            ));
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem({
    @required String text,
    @required IconData icon,
    VoidCallback onClicked,
  }) {
    final color = Colors.black;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }
}
