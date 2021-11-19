import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:financial/ReusableScreen/GlobleVariable.dart';
import 'package:financial/Screens/devicesSizePage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

//ignore: must_be_immutable
class PreviewOfBottomDrawer extends StatefulWidget {
  PreviewOfBottomDrawer({Key? key}) : super(key: key);

  @override
  _PreviewOfBottomDrawerState createState() => _PreviewOfBottomDrawerState();
}

class _PreviewOfBottomDrawerState extends State<PreviewOfBottomDrawer> {
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
              Color(0xff553EC4),
              Color(0xff4F47C8),
              Color(0xff4A50CA),
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.vertical(top: Radius.circular(40.0))),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: displayHeight(context) * .02),
            child: Container(
              width: 40,
              height: 6,
              decoration: BoxDecoration(
                  color: Color(0xffC3A7FF),
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: EdgeInsets.only(
                right: displayWidth(context) * .06,
                left: displayWidth(context) * .02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  children: [
                    _savingBalance(),
                    SizedBox(
                      height: 1.0,
                    ),
                    Image.asset(
                      'assets/saveMoney.png',
                      width: displayWidth(context) * .06,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
                if (level == "Level_3")
                  Column(
                    children: [
                      _creditScore(),
                      SizedBox(
                        height: 1.0,
                      ),
                      Image.asset(
                        'assets/credit_score.png',
                        width: displayWidth(context) * .06,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                Column(
                  children: [
                    _qualityOfLife(),
                    SizedBox(
                      height: 1.0,
                    ),
                    Image.asset(
                      'assets/symbol.png',
                      width: displayWidth(context) * .04,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ],
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
                  ));
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
                  ));
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
                  ));
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
