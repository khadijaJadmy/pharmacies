
import 'package:pharmacie/model/pharmacy.model.dart';
import 'package:pharmacie/ui/detail/description.dart';
import 'package:flutter/material.dart';
import 'package:pharmacie/ui/detail/pharmacy_title_with_image.dart';

class  DetailScreen extends StatefulWidget {
  final Pharmacy product;

  const DetailScreen({Key key, this.product}) : super(key: key);
  @override
  _DetailScreenState createState() => _DetailScreenState();
}


class _DetailScreenState extends State<DetailScreen> {
  // final Pharmacy product;
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          body: SafeArea(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverPersistentHeader(
                  pinned: false,
                  floating: true,
                  delegate: CustomSliverDelegate(
                    expandedHeight: 100,
                    product:widget.product
                  ),
                ),
                SliverFillRemaining(
                  child: Column(
                  children: <Widget>[
                     SizedBox(
                  height: 30,
                ),            
                    Description(product: widget.product),
                    // PreRequis(product: widget.product),
                    SizedBox(height: 30,),
                    // ProductTitleWithImage(product:  widget.product,),
                    //             
                  ],
                ),
                ),
              ],
            ),
          ),
        );
      }
    }

    class CustomSliverDelegate extends SliverPersistentHeaderDelegate {
      final double expandedHeight;
      final bool hideTitleWhenExpanded;
      final Pharmacy product;

      CustomSliverDelegate({
        @required this.expandedHeight,
        this.hideTitleWhenExpanded = true,
        @required this.product
      });

      @override
      Widget build(
          BuildContext context, double shrinkOffset, bool overlapsContent) {
       
        return  Container(
            color: Colors.blue[500],
            // height: 500,
            child: Stack(
              children: [
                
                Positioned(
                  left: 0.0,
                  right: 0.0,
                  bottom: 0.0,
                  child: ProductTitleWithImage(product: product),
                ),  
              ],
            ),
        
        );
      }

      @override
      double get maxExtent => expandedHeight + expandedHeight /2;

      @override
      double get minExtent => kToolbarHeight;

      @override
      bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
        return true;
      }
    }
