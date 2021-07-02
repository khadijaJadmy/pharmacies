import 'package:flutter/material.dart';

import '../../../constants.dart';

class TitleWithMoreBtn extends StatelessWidget {
  const TitleWithMoreBtn({
    Key key,
    this.title,
    this.press,
    this.line,
  }) : super(key: key);
  final String title;
  final Function press;
  final bool line;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Row(
        children: <Widget>[
          TitleWithCustomUnderline(text: title, line: line),
          // SizedBox(height: 10,),
          // Spacer(),
          // FlatButton(
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(26),
          //   ),
          //   color: Colors.green[100],
          //   onPressed: press,
          //   child: Text(
          //     "More",
          //     style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400),
          //   ),
          // ),
        ],
      ),
    );
  }
}

class TitleWithCustomUnderline extends StatelessWidget {
  const TitleWithCustomUnderline({
    Key key,
    this.text,
    this.line,
  }) : super(key: key);

  final String text;
  final bool line;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 23,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: kDefaultPadding / 4),
            child: Wrap(
              children: [
                RichText(
                    text: TextSpan(children: [
                  WidgetSpan(child: line==true?Icon(Icons.list):Icon(Icons.location_on)),
              
                  TextSpan(
                      text: ' '+text,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black))
                ]))
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.only(right: kDefaultPadding / 4),
              height: line == true ? 7 : 0,
              color: kPrimaryColor.withOpacity(0.4),
            ),
          )
        ],
      ),
    );
  }
}
