import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:financial/ReusableScreen/GlobleVariable.dart';
import 'package:financial/Screens/devicesSizePage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

//ignore: must_be_immutable
class ExpandedBottomDrawer extends StatefulWidget {
  ExpandedBottomDrawer({Key? key}) : super(key: key);

  @override
  _ExpandedBottomDrawerState createState() => _ExpandedBottomDrawerState();
}

class _ExpandedBottomDrawerState extends State<ExpandedBottomDrawer> {
  var userId;
  int? _qol;
  int? _accountBal;
  int? creditScore;
  String level = '';

  getUserValue() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userId = pref.getString('uId');
    DocumentSnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("User").doc(userId).get();
    setState(() {
      _qol = querySnapshot.get('quality_of_life');
      _accountBal = querySnapshot.get('account_balance');
      creditScore = querySnapshot.get('credit_score');
      level = querySnapshot.get('previous_session_info');
    });
  }

  @override
  void initState() {
    getUserValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff4D6EF2),
              Color(0xff6448E8),
              Color(0xff6448E8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.vertical(top: Radius.circular(40.0))),
      child: Column(
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              width: displayWidth(context),
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(
                    top: displayHeight(context) * .02,
                    left: displayHeight(context) * .08),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/saveMoney.png',
                      width: displayWidth(context) * .12,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(
                      width: displayWidth(context) * .07,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _savingBalance(),
                        Text(
                          'Account Balance',
                          style: GoogleFonts.workSans(
                              color: Colors.white,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (level == "Level_3")
            SizedBox(
              height: displayHeight(context) * .02,
            ),
          if (level == "Level_3")
            Container(
              width: displayWidth(context),
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: displayHeight(context) * .08),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/credit_score.png',
                      width: displayWidth(context) * .09,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(
                      width: displayWidth(context) * .09,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _creditScore(),
                        Text(
                          'Credit Score',
                          style: GoogleFonts.workSans(
                              color: Colors.white,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          SizedBox(
            height: displayHeight(context) * .02,
          ),
          Container(
            width: displayWidth(context),
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: displayHeight(context) * .08),
              child: Row(
                children: [
                  Image.asset(
                    'assets/symbol.png',
                    width: displayWidth(context) * .09,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(
                    width: displayWidth(context) * .09,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _qualityOfLife(),
                      Text(
                        'Quality of life',
                        style: GoogleFonts.workSans(
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _qualityOfLife() {
    return _qol.toString().isEmpty
        ? Center(
            child: Padding(
            padding: EdgeInsets.only(bottom: displayWidth(context) * .02),
            child: SizedBox(
              height: displayHeight(context) * .03,
              width: displayWidth(context) * .06,
              child: CircularProgressIndicator(
                backgroundColor: Colors.white10,
                color: Colors.white10,
              ),
            ),
          ))
        : StreamBuilder<DocumentSnapshot>(
            stream: firestore.collection('User').doc(userId).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('It\'s Error!');
              }
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(
                    child: Padding(
                      padding:
                          EdgeInsets.only(bottom: displayWidth(context) * .02),
                      child: SizedBox(
                        height: displayHeight(context) * .03,
                        width: displayWidth(context) * .06,
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white10,
                          color: Colors.white10,
                        ),
                      ),
                    ),
                  );
                default:
                  return Container(
                    child: Text(
                      snapshot.data!['quality_of_life'].toString(),
                      style: GoogleFonts.robotoCondensed(
                          color: Color(0xff3FAEFF),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  );
              }
            },
          );
  }

  _savingBalance() {
    return _accountBal.toString().isEmpty
        ? Center(
            child: Padding(
            padding: EdgeInsets.only(bottom: displayWidth(context) * .02),
            child: SizedBox(
              height: displayHeight(context) * .03,
              width: displayWidth(context) * .06,
              child: CircularProgressIndicator(
                backgroundColor: Colors.white10,
                color: Colors.white10,
              ),
            ),
          ))
        : StreamBuilder<DocumentSnapshot>(
            stream: firestore.collection('User').doc(userId).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('It\'s Error!');
              }
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(
                    child: Padding(
                      padding:
                          EdgeInsets.only(bottom: displayWidth(context) * .02),
                      child: SizedBox(
                        height: displayHeight(context) * .03,
                        width: displayWidth(context) * .06,
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white10,
                          color: Colors.white10,
                        ),
                      ),
                    ),
                  );
                default:
                  return Container(
                    child: Text(
                      '${'\$${snapshot.data!['account_balance']}'}',
                      style: GoogleFonts.robotoCondensed(
                          color: Color(0xffFEBE16),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  );
              }
            },
          );
  }

  _creditScore() {
    return creditScore.toString().isEmpty
        ? Center(
            child: Padding(
            padding: EdgeInsets.only(bottom: displayWidth(context) * .02),
            child: SizedBox(
              height: displayHeight(context) * .03,
              width: displayWidth(context) * .06,
              child: CircularProgressIndicator(
                backgroundColor: Colors.white10,
                color: Colors.white10,
              ),
            ),
          ))
        : StreamBuilder<DocumentSnapshot>(
            stream: firestore.collection('User').doc(userId).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('It\'s Error!');
              }
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(
                    child: Padding(
                      padding:
                          EdgeInsets.only(bottom: displayWidth(context) * .02),
                      child: SizedBox(
                        height: displayHeight(context) * .03,
                        width: displayWidth(context) * .06,
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white10,
                          color: Colors.white10,
                        ),
                      ),
                    ),
                  );
                default:
                  return Container(
                    child: Text(
                      snapshot.data!['credit_score'].toString(),
                      style: GoogleFonts.robotoCondensed(
                          color: Color(0xff28D38B),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  );
              }
            },
          );
  }
}
