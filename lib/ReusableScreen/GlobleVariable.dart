library globals;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//for store select plan(rent,tv etc) value
int globalVar = 0;
int forPlan1 = 0;
int forPlan2 = 0;
int forPlan3 = 0;
int forPlan4 = 0;

//to store bal,qol,gs
int balance = 0;
int qualityOfLife = 0;
int gameScore = 0;

//counting for max 100 plus in credit score
int creditCount = 100;

//create firestore instance
FirebaseFirestore firestore = FirebaseFirestore.instance;

//decoration
BoxDecoration boxDecoration = BoxDecoration(
    gradient: LinearGradient(
  colors: [
    Color(0xff6646E6),
    Color(0xff6646E6),
    Color(0xff4D6EF2),
    Color(0xff4D6EF2),
    Color(0xff6448E8),
    Color(0xff6448E8),
  ],
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
));
