import 'package:flutter/material.dart';

Color mC = Colors.grey[850];
Color mCL = Colors.grey[800];
Color mCD = Colors.grey[900];
Color mCC = Colors.green.withOpacity(0.65);
Color fCD = Colors.grey[400];
Color fCL = Colors.grey;

BoxDecoration nMbox = BoxDecoration(
    borderRadius: BorderRadius.circular(15),
    color: mC,
    //image: imageUrl!=null?DecorationImage(image: NetworkImage(imageUrl)):DecorationImage(image: null),
    boxShadow: [
      BoxShadow(
        color: mCD,
        offset: Offset(10, 10),
        blurRadius: 15,
        spreadRadius: 1.0
      ),
      BoxShadow(
        color: mCL,
        offset: Offset(-10, -10),
        blurRadius: 15,
        spreadRadius: 1.0
      ),
    ]);

BoxDecoration nMboxInvert = BoxDecoration(
    borderRadius: BorderRadius.circular(15),
    color: mCD,
    boxShadow: [
      BoxShadow(
          color: mCL, offset: Offset(3, 3), blurRadius: 3, spreadRadius: -3),
    ]);

BoxDecoration nMboxInvertActive = nMboxInvert.copyWith(color: mCC);

BoxDecoration nMbtn = BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: mC,
    boxShadow: [
      BoxShadow(
        color: mCD,
        offset: Offset(2, 2),
        blurRadius: 2,
      )
    ]);
