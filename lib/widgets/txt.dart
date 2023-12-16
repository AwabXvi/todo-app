import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';

class Txt {
  // bold
  static Text largeTxt(data, {Color? color, double? fontSize}) {
    return Text(
      '$data',
      softWrap: true,
      style: TextStyle(
        fontSize: fontSize ?? 22.0,
        fontWeight: FontWeight.bold,
        color: color ?? Constants.blackTxtColor,
        fontFamily: Constants.fontFamily,
      ),
    );
  }

  // medium
  static Text mediumTxt(data, {Color? color, double? fontSize,FontWeight? fontWeight}) {
    return Text(
      '$data',
      style: TextStyle(
        fontSize: fontSize ?? 15.0,
        color: color ??  Constants.blackTxtColor,
        // fontWeight: FontWeight.w300,
        fontFamily: Constants.fontFamily,
        fontWeight: fontWeight??FontWeight.normal
      ),
    );
  } // medium

  static Text tinyTxt(data, {double? fontSize, Color? color}) {
    return Text(
      '$data',
      style: TextStyle(
        color: color ??  Constants.blackTxtColor,
        fontSize: fontSize ?? 11.0,
        fontWeight: FontWeight.w100,
        fontFamily: Constants.fontFamily,
      ),
    );
  }

  static Text titleAppBar(data, {double? fontSize, Color? color}) {
    return Text(
      '$data',
      style: TextStyle(
        color: color ??  Constants.blackTxtColor,
        fontSize: fontSize ?? 15.0,
        fontFamily: Constants.fontFamily,
      ),
    );
  }

  static Text subTxt(data, {Color? color, double? fontSize}) {
    return Text(
      '$data',
      style: TextStyle(
        color: color ??  Constants.blackTxtColor,
        fontSize: fontSize ?? 11.0,
        // fontWeight: FontWeight.w100,
        fontFamily: Constants.fontFamily,
      ),
      overflow: TextOverflow.clip,
    );
  }

  static Text transTxt(data, {Color? color}) {
    return Text(
      '$data',
      style: TextStyle(
        fontSize: 12.0,
        // fontWeight: FontWeight.bold,
        color: color ??  Constants.blackTxtColor,
      ),
    );
  }

  // bold
  static Container txtShaddow(data, {Color? color}) {
    return Container(
      child: Center(
        child: Text(
          data.toString(),
          style: const TextStyle(
              color: const Color(0xfffefefe),
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal,
              fontSize: 20.0),
        ),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Color.fromRGBO(236, 60, 3, 1),
              Color.fromRGBO(234, 60, 3, 1),
              Color.fromRGBO(216, 78, 16, 1),
            ],
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.16),
            offset: Offset(0, 5),
            blurRadius: 10.0,
          )
        ],
        borderRadius: BorderRadius.circular(9.0),
      ),
    );
  }
}
