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
  int? _gameS;
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
      _gameS = querySnapshot.get('game_score');
      creditScore = querySnapshot.get('credit_score');
      level = querySnapshot.get('previous_session_info');
    });
  }

  List<BottomDrawer> info = [
    BottomDrawer(
        id: 1,
        image: 'assets/saveMoney.png',
        info:
            'This is your bank balance. Every time you make a purchase the corresponding amount will be deducted from here.',
        text: 'Account Balance'),
    BottomDrawer(
        id: 2,
        image: 'assets/symbol.png',
        info:
            'This indicates your standard of living. The more expensive choices in the game earn higher Quality of Life points. ',
        text: 'Quality Of Life'),
  BottomDrawer(
        id: 3,
        image: 'assets/credit_score.png',
        info:
            'This represents how well you use your Credit Card which depends on various factors. Read the Insights Cards to learn how to maximize your Credit Score.',
        text: 'Credit Score') ,
    // BottomDrawer(
    //     id: 4,
    //     image: 'assets/netWorth.png',
    //     info:
    //         'This indicates your overall financial situation. Acquire more assets and keep your liabilities low to earn a high Net Worth Score.',
    //     text: 'Net Worth'),
    BottomDrawer(
        id: 5,
        image: 'assets/star.png',
        info:
            'This is a total of your Account Balance, Quality of life, Credit Score and Net Worth. You need to balance individual score points to maximise your Game Score.',
        text: 'Game Score'),
  ];

  @override
  void initState() {
    getUserValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: displayWidth(context),
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
          Icon(
            Icons.keyboard_arrow_down,
            size: displayWidth(context) * .10,
            color: Color(0xffC3A7FF),
          ),
          Expanded(
            child:  ListView.builder(
              itemCount:info.length,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        top: displayHeight(context) * .02,
                        left: displayHeight(context) * .08,
                      ),
                      child: index != 2 || level == 'Level_3' ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Image.asset(
                              '${info[index].image}',
                              width: displayWidth(context) * .12,
                              fit: BoxFit.contain,
                            ) ,
                            flex: 2,
                          ),
                          SizedBox(
                            width: displayWidth(context) * .06,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (index == 0) _savingBalance(),
                                if (index == 1) _qualityOfLife(),
                                if (index == 2) _creditScore()  ,
                                if (index == 3) _gameScore(),
                                if (index == 4) _gameScore(),
                                Text(
                                  '${info[index].text}',
                                  style: GoogleFonts.workSans(
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            flex: 10,
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  right: displayWidth(context) * .10),
                              child: Tooltip(
                                message: '${info[index].info}',
                                height: displayHeight(context) * .06,
                                triggerMode: TooltipTriggerMode.tap,
                                textStyle: GoogleFonts.workSans(
                                    color: Color(0xff000072),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400),
                                padding:
                                    EdgeInsets.all(displayWidth(context) * .03),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                      displayWidth(context) * .04),
                                ),
                                preferBelow: false,
                                verticalOffset: displayHeight(context) * .02,
                                margin: EdgeInsets.symmetric(
                                    horizontal: displayWidth(context) * .10),
                                child: Image.asset(
                                  'assets/i.png',
                                  width: displayWidth(context) * .06,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            flex: 3,
                          )
                        ],
                      ) :
                      SizedBox(),
                    ),

                  ],
                );
              },
            ),
          ),
          SizedBox(
            height: displayHeight(context) * .01,
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
  _gameScore() {
    return _gameS.toString().isEmpty
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
                      snapshot.data!['game_score'].toString(),
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

class BottomDrawer {
  int? id;
  String? image;
  String? text;
  String? info;

  BottomDrawer({this.id, this.image, this.text, this.info});

  factory BottomDrawer.fromJson(Map<String, dynamic> json) => BottomDrawer(
        id: json["id"],
        image: json["image"],
        text: json["text"],
        info: json["info"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "text": text,
        "info": info,
      };
}
