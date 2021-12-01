import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:financial/ReusableScreen/ExpandedBottomDrawer.dart';
import 'package:financial/ReusableScreen/GameScorePage.dart';
import 'package:financial/ReusableScreen/GlobleVariable.dart';
import 'package:financial/Screens/LevelOneSetUpPage.dart';
import 'package:financial/Screens/LevelThreeSetUpPage.dart';
import 'package:financial/ReusableScreen/PreviewOfBottomDrawer.dart';
import 'package:financial/Screens/LevelTwoSetUpPage.dart';
import 'package:financial/Screens/PopQuiz.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:financial/Model/QueModel.dart';
import 'package:financial/Screens/devicesSizePage.dart';
import 'package:flutter/cupertino.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:draggable_bottom_sheet/draggable_bottom_sheet.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

//ignore: must_be_immutable
class AllQueLevelThree extends StatefulWidget {
  String level = '';
  int levelId = 0;
  int billPayment = 0;
  int qOl = 0;
  int savingBalance = 0;
  int gameScore = 0;
  int creditCardBalance = 0;
  int creditCardBill = 0;
  int payableBill = 0;

  AllQueLevelThree(
      {Key? key,
      required this.level,
      required this.levelId,
      required this.gameScore,
      required this.billPayment,
      required this.qOl,
      required this.savingBalance,
      required this.creditCardBill,
      required this.payableBill,
      required this.creditCardBalance})
      : super(key: key);

  @override
  _AllQueLevelThreeState createState() => _AllQueLevelThreeState();
}

class _AllQueLevelThreeState extends State<AllQueLevelThree> {
  //user value
  var userId;
  var document;
  int levelId = 0;
  String level = '';
  int savingBalance = 0;
  int qOl = 0;
  int gameScore = 0;
  int creditScore = 0;
  int score = 0;
  int priceOfOption = 0;
  String option = '';
  int creditBill = 0;
  int creditBal = 0;
  int payableBill = 0;

  //get bill data
  int billPayment = 0;
  int forPlan1 = 0;
  int forPlan2 = 0;
  int forPlan3 = 0;
  int forPlan4 = 0;

  //page controller
  PageController controller = PageController();

  //for indexing
  int currentIndex = 0;

  //for option selection
  bool flag1 = false;
  bool flag2 = false;
  bool scroll = true;
  List<int> payArray = [];
  Color color = Colors.white;
  bool flagForKnow = false;

  //for model
  QueModel? queModel;
  List<QueModel> list = [];

  Future<QueModel?> getLevelId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userId = pref.getString('uId');
    forPlan1 = pref.getInt('plan1')!;
    forPlan2 = pref.getInt('plan2')!;
    forPlan3 = pref.getInt('plan3')!;
    forPlan4 = pref.getInt('plan4')!;

    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("Level_3").get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var a = querySnapshot.docs[i];
      queModel = QueModel();
      queModel?.id = a['id'];
      setState(() {
        list.add(queModel!);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getLevelId();
    levelId = widget.levelId;
    level = widget.level;
    savingBalance = widget.savingBalance;
    qOl = widget.qOl;
    gameScore = widget.gameScore;
    billPayment = widget.billPayment;
    balance = savingBalance;
    qualityOfLife = qOl;
    controller = PageController(initialPage: levelId);

    if (levelId == 0)
      Future.delayed(Duration(milliseconds: 10), () => _salaryCredited());
  }

  @override
  Widget build(BuildContext context) {
    //var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var forPortrait = displayHeight(context);
    var bottomHeightPotrait = displayHeight(context) * .14;
    forPortrait = forPortrait - bottomHeightPotrait;

    var forLandScrap = displayHeight(context);
    var bottomHeightLand = displayHeight(context) * .22;
    forLandScrap = forLandScrap - bottomHeightLand;
    color = Colors.white;

    return SafeArea(
        child: Container(
      width: displayWidth(context),
      height: displayHeight(context),
      decoration: boxDecoration,
      child: list.isEmpty
          ? Center(
              child: CircularProgressIndicator(
              backgroundColor: Colors.black,
            ))
          : StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Level_3')
                  .orderBy('id')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('It\'s Error!');
                }
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.black,
                      ),
                    );
                  default:
                    return PageView.builder(
                        itemCount: snapshot.data!.docs.length,
                        controller: controller,
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        onPageChanged: (value) {
                          flag1 = false;
                          flag2 = false;
                          flagForKnow = false;
                          color = Colors.white;

                          if ((document['week'] == 3 ||
                                  document['week'] % 4 == 3) &&
                              document['week'] != 0) _billPayment();

                          if ((document['week'] % 4 == 0) &&
                              document['week'] != 0) _creditCardBillPayment();

                          if ((document['week'] % 4 == 1) &&
                              document['week'] != 0) _salaryCredited();
                        },
                        itemBuilder: (context, index) {
                          currentIndex = index;
                          document = snapshot.data!.docs[index];
                          levelId = index;
                          print('main $balance');
                          return document['card_type'] == 'GameQuestion'
                              ? Scaffold(
                                  backgroundColor: Colors.transparent,
                                  body: DoubleBackToCloseApp(
                                    snackBar: const SnackBar(
                                      content: Text('Tap back again to leave'),
                                    ),
                                    child: DraggableBottomSheet(
                                      backgroundWidget: Container(
                                        width: displayWidth(context),
                                        height: forPortrait,
                                        decoration: boxDecoration,
                                        child: Column(
                                          children: [
                                            GameScorePage(
                                              level: level,
                                              document: document,
                                            ),
                                            Flexible(
                                              child: Container(
                                                alignment: Alignment.center,
                                                height: forPortrait * .86 -
                                                    bottomHeightPotrait,
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  width: displayWidth(context) *
                                                      .80,
                                                  height: forPortrait * .81 -
                                                      bottomHeightPotrait,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        displayWidth(context) *
                                                            .08,
                                                      ),
                                                      color: Color(0xff6A81F4)),
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets.only(
                                                              top: displayHeight(
                                                                      context) *
                                                                  .03,
                                                              left: displayWidth(
                                                                      context) *
                                                                  .03,
                                                              right: displayWidth(
                                                                      context) *
                                                                  .03),
                                                          child: Text(
                                                            document[
                                                                'description'],
                                                            style: GoogleFonts
                                                                .workSans(
                                                              fontSize: 16.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                        //option1(index,document),
                                                        Padding(
                                                          padding: EdgeInsets.only(
                                                              top: displayHeight(
                                                                      context) *
                                                                  .03),
                                                          child:  StatefulBuilder(
                                                                  builder: (context,
                                                                      _setState1) {
                                                                  return Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    width: displayWidth(
                                                                            context) *
                                                                        .62,
                                                                    height:
                                                                        displayHeight(context) *
                                                                            .07,
                                                                    decoration: BoxDecoration(
                                                                        color: list[index].isSelected1 ==
                                                                                true
                                                                            ? Color(
                                                                                0xff00C673)
                                                                            : Colors
                                                                                .white,
                                                                        borderRadius:
                                                                            BorderRadius.circular(displayWidth(context) *
                                                                                .12)),
                                                                    child:
                                                                        SizedBox(
                                                                      height:
                                                                          displayHeight(context) *
                                                                              .07,
                                                                      width: displayWidth(
                                                                              context) *
                                                                          .62,
                                                                      child:list[index]
                                                                          .isSelected2 ==
                                                                          true ||
                                                                          list[index]
                                                                              .isSelected1 ==
                                                                              true
                                                                          ? TextButton(
                                                                          style: ButtonStyle(alignment: Alignment.centerLeft),
                                                                          onPressed: ()  {
                                                                          },
                                                                          child: Center(
                                                                            child:
                                                                                FittedBox(
                                                                              child: RichText(
                                                                                textAlign: TextAlign.left,
                                                                                overflow: TextOverflow.clip,
                                                                                text: TextSpan(
                                                                                  text: document['option_1'],
                                                                                  style: GoogleFonts.workSans(color: list[index].isSelected1 == true ? Colors.white : Color(0xffFFA500), fontWeight: FontWeight.w500, fontSize: 15.sp),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          )) : TextButton(
                                                                          style: ButtonStyle(alignment: Alignment.centerLeft),
                                                                          onPressed: () async {
                                                                            _setState1(() {
                                                                              flag1 = true;
                                                                            });

                                                                            if (flag2 ==
                                                                                false) {
                                                                              list[index].isSelected1 = true;
                                                                              int qol1 = document['quality_of_life_1'];
                                                                              priceOfOption = document['option_1_price'];
                                                                              option = document['option_1'];
                                                                              var category = document['category'];
                                                                              qualityOfLife = qualityOfLife + qol1;
                                                                              _optionSelect(index, qualityOfLife, balance, qol1, creditBal, creditScore, creditCount, payableBill, snapshot, document, score, priceOfOption, option, _setState1, category);
                                                                            } else {
                                                                              Fluttertoast.showToast(msg: 'Sorry, you already selected option');
                                                                            }
                                                                          },
                                                                          child: Center(
                                                                            child:
                                                                            FittedBox(
                                                                              child: RichText(
                                                                                textAlign: TextAlign.left,
                                                                                overflow: TextOverflow.clip,
                                                                                text: TextSpan(
                                                                                  text: document['option_1'],
                                                                                  style: GoogleFonts.workSans(color: list[index].isSelected1 == true ? Colors.white : Color(0xffFFA500), fontWeight: FontWeight.w500, fontSize: 15.sp),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          )),
                                                                    ),
                                                                  );
                                                                }),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.only(
                                                              top: displayHeight(
                                                                      context) *
                                                                  .02),
                                                          child: StatefulBuilder(
                                                                  builder: (context,
                                                                      _setState2) {
                                                                  return Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    width: displayWidth(
                                                                            context) *
                                                                        .62,
                                                                    height:
                                                                        displayHeight(context) *
                                                                            .07,
                                                                    decoration: BoxDecoration(
                                                                        color: list[index].isSelected2 ==
                                                                                true
                                                                            ? Color(
                                                                                0xff00C673)
                                                                            : Colors
                                                                                .white,
                                                                        borderRadius:
                                                                            BorderRadius.circular(displayWidth(context) *
                                                                                .12)),
                                                                    child:
                                                                        SizedBox(
                                                                      height:
                                                                          displayHeight(context) *
                                                                              .07,
                                                                      width: displayWidth(
                                                                              context) *
                                                                          .62,
                                                                      child:list[index]
                                                                          .isSelected2 ==
                                                                          true ||
                                                                          list[index]
                                                                              .isSelected1 ==
                                                                              true
                                                                          ? TextButton(
                                                                          style: ButtonStyle(alignment: Alignment.centerLeft),
                                                                          onPressed: ()  {
                                                                          },
                                                                          child: Center(
                                                                            child:
                                                                                FittedBox(
                                                                              child: RichText(
                                                                                overflow: TextOverflow.clip,
                                                                                textAlign: TextAlign.left,
                                                                                text: TextSpan(
                                                                                  text: document['option_2'],
                                                                                  style: GoogleFonts.workSans(color: list[index].isSelected2 == true ? Colors.white : Color(0xffFFA500), fontWeight: FontWeight.w500, fontSize: 15.sp),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          )) : TextButton(
                                                                          style: ButtonStyle(alignment: Alignment.centerLeft),
                                                                          onPressed: () async {
                                                                            _setState2(() {
                                                                              flag2 = true;
                                                                            });

                                                                            if (flag1 ==
                                                                                false) {
                                                                              list[index].isSelected2 = true;

                                                                              int qol2 = document['quality_of_life_2'];
                                                                              qualityOfLife = qualityOfLife + qol2;
                                                                              priceOfOption = document['option_2_price'];
                                                                              option = document['option_2'];
                                                                              var category = document['category'];
                                                                              _optionSelect(index, qualityOfLife, balance, qol2, creditBal, creditScore, creditCount, payableBill, snapshot, document, score, priceOfOption, option, _setState2, category);
                                                                            } else {
                                                                              Fluttertoast.showToast(msg: 'Sorry, you already selected option');
                                                                            }
                                                                          },
                                                                          child: Center(
                                                                            child:
                                                                            FittedBox(
                                                                              child: RichText(
                                                                                overflow: TextOverflow.clip,
                                                                                textAlign: TextAlign.left,
                                                                                text: TextSpan(
                                                                                  text: document['option_2'],
                                                                                  style: GoogleFonts.workSans(color: list[index].isSelected2 == true ? Colors.white : Color(0xffFFA500), fontWeight: FontWeight.w500, fontSize: 15.sp),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          )),
                                                                    ),
                                                                  );
                                                                }),
                                                        ),
                                                        SizedBox(
                                                          height: displayHeight(
                                                                  context) *
                                                              .02,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      previewChild: PreviewOfBottomDrawer(),
                                      expandedChild: ExpandedBottomDrawer(),
                                      minExtent: displayHeight(context) * .14,
                                      maxExtent: displayHeight(context) * .55,
                                    ),
                                  ),
                                )
                              : __insightsPage(index, snapshot, document);
                        });
                }
              },
            ),
    ));
  }

  __insightsPage(
      int index, AsyncSnapshot<QuerySnapshot<Object?>> snapshot, document) {
    var forPortrait = displayHeight(context);
    var bottomHeightPotrait = displayHeight(context) * .14;
    forPortrait = forPortrait - bottomHeightPotrait;
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: DoubleBackToCloseApp(
          snackBar: const SnackBar(
            content: Text('Tap back again to leave'),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                GameScorePage(
                  level: level,
                  document: document,
                ),
                SizedBox(
                  height: forPortrait * .04,
                ),
                Padding(
                  padding: EdgeInsets.only(top: forPortrait * .03),
                  child: Container(
                    height: forPortrait * .64,
                    width: displayWidth(context) * .80,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(displayWidth(context) * .08),
                        color: Colors.white),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(
                                      displayWidth(context) * .08),
                                  topLeft: Radius.circular(
                                      displayWidth(context) * .08),
                                ),
                                color: Color(0xffE9E5FF)),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: displayHeight(context) * .02),
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: displayWidth(context) * .06),
                                  child: Image.asset(
                                    'assets/knowledge_image.png',
                                    width: displayWidth(context) * .60,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                            width: displayWidth(context),
                          ),
                          height: forPortrait * .16,
                        ),
                        SizedBox(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(
                                      left: displayWidth(context) * .05,
                                      right: displayWidth(context) * .05,
                                      top: displayWidth(context) * .04,
                                      bottom: displayWidth(context) * .02,
                                    ),
                                    child: Text(
                                      document['description'],
                                      style: GoogleFonts.workSans(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15.sp),
                                      textAlign: TextAlign.justify,
                                    ))
                              ],
                            ),
                          ),
                          height: forPortrait * .48,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: forPortrait * .06,
                ),
                StatefulBuilder(builder: (context, setState) {
                  return flagForKnow
                      ? GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: displayHeight(context) * .08,
                            width: displayWidth(context) * .75,
                            decoration: BoxDecoration(
                                color: flagForKnow
                                    ? Color(0xff00C673)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(
                                    displayWidth(context) * .12)),
                            child: Center(
                              child: Text(
                                'Continue',
                                style: GoogleFonts.workSans(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: flagForKnow
                                        ? Colors.white
                                        : Color(0xff6D00C2)),
                              ),
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () async {
                            setState(() {
                              flagForKnow = true;
                              color = Color(0xff00C673);
                            });
                            if (index == snapshot.data!.docs.length - 1) {
                              DocumentSnapshot documentSnapshot =
                                  await firestore
                                      .collection('User')
                                      .doc(userId)
                                      .get();
                              bool value = documentSnapshot.get('replay_level');
                              level = documentSnapshot.get('last_level');
                              gameScore = documentSnapshot.get('game_score');
                              level = level.toString().substring(6, 7);
                              int lev = int.parse(level);
                              if (value == true) {
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) {
                                      return WillPopScope(
                                        onWillPop: () {
                                          return Future.value(false);},
                                        child: AlertDialog(
                                          elevation: 3.0,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(
                                                  displayWidth(context) * .04)),
                                          titlePadding: EdgeInsets.zero,
                                          title: Container(
                                            width: displayWidth(context),
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                'Congratulations! You have completed this level successfully',
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.workSans(
                                                    fontSize: 14.sp,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500),
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(
                                                      displayWidth(context) *
                                                          .04),
                                                  topLeft: Radius.circular(
                                                      displayWidth(context) *
                                                          .04),
                                                ),
                                                color: Color(0xffE9E5FF)),
                                          ),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              if (lev > 1)
                                                Text(
                                                  'Which level you want play ?',
                                                  style: GoogleFonts.workSans(
                                                      fontSize: 12.sp,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              if (lev > 1) _level1(lev),
                                              if (lev > 2) _level2(lev),
                                              if (lev > 3) _level3(lev),
                                              if (lev > 4) _level4(lev),
                                              if (lev > 5) _level5(lev),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: displayHeight(context) *
                                                        .03),
                                                child: Text(
                                                  'Want to play current level ?',
                                                  style: GoogleFonts.workSans(
                                                      fontSize: 12.sp,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                              if (lev == 1) _level1(lev),
                                              if (lev == 2) _level2(lev),
                                              if (lev == 3) _level3(lev),
                                              if (lev == 4) _level4(lev),
                                              if (lev == 5) _level5(lev),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              } else {
                                Future.delayed(
                                    Duration(seconds: 1),
                                    () => _levelCompleteSummary(context,
                                        gameScore, balance, qualityOfLife));
                              }
                            } else {
                              FirebaseFirestore.instance
                                  .collection('User')
                                  .doc(userId)
                                  .update({
                                'level_id': index + 1,
                              });
                              controller.nextPage(
                                  duration: Duration(seconds: 1),
                                  curve: Curves.easeIn);
                            }
                          },
                          child: Container(
                            height: displayHeight(context) * .08,
                            width: displayWidth(context) * .75,
                            decoration: BoxDecoration(
                                color: flagForKnow
                                    ? Color(0xff00C673)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(
                                    displayWidth(context) * .12)),
                            child: Center(
                              child: Text(
                                'Continue',
                                style: GoogleFonts.workSans(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: flagForKnow
                                        ? Colors.white
                                        : Color(0xff6D00C2)),
                              ),
                            ),
                          ));
                }),
                SizedBox(
                  height: forPortrait * .08,
                ),
              ],
            ),
          ),
        ));
  }

  _showDialogForRestartLevel(BuildContext context) async {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return WillPopScope(
            onWillPop: () {
              return Future.value(false);},
            child: AlertDialog(
              elevation: 3.0,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(displayWidth(context) * .04)),
              actionsPadding: EdgeInsets.all(8.0),
              backgroundColor: Color(0xff6646E6),
              content: Text(
                'Oops! You do not have enough money in your account to make this purchase. \n Press restart to try again.',
                style: GoogleFonts.workSans(
                    color: Colors.white, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      firestore.collection('User').doc(userId).update({
                        'previous_session_info': 'Level_3_setUp_page',
                        'bill_payment': 0,
                        'credit_card_bill': 500,
                        'game_score': 0,
                        'account_balance': 0,
                        'quality_of_life': 0,
                        'level_id': 0
                      });
                      Navigator.pushReplacement(
                          context,
                          PageTransition(
                              child: LevelThreeSetUpPage(
                                  controller: PageController()),
                              type: PageTransitionType.bottomToTop,
                              duration: Duration(milliseconds: 500)));
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.white)),
                    child: Text(
                      'Restart level',
                      style: GoogleFonts.workSans(
                        color: Color(0xff6646E6),
                      ),
                    )),
              ],
            ),
          );
        });
  }

  _showDialogCreditBalNotEnough(
      BuildContext context,
      int balance,
      price,
      PageController controller,
      int gameScore,
      int qualityOfLife,
      int qol2,
      bool scroll,
      int index) async {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return WillPopScope(
            onWillPop: () {
              return Future.value(false);},
            child: AlertDialog(
              elevation: 3.0,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(displayWidth(context) * .04)),
              actionsPadding: EdgeInsets.all(8.0),
              backgroundColor: Color(0xff6646E6),
              content: Text(
                "You have exceeded your Credit Card limit. This amount will be deducted from your debit balance. Please note that exceeding your Credit Limit negatively affects your Credit Score.",
                style: GoogleFonts.workSans(
                    color: Colors.white, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Future.delayed(Duration(seconds: 1),
                          () => Navigator.of(context).pop()).then((value) {
                        if (balance >= price) {
                          balance = ((balance - price) as int?)!;
                          firestore.collection('User').doc(userId).update({
                            'account_balance': balance,
                            'quality_of_life': FieldValue.increment(qol2),
                            'game_score': gameScore + balance + qualityOfLife,
                            'level_id': index + 1,
                          });
                          controller.nextPage(
                              duration: Duration(seconds: 1),
                              curve: Curves.easeIn);
                        } else {
                          //setState(() {
                          scroll = false;
                          //});
                          _showDialogForRestartLevel(context);
                        }
                      });
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.white)),
                    child: Text(
                      'Ok',
                      style: GoogleFonts.workSans(
                        color: Color(0xff6646E6),
                      ),
                    )),
              ],
            ),
          );
        });
  }

  _showDialogDebitBalNotEnough(
      BuildContext context,
      creditBill,
      int balance,
      price,
      PageController controller,
      int gameScore,
      int qualityOfLife,
      int qol2,
      bool scroll,
      int index) async {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return WillPopScope(
            onWillPop: () {
              return Future.value(false);},
            child: AlertDialog(
              elevation: 3.0,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(displayWidth(context) * .04)),
              actionsPadding: EdgeInsets.all(8.0),
              backgroundColor: Color(0xff6646E6),
              content: Text(
                "You have exceeded your Debit Card limit. Please pay using Credit Card to make this purchase.",
                style: GoogleFonts.workSans(
                    color: Colors.white, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Future.delayed(
                              Duration(seconds: 1), () => Navigator.pop(context))
                          .then((value) {
                        if (creditBal >= price) {
                          firestore.collection('User').doc(userId).update({
                            'credit_card_bill': FieldValue.increment(price),
                            'quality_of_life': FieldValue.increment(qol2),
                            'game_score': gameScore + balance + qualityOfLife,
                            'credit_card_balance': FieldValue.increment(-price),
                            'level_id': index + 1,
                          });
                          controller.nextPage(
                              duration: Duration(seconds: 1),
                              curve: Curves.easeIn);
                        } else {
                          //  setState(() {
                          scroll = false;
                          // });
                          _showDialogForRestartLevel(context);
                        }
                      });
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.white)),
                    child: Text(
                      'Ok',
                      style: GoogleFonts.workSans(
                        color: Color(0xff6646E6),
                      ),
                    )),
              ],
            ),
          );
        });
  }

  _billPayment() {
    var forPortrait = displayHeight(context);
    var bottomHeightPotrait = displayHeight(context) * .14;
    forPortrait = forPortrait - bottomHeightPotrait;
    return showDialog(
        context: context, // <<----
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () {
              return Future.value(false);},
            child: Container(
              width: displayWidth(context),
              height: displayHeight(context),
              decoration: boxDecoration,
              child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: DraggableBottomSheet(
                    backgroundWidget: Container(
                      width: displayWidth(context),
                      height: forPortrait,
                      decoration: boxDecoration,
                      child: Column(
                        children: [
                          GameScorePage(
                            level: level,
                            document: document,
                          ),
                          Flexible(
                            child: Container(
                              alignment: Alignment.center,
                              height: forPortrait * .86 - bottomHeightPotrait,
                              child: Container(
                                alignment: Alignment.center,
                                width: displayWidth(context) * .80,
                                height: forPortrait * .81 - bottomHeightPotrait,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      displayWidth(context) * .08,
                                    ),
                                    color: Color(0xff6A81F4)),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: displayHeight(context) * .02,
                                            left: displayWidth(context) * .03,
                                            right: displayWidth(context) * .03),
                                        child: Text(
                                          'BILLS DUE!',
                                          style: GoogleFonts.workSans(
                                            fontSize: 22.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: displayHeight(context) * .03,
                                            left: displayWidth(context) * .04,
                                            right: displayWidth(context) * .04),
                                        child: Text(
                                          'Your monthly bills have been generated. ',
                                          style: GoogleFonts.workSans(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: displayHeight(context) * .02,
                                        ),
                                        child: Center(
                                          child: RichText(
                                            textAlign: TextAlign.left,
                                            overflow: TextOverflow.clip,
                                            text: TextSpan(
                                                text: 'Rent ',
                                                style: GoogleFonts.workSans(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16.sp),
                                                children: [
                                                  TextSpan(
                                                    text: '\$',
                                                    style: GoogleFonts.workSans(
                                                        color:
                                                            Color(0xffFEBE16),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16.sp),
                                                  ),
                                                  TextSpan(
                                                    text: forPlan1.toString(),
                                                    style: GoogleFonts.workSans(
                                                        color:
                                                            Color(0xffFEBE16),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16.sp),
                                                  ),
                                                ]),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: displayHeight(context) * .01,
                                        ),
                                        child: Center(
                                          child: RichText(
                                            textAlign: TextAlign.left,
                                            overflow: TextOverflow.clip,
                                            text: TextSpan(
                                                text: 'TV & Internet ',
                                                style: GoogleFonts.workSans(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16.sp),
                                                children: [
                                                  TextSpan(
                                                    text: '\$',
                                                    style: GoogleFonts.workSans(
                                                        color:
                                                            Color(0xffFEBE16),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16.sp),
                                                  ),
                                                  TextSpan(
                                                    text: forPlan2.toString(),
                                                    style: GoogleFonts.workSans(
                                                        color:
                                                            Color(0xffFEBE16),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16.sp),
                                                  ),
                                                ]),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: displayHeight(context) * .01,
                                        ),
                                        child: Center(
                                          child: RichText(
                                            textAlign: TextAlign.left,
                                            overflow: TextOverflow.clip,
                                            text: TextSpan(
                                                text: 'Groceries ',
                                                style: GoogleFonts.workSans(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16.sp),
                                                children: [
                                                  TextSpan(
                                                    text: '\$',
                                                    style: GoogleFonts.workSans(
                                                        color:
                                                            Color(0xffFEBE16),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16.sp),
                                                  ),
                                                  TextSpan(
                                                    text: forPlan3.toString(),
                                                    style: GoogleFonts.workSans(
                                                        color:
                                                            Color(0xffFEBE16),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16.sp),
                                                  ),
                                                ]),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: displayHeight(context) * .01,
                                        ),
                                        child: Center(
                                          child: RichText(
                                            textAlign: TextAlign.left,
                                            overflow: TextOverflow.clip,
                                            text: TextSpan(
                                                text: 'Cellphone ',
                                                style: GoogleFonts.workSans(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16.sp),
                                                children: [
                                                  TextSpan(
                                                    text: '\$',
                                                    style: GoogleFonts.workSans(
                                                        color:
                                                            Color(0xffFEBE16),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16.sp),
                                                  ),
                                                  TextSpan(
                                                    text: forPlan4.toString(),
                                                    style: GoogleFonts.workSans(
                                                        color:
                                                            Color(0xffFEBE16),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16.sp),
                                                  ),
                                                ]),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              top:
                                                  displayHeight(context) * .04),
                                          child: StatefulBuilder(
                                              builder: (context, setState) {
                                            return  Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    width:
                                                        displayWidth(context) *
                                                            .62,
                                                    height:
                                                        displayHeight(context) *
                                                            .07,
                                                    decoration: BoxDecoration(
                                                        color: color,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                displayWidth(
                                                                        context) *
                                                                    .12)),
                                                    child:color == Color(0xff00C673)
                                                        ? TextButton(
                                                        onPressed: () {
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 6.0),
                                                          child: Center(
                                                            child: FittedBox(
                                                              child: RichText(
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                overflow:
                                                                    TextOverflow
                                                                        .clip,
                                                                text: TextSpan(
                                                                    text:
                                                                        'Pay now ',
                                                                    style: GoogleFonts.workSans(
                                                                        color: color == Color(0xff00C673)
                                                                            ? Colors
                                                                                .white
                                                                            : Color(
                                                                                0xff4D5DDD),
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        fontSize:
                                                                            15.sp),
                                                                    children: [
                                                                      TextSpan(
                                                                        text:
                                                                            '\$',
                                                                        style: GoogleFonts.workSans(
                                                                            color: color == Color(0xff00C673)
                                                                                ? Colors.white
                                                                                : Color(0xffFEBE16),
                                                                            fontWeight: FontWeight.w500,
                                                                            fontSize: 15.sp),
                                                                      ),
                                                                      TextSpan(
                                                                        text: billPayment
                                                                            .toString(),
                                                                        style: GoogleFonts.workSans(
                                                                            color: color == Color(0xff00C673)
                                                                                ? Colors.white
                                                                                : Color(0xffFEBE16),
                                                                            fontWeight: FontWeight.w500,
                                                                            fontSize: 15.sp),
                                                                      ),
                                                                    ]),
                                                              ),
                                                            ),
                                                          ),
                                                        )) : TextButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            color = Color(
                                                                0xff00C673);
                                                          });
                                                          payArray.add(
                                                              currentIndex);
                                                          balance = balance -
                                                              billPayment;
                                                          if (balance < 0) {
                                                            Future.delayed(
                                                              Duration(
                                                                  milliseconds:
                                                                  500),
                                                                  () =>
                                                                  _showDialogForRestartLevel(
                                                                      context),
                                                            );
                                                          } else {
                                                            firestore
                                                                .collection(
                                                                'User')
                                                                .doc(userId)
                                                                .update({
                                                              'account_balance':
                                                              balance,
                                                              'game_score':
                                                              gameScore +
                                                                  balance +
                                                                  qualityOfLife,
                                                            });
                                                            Future.delayed(
                                                                Duration(
                                                                    seconds: 1),
                                                                    () => Navigator
                                                                    .pop(
                                                                    context));
                                                          }
                                                        },
                                                        child: Padding(
                                                          padding:
                                                          EdgeInsets.only(
                                                              left: 6.0),
                                                          child: Center(
                                                            child: FittedBox(
                                                              child: RichText(
                                                                textAlign:
                                                                TextAlign
                                                                    .left,
                                                                overflow:
                                                                TextOverflow
                                                                    .clip,
                                                                text: TextSpan(
                                                                    text:
                                                                    'Pay now ',
                                                                    style: GoogleFonts.workSans(
                                                                        color: color == Color(0xff00C673)
                                                                            ? Colors
                                                                            .white
                                                                            : Color(
                                                                            0xff4D5DDD),
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                        fontSize:
                                                                        15.sp),
                                                                    children: [
                                                                      TextSpan(
                                                                        text:
                                                                        '\$',
                                                                        style: GoogleFonts.workSans(
                                                                            color: color == Color(0xff00C673)
                                                                                ? Colors.white
                                                                                : Color(0xffFEBE16),
                                                                            fontWeight: FontWeight.w500,
                                                                            fontSize: 15.sp),
                                                                      ),
                                                                      TextSpan(
                                                                        text: billPayment
                                                                            .toString(),
                                                                        style: GoogleFonts.workSans(
                                                                            color: color == Color(0xff00C673)
                                                                                ? Colors.white
                                                                                : Color(0xffFEBE16),
                                                                            fontWeight: FontWeight.w500,
                                                                            fontSize: 15.sp),
                                                                      ),
                                                                    ]),
                                                              ),
                                                            ),
                                                          ),
                                                        )),
                                                  );
                                          })),
                                      SizedBox(
                                        height: displayHeight(context) * .02,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    previewChild: PreviewOfBottomDrawer(),
                    expandedChild: ExpandedBottomDrawer(),
                    minExtent: displayHeight(context) * .14,
                    maxExtent: displayHeight(context) * .55,
                  )),
            ),
          );
        });
  }

  _salaryCredited() {
    var forPortrait = displayHeight(context);
    var bottomHeightPotrait = displayHeight(context) * .14;
    forPortrait = forPortrait - bottomHeightPotrait;
    return showDialog(
        context: context, // <<----
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () {
              return Future.value(false);},
            child: Container(
              width: displayWidth(context),
              height: displayHeight(context),
              decoration: boxDecoration,
              child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: DraggableBottomSheet(
                    backgroundWidget: Container(
                      width: displayWidth(context),
                      height: forPortrait,
                      decoration: boxDecoration,
                      child: Column(
                        children: [
                          levelId == 0
                              ? GameScorePage(
                                  level: level,
                                  document: 'GameQuestion',
                                )
                              : GameScorePage(
                                  level: level,
                                  document: document,
                                ),
                          Flexible(
                            child: Container(
                              alignment: Alignment.center,
                              height: forPortrait * .86 - bottomHeightPotrait,
                              child: Container(
                                alignment: Alignment.center,
                                width: displayWidth(context) * .80,
                                height: forPortrait * .81 - bottomHeightPotrait,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      displayWidth(context) * .08,
                                    ),
                                    color: Color(0xff6A81F4)),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: displayHeight(context) * .03,
                                            left: displayWidth(context) * .03,
                                            right: displayWidth(context) * .03),
                                        child: Text(
                                          'Salary Credited',
                                          style: GoogleFonts.workSans(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: displayHeight(context) * .03,
                                            left: displayWidth(context) * .06,
                                            right: displayWidth(context) * .06),
                                        child: Text(
                                          'Monthly salary of \$1000 has been credited to your account.',
                                          style: GoogleFonts.workSans(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              top: displayHeight(context) * .04),
                                          child: StatefulBuilder(
                                              builder: (context, setState) {
                                            return  Container(
                                                    alignment: Alignment.centerLeft,
                                                    width:
                                                        displayWidth(context) * .62,
                                                    height: displayHeight(context) *
                                                        .07,
                                                    decoration: BoxDecoration(
                                                        color: color,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                displayWidth(
                                                                        context) *
                                                                    .12)),
                                                    child:  color == Color(0xff00C673)
                                                        ?TextButton(
                                                        onPressed: () {
                                                        },
                                                        child: Padding(
                                                          padding: EdgeInsets.only(
                                                              left: 6.0),
                                                          child: Center(
                                                            child: FittedBox(
                                                              child: RichText(
                                                                textAlign:
                                                                    TextAlign.left,
                                                                overflow:
                                                                    TextOverflow
                                                                        .clip,
                                                                text: TextSpan(
                                                                    text: 'Okay ',
                                                                    style: GoogleFonts.workSans(
                                                                        color: color ==
                                                                                Color(
                                                                                    0xff00C673)
                                                                            ? Colors
                                                                                .white
                                                                            : Color(
                                                                                0xff4D5DDD),
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        fontSize:
                                                                            15.sp),
                                                                    children: []),
                                                              ),
                                                            ),
                                                          ),
                                                        )) : TextButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            color =
                                                                Color(0xff00C673);
                                                          });
                                                          balance = balance + 1000;
                                                          firestore
                                                              .collection('User')
                                                              .doc(userId)
                                                              .update({
                                                            'account_balance':
                                                            balance,
                                                            'game_score':
                                                            gameScore +
                                                                balance +
                                                                qualityOfLife,
                                                          });
                                                          Future.delayed(
                                                              Duration(seconds: 1),
                                                                  () => Navigator.pop(
                                                                  context));
                                                        },
                                                        child: Padding(
                                                          padding: EdgeInsets.only(
                                                              left: 6.0),
                                                          child: Center(
                                                            child: FittedBox(
                                                              child: RichText(
                                                                textAlign:
                                                                TextAlign.left,
                                                                overflow:
                                                                TextOverflow
                                                                    .clip,
                                                                text: TextSpan(
                                                                    text: 'Okay ',
                                                                    style: GoogleFonts.workSans(
                                                                        color: color ==
                                                                            Color(
                                                                                0xff00C673)
                                                                            ? Colors
                                                                            .white
                                                                            : Color(
                                                                            0xff4D5DDD),
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                        fontSize:
                                                                        15.sp),
                                                                    children: []),
                                                              ),
                                                            ),
                                                          ),
                                                        )),
                                                  );
                                          })),
                                      SizedBox(
                                        height: displayHeight(context) * .02,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    previewChild: PreviewOfBottomDrawer(),
                    expandedChild: ExpandedBottomDrawer(),
                    minExtent: displayHeight(context) * .14,
                    maxExtent: displayHeight(context) * .55,
                  )),
            ),
          );
        });
  }

  _creditCardBillPayment() async {
    var forPortrait = displayHeight(context);
    var bottomHeightPotrait = displayHeight(context) * .14;
    forPortrait = forPortrait - bottomHeightPotrait;

    DocumentSnapshot snap =
        await firestore.collection('User').doc(userId).get();
    balance = snap.get('account_balance');
    payableBill = snap.get('payable_bill');
    creditBill = snap.get('credit_card_bill');

    return showDialog(
        context: context, // <<----
        barrierDismissible: false,
        builder: (BuildContext context) {
          int intrest = (payableBill * 5 ~/ 100).toInt().ceil();
          print('intred $intrest');
          int totalAmount = creditBill + payableBill + intrest;
          print('total $totalAmount');

          return WillPopScope(
            onWillPop: () {
              return Future.value(false);},
            child: Container(
              width: displayWidth(context),
              height: displayHeight(context),
              decoration: boxDecoration,
              child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: DraggableBottomSheet(
                    backgroundWidget: Container(
                      width: displayWidth(context),
                      height: forPortrait,
                      decoration: boxDecoration,
                      child: Column(
                        children: [
                          GameScorePage(
                            level: level,
                            document: document,
                          ),
                          Flexible(
                            child: Container(
                              alignment: Alignment.center,
                              height: forPortrait * .86 - bottomHeightPotrait,
                              child: Container(
                                alignment: Alignment.center,
                                width: displayWidth(context) * .80,
                                height: forPortrait * .81 - bottomHeightPotrait,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      displayWidth(context) * .08,
                                    ),
                                    color: Color(0xff6A81F4)),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: displayHeight(context) * .01,
                                            left: displayWidth(context) * .03,
                                            right: displayWidth(context) * .03),
                                        child: Text(
                                          'Credit Card',
                                          style: GoogleFonts.workSans(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: displayHeight(context) * .03,
                                            left: displayWidth(context) * .06,
                                            right: displayWidth(context) * .06),
                                        child: Text(
                                          'Your Credit Card bill has been generated.',
                                          style: GoogleFonts.workSans(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: displayHeight(context) * .02,
                                            left: displayWidth(context) * .02,
                                            right: displayWidth(context) * .02),
                                        child: Center(
                                          child: FittedBox(
                                            child: RichText(
                                              textAlign: TextAlign.left,
                                              overflow: TextOverflow.clip,
                                              text: TextSpan(
                                                  text: 'Current bill : ',
                                                  style: GoogleFonts.workSans(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 15.sp),
                                                  children: [
                                                    TextSpan(
                                                      text: '\$',
                                                      style: GoogleFonts.workSans(
                                                          color: Color(0xffFEBE16),
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 15.sp),
                                                    ),
                                                    TextSpan(
                                                      text: creditBill.toString(),
                                                      style: GoogleFonts.workSans(
                                                          color: Color(0xffFEBE16),
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 15.sp),
                                                    ),
                                                  ]),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: displayHeight(context) * .01,
                                            left: displayWidth(context) * .02,
                                            right: displayWidth(context) * .02),
                                        child: Center(
                                          child: FittedBox(
                                            child: RichText(
                                              textAlign: TextAlign.left,
                                              overflow: TextOverflow.clip,
                                              text: TextSpan(
                                                  text: 'Past Dues : ',
                                                  style: GoogleFonts.workSans(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 15.sp),
                                                  children: [
                                                    TextSpan(
                                                      text: '\$',
                                                      style: GoogleFonts.workSans(
                                                          color: Color(0xffFEBE16),
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 15.sp),
                                                    ),
                                                    TextSpan(
                                                      text: payableBill
                                                          .ceil()
                                                          .toString(),
                                                      style: GoogleFonts.workSans(
                                                          color: Color(0xffFEBE16),
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 15.sp),
                                                    ),
                                                  ]),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: displayHeight(context) * .01,
                                            left: displayWidth(context) * .02,
                                            right: displayWidth(context) * .02),
                                        child: Center(
                                          child: FittedBox(
                                            child: RichText(
                                              textAlign: TextAlign.left,
                                              overflow: TextOverflow.clip,
                                              text: TextSpan(
                                                  text: 'Interest on past dues : ',
                                                  style: GoogleFonts.workSans(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 15.sp),
                                                  children: [
                                                    TextSpan(
                                                      text: '\$',
                                                      style: GoogleFonts.workSans(
                                                          color: Color(0xffFEBE16),
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 15.sp),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          intrest.ceil().toString(),
                                                      style: GoogleFonts.workSans(
                                                          color: Color(0xffFEBE16),
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 15.sp),
                                                    ),
                                                  ]),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              top: displayHeight(context) * .04),
                                          child: StatefulBuilder(
                                              builder: (context, setState) {
                                            return  Container(
                                                    alignment: Alignment.centerLeft,
                                                    width:
                                                        displayWidth(context) * .62,
                                                    height: displayHeight(context) *
                                                        .07,
                                                    decoration: BoxDecoration(
                                                        color: color,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                displayWidth(
                                                                        context) *
                                                                    .12)),
                                                    child:color == Color(0xff00C673)
                                                        ? TextButton(
                                                        onPressed: ()  {
                                                        },
                                                        child: Padding(
                                                          padding: EdgeInsets.only(
                                                              left: 6.0),
                                                          child: Center(
                                                            child: FittedBox(
                                                              child: RichText(
                                                                textAlign:
                                                                    TextAlign.left,
                                                                overflow:
                                                                    TextOverflow
                                                                        .clip,
                                                                text: TextSpan(
                                                                    text:
                                                                        'Pay full ',
                                                                    style: GoogleFonts.workSans(
                                                                        color: color ==
                                                                                Color(
                                                                                    0xff00C673)
                                                                            ? Colors
                                                                                .white
                                                                            : Color(
                                                                                0xff4D5DDD),
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        fontSize:
                                                                            15.sp),
                                                                    children: [
                                                                      TextSpan(
                                                                        text: '\$',
                                                                        style: GoogleFonts.workSans(
                                                                            color: color == Color(0xff00C673)
                                                                                ? Colors
                                                                                    .white
                                                                                : Color(
                                                                                    0xffFEBE16),
                                                                            fontWeight:
                                                                                FontWeight
                                                                                    .w500,
                                                                            fontSize:
                                                                                15.sp),
                                                                      ),
                                                                      TextSpan(
                                                                        text: totalAmount
                                                                            .toString(),
                                                                        style: GoogleFonts.workSans(
                                                                            color: color == Color(0xff00C673)
                                                                                ? Colors
                                                                                    .white
                                                                                : Color(
                                                                                    0xffFEBE16),
                                                                            fontWeight:
                                                                                FontWeight
                                                                                    .w500,
                                                                            fontSize:
                                                                                15.sp),
                                                                      ),
                                                                    ]),
                                                              ),
                                                            ),
                                                          ),
                                                        )) : TextButton(
                                                        onPressed: () async {
                                                          setState(() {
                                                            color =
                                                                Color(0xff00C673);
                                                          });
                                                          if (totalAmount.ceil() != 0 && balance >=
                                                              totalAmount.ceil()) {
                                                            balance = balance -
                                                                totalAmount.ceil();
                                                            score =
                                                                snap.get('score');
                                                            firestore
                                                                .collection('User')
                                                                .doc(userId)
                                                                .update({
                                                              'account_balance':
                                                              balance,
                                                              'credit_card_bill': 0,
                                                              'payable_bill': 0,
                                                              'game_score':
                                                              gameScore +
                                                                  balance +
                                                                  qualityOfLife,
                                                              'score': FieldValue
                                                                  .increment(40),
                                                              'credit_score':
                                                              (score + 200 + 40)
                                                            });
                                                            Future.delayed(
                                                                Duration(
                                                                    seconds: 1),
                                                                    () => Navigator.pop(
                                                                    context));
                                                          } else {
                                                            if(totalAmount.ceil() == 0){
                                                              Future.delayed(
                                                                  Duration(
                                                                      seconds: 1),
                                                                      () => Navigator.pop(
                                                                      context));
                                                            }else{
                                                              _showDialogForRestartLevel(
                                                                  context);
                                                            }
                                                          }
                                                          // }
                                                        },
                                                        child: Padding(
                                                          padding: EdgeInsets.only(
                                                              left: 6.0),
                                                          child: Center(
                                                            child: FittedBox(
                                                              child: RichText(
                                                                textAlign:
                                                                TextAlign.left,
                                                                overflow:
                                                                TextOverflow
                                                                    .clip,
                                                                text: TextSpan(
                                                                    text:
                                                                    'Pay full ',
                                                                    style: GoogleFonts.workSans(
                                                                        color: color ==
                                                                            Color(
                                                                                0xff00C673)
                                                                            ? Colors
                                                                            .white
                                                                            : Color(
                                                                            0xff4D5DDD),
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                        fontSize:
                                                                        15.sp),
                                                                    children: [
                                                                      TextSpan(
                                                                        text: '\$',
                                                                        style: GoogleFonts.workSans(
                                                                            color: color == Color(0xff00C673)
                                                                                ? Colors
                                                                                .white
                                                                                : Color(
                                                                                0xffFEBE16),
                                                                            fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                            fontSize:
                                                                            15.sp),
                                                                      ),
                                                                      TextSpan(
                                                                        text: totalAmount
                                                                            .toString(),
                                                                        style: GoogleFonts.workSans(
                                                                            color: color == Color(0xff00C673)
                                                                                ? Colors
                                                                                .white
                                                                                : Color(
                                                                                0xffFEBE16),
                                                                            fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                            fontSize:
                                                                            15.sp),
                                                                      ),
                                                                    ]),
                                                              ),
                                                            ),
                                                          ),
                                                        )),
                                                  );
                                          })),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              top: displayHeight(context) * .02),
                                          child: StatefulBuilder(
                                              builder: (context, setState) {
                                            return Container(
                                                    alignment: Alignment.centerLeft,
                                                    width:
                                                        displayWidth(context) * .62,
                                                    height: displayHeight(context) *
                                                        .07,
                                                    decoration: BoxDecoration(
                                                        color: color,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                displayWidth(
                                                                        context) *
                                                                    .12)),
                                                    child: color == Color(0xff00C673)
                                                        ? TextButton(
                                                        onPressed: ()  {

                                                        },
                                                        child: Padding(
                                                          padding: EdgeInsets.only(
                                                              left: 6.0),
                                                          child: Center(
                                                            child: FittedBox(
                                                              child: RichText(
                                                                textAlign:
                                                                    TextAlign.left,
                                                                overflow:
                                                                    TextOverflow
                                                                        .clip,
                                                                text: TextSpan(
                                                                    text:
                                                                        'Pay minimum ',
                                                                    style: GoogleFonts.workSans(
                                                                        color: color ==
                                                                                Color(
                                                                                    0xff00C673)
                                                                            ? Colors
                                                                                .white
                                                                            : Color(
                                                                                0xff4D5DDD),
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        fontSize:
                                                                            15.sp),
                                                                    children: [
                                                                      TextSpan(
                                                                        text: '\$',
                                                                        style: GoogleFonts.workSans(
                                                                            color: color == Color(0xff00C673)
                                                                                ? Colors
                                                                                    .white
                                                                                : Color(
                                                                                    0xffFEBE16),
                                                                            fontWeight:
                                                                                FontWeight
                                                                                    .w500,
                                                                            fontSize:
                                                                                15.sp),
                                                                      ),
                                                                      TextSpan(
                                                                        text: (totalAmount *
                                                                                10 ~/
                                                                                100)
                                                                            .toInt()
                                                                            .ceil()
                                                                            .toString(),
                                                                        style: GoogleFonts.workSans(
                                                                            color: color == Color(0xff00C673)
                                                                                ? Colors
                                                                                    .white
                                                                                : Color(
                                                                                    0xffFEBE16),
                                                                            fontWeight:
                                                                                FontWeight
                                                                                    .w500,
                                                                            fontSize:
                                                                                15.sp),
                                                                      ),
                                                                    ]),
                                                              ),
                                                            ),
                                                          ),
                                                        )) : TextButton(
                                                        onPressed: () async {
                                                          setState(() {
                                                            color =
                                                                Color(0xff00C673);
                                                          });
                                                          int pay = (totalAmount *
                                                              10 ~/
                                                              100)
                                                              .toInt()
                                                              .ceil();
                                                          score = snap.get('score');
                                                          int bal =
                                                              totalAmount - pay;
                                                          double value = 100 -
                                                              ((bal / 2000) * 100);
                                                          value = value * 2;
                                                          if (totalAmount.ceil() != 0 && balance >= pay) {
                                                            balance = balance - pay;
                                                            firestore
                                                                .collection('User')
                                                                .doc(userId)
                                                                .update({
                                                              'account_balance':
                                                              balance,
                                                              'payable_bill': bal,
                                                              'credit_card_bill': 0,
                                                              'game_score':
                                                              gameScore +
                                                                  balance +
                                                                  qualityOfLife,
                                                              'score': FieldValue
                                                                  .increment(40),
                                                              'credit_score':
                                                              (score +
                                                                  value.ceil() +
                                                                  40)
                                                            });
                                                            Future.delayed(
                                                                Duration(
                                                                    seconds: 1),
                                                                    () => Navigator.pop(
                                                                    context));
                                                          } else {
                                                            if(totalAmount.ceil() == 0){
                                                              Future.delayed(
                                                                  Duration(
                                                                      seconds: 1),
                                                                      () => Navigator.pop(
                                                                      context));
                                                            }else{
                                                              _showDialogForRestartLevel(
                                                                  context);
                                                            }
                                                          }
                                                        },
                                                        child: Padding(
                                                          padding: EdgeInsets.only(
                                                              left: 6.0),
                                                          child: Center(
                                                            child: FittedBox(
                                                              child: RichText(
                                                                textAlign:
                                                                TextAlign.left,
                                                                overflow:
                                                                TextOverflow
                                                                    .clip,
                                                                text: TextSpan(
                                                                    text:
                                                                    'Pay minimum ',
                                                                    style: GoogleFonts.workSans(
                                                                        color: color ==
                                                                            Color(
                                                                                0xff00C673)
                                                                            ? Colors
                                                                            .white
                                                                            : Color(
                                                                            0xff4D5DDD),
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                        fontSize:
                                                                        15.sp),
                                                                    children: [
                                                                      TextSpan(
                                                                        text: '\$',
                                                                        style: GoogleFonts.workSans(
                                                                            color: color == Color(0xff00C673)
                                                                                ? Colors
                                                                                .white
                                                                                : Color(
                                                                                0xffFEBE16),
                                                                            fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                            fontSize:
                                                                            15.sp),
                                                                      ),
                                                                      TextSpan(
                                                                        text: (totalAmount *
                                                                            10 ~/
                                                                            100)
                                                                            .toInt()
                                                                            .ceil()
                                                                            .toString(),
                                                                        style: GoogleFonts.workSans(
                                                                            color: color == Color(0xff00C673)
                                                                                ? Colors
                                                                                .white
                                                                                : Color(
                                                                                0xffFEBE16),
                                                                            fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                            fontSize:
                                                                            15.sp),
                                                                      ),
                                                                    ]),
                                                              ),
                                                            ),
                                                          ),
                                                        )),
                                                  );
                                          })),
                                      SizedBox(
                                        height: displayHeight(context) * .02,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    previewChild: PreviewOfBottomDrawer(),
                    expandedChild: ExpandedBottomDrawer(),
                    minExtent: displayHeight(context) * .14,
                    maxExtent: displayHeight(context) * .55,
                  )),
            ),
          );
        });
  }

  _levelCompleteSummary(BuildContext context, int gameScore, int balance,
      int qualityOfLife) async {
    var forPortrait = displayHeight(context);
    var bottomHeightPotrait = displayHeight(context) * .14;
    forPortrait = forPortrait - bottomHeightPotrait;

    DocumentSnapshot documentSnapshot =
        await firestore.collection('User').doc(userId).get();
    int need = documentSnapshot['need'];
    int want = documentSnapshot['want'];
    int bill = documentSnapshot['bill_payment'];

    Color color = Colors.white;
    return showDialog(
        context: context, // <<----
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () {
              return Future.value(false);},
            child: Container(
              width: displayWidth(context),
              height: displayHeight(context),
              decoration: boxDecoration,
              child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: DraggableBottomSheet(
                    backgroundWidget: Container(
                      width: displayWidth(context),
                      height: forPortrait,
                      decoration: boxDecoration,
                      child: Column(
                        children: [
                          GameScorePage(
                            level: level,
                            document: document,
                          ),
                          SizedBox(
                            height: forPortrait * .04,
                          ),
                          Flexible(
                            child: Container(
                              alignment: Alignment.center,
                              height: forPortrait * .86 - bottomHeightPotrait,
                              child: Container(
                                alignment: Alignment.center,
                                width: displayWidth(context) * .80,
                                height: forPortrait * .81 - bottomHeightPotrait,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      displayWidth(context) * .08,
                                    ),
                                    color: Color(0xff6A81F4)),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: displayHeight(context) * .02,
                                            left: displayWidth(context) * .04,
                                            right: displayWidth(context) * .04),
                                        child: Text(
                                          'Congratulations! You have completed this level successfully ',
                                          style: GoogleFonts.workSans(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: displayHeight(context) * .02,
                                        ),
                                        child: Center(
                                          child: RichText(
                                            textAlign: TextAlign.left,
                                            overflow: TextOverflow.clip,
                                            text: TextSpan(
                                                text: 'Salary Earned : ',
                                                style: GoogleFonts.workSans(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16.sp),
                                                children: [
                                                  TextSpan(
                                                    text: '\$',
                                                    style: GoogleFonts.workSans(
                                                        color:
                                                            Color(0xffFEBE16),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16.sp),
                                                  ),
                                                  TextSpan(
                                                    text: 7000.toString(),
                                                    style: GoogleFonts.workSans(
                                                        color:
                                                            Color(0xffFEBE16),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16.sp),
                                                  ),
                                                ]),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: displayHeight(context) * .01,
                                        ),
                                        child: Center(
                                          child: RichText(
                                            textAlign: TextAlign.left,
                                            overflow: TextOverflow.clip,
                                            text: TextSpan(
                                                text: 'Bill Payment : ',
                                                style: GoogleFonts.workSans(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16.sp),
                                                children: [
                                                  TextSpan(
                                                    text: '\$',
                                                    style: GoogleFonts.workSans(
                                                        color:
                                                            Color(0xffFEBE16),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16.sp),
                                                  ),
                                                  TextSpan(
                                                    text: bill.toString(),
                                                    style: GoogleFonts.workSans(
                                                        color:
                                                            Color(0xffFEBE16),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16.sp),
                                                  ),
                                                ]),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: displayHeight(context) * .01,
                                        ),
                                        child: Center(
                                          child: RichText(
                                            textAlign: TextAlign.left,
                                            overflow: TextOverflow.clip,
                                            text: TextSpan(
                                                text: 'Need : ',
                                                style: GoogleFonts.workSans(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16.sp),
                                                children: [
                                                  TextSpan(
                                                    text: '\$',
                                                    style: GoogleFonts.workSans(
                                                        color:
                                                            Color(0xffFEBE16),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16.sp),
                                                  ),
                                                  TextSpan(
                                                    text: need.toString(),
                                                    style: GoogleFonts.workSans(
                                                        color:
                                                            Color(0xffFEBE16),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16.sp),
                                                  ),
                                                ]),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: displayHeight(context) * .01,
                                        ),
                                        child: Center(
                                          child: RichText(
                                            textAlign: TextAlign.left,
                                            overflow: TextOverflow.clip,
                                            text: TextSpan(
                                                text: 'Want : ',
                                                style: GoogleFonts.workSans(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16.sp),
                                                children: [
                                                  TextSpan(
                                                    text: '\$',
                                                    style: GoogleFonts.workSans(
                                                        color:
                                                            Color(0xffFEBE16),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16.sp),
                                                  ),
                                                  TextSpan(
                                                    text: want.toString(),
                                                    style: GoogleFonts.workSans(
                                                        color:
                                                            Color(0xffFEBE16),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16.sp),
                                                  ),
                                                ]),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: displayHeight(context) * .01,
                                        ),
                                        child: Center(
                                          child: RichText(
                                            textAlign: TextAlign.left,
                                            overflow: TextOverflow.clip,
                                            text: TextSpan(
                                                text: 'Total Saving : ',
                                                style: GoogleFonts.workSans(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16.sp),
                                                children: [
                                                  TextSpan(
                                                    text: '\$',
                                                    style: GoogleFonts.workSans(
                                                        color:
                                                        Color(0xffFEBE16),
                                                        fontWeight:
                                                        FontWeight.w500,
                                                        fontSize: 16.sp),
                                                  ),
                                                  TextSpan(
                                                    text: (need +
                                                        want +
                                                        bill +
                                                        7000)
                                                        .toString(),
                                                    style: GoogleFonts.workSans(
                                                        color:
                                                        Color(0xffFEBE16),
                                                        fontWeight:
                                                        FontWeight.w500,
                                                        fontSize: 16.sp),
                                                  ),
                                                ]),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              top:
                                                  displayHeight(context) * .04),
                                          child: StatefulBuilder(
                                              builder: (context, setState) {
                                            return  Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    width:
                                                        displayWidth(context) *
                                                            .62,
                                                    height:
                                                        displayHeight(context) *
                                                            .07,
                                                    decoration: BoxDecoration(
                                                        color: color,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                displayWidth(
                                                                        context) *
                                                                    .12)),
                                                    child:color == Color(0xff00C673)
                                                        ? TextButton(
                                                        onPressed: ()  {

                                                        },
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 6.0),
                                                          child: Center(
                                                            child: FittedBox(
                                                              child: RichText(
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                overflow:
                                                                    TextOverflow
                                                                        .clip,
                                                                text: TextSpan(
                                                                    text:
                                                                        'Play Next Level',
                                                                    style: GoogleFonts.workSans(
                                                                        color: color == Color(0xff00C673)
                                                                            ? Colors
                                                                                .white
                                                                            : Color(
                                                                                0xff4D5DDD),
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        fontSize:
                                                                            15.sp),
                                                                   ),
                                                              ),
                                                            ),
                                                          ),
                                                        )) : TextButton(
                                                        onPressed: () async {
                                                          setState(() {
                                                            color = Color(
                                                                0xff00C673);
                                                          });
                                                          int _creditScore =
                                                          documentSnapshot.get(
                                                              'credit_score');
                                                          if (_creditScore <
                                                              750) {
                                                            Future.delayed(  Duration(
                                                                seconds: 1),
                                                                    () => showDialog(
                                                                    barrierDismissible:
                                                                    false,
                                                                    context:
                                                                    context,
                                                                    builder:
                                                                        (context) {
                                                                      return WillPopScope(
                                                                        onWillPop: () {
                                                                          return Future.value(false);
                                                                        },
                                                                        child: AlertDialog(
                                                                          elevation:
                                                                          3.0,
                                                                          shape: RoundedRectangleBorder(
                                                                              borderRadius:
                                                                              BorderRadius.circular(displayWidth(context) * .04)),
                                                                          actionsPadding:
                                                                          EdgeInsets.all(
                                                                              8.0),
                                                                          backgroundColor:
                                                                          Color(
                                                                              0xff6646E6),
                                                                          content:
                                                                          Text(
                                                                            "Oops! You haven\’t managed to achieve a good credit score.\n Poor credit scores make it difficult to get loans for housing, car etc. Some landlords may also refuse to rent you a house because of a low credit score. \n But don\’t worry. You can practise in the game so you don\’t make such mistakes in real life! ",
                                                                            style: GoogleFonts.workSans(
                                                                                color:
                                                                                Colors.white,
                                                                                fontWeight: FontWeight.w600),
                                                                            textAlign:
                                                                            TextAlign.center,
                                                                          ),
                                                                          actions: [
                                                                            ElevatedButton(
                                                                                onPressed:
                                                                                    () {
                                                                                  firestore.collection('User').doc(userId).update({
                                                                                    'previous_session_info' : 'Level_3_setUp_page',
                                                                                    'level_id':0,
                                                                                  });
                                                                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LevelThreeSetUpPage(controller: PageController())));
                                                                                },
                                                                                style:
                                                                                ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
                                                                                child: Text(
                                                                                  'Play again',
                                                                                  style: GoogleFonts.workSans(
                                                                                    color: Color(0xff6646E6),
                                                                                  ),
                                                                                )),
                                                                          ],
                                                                        ),
                                                                      );
                                                                    }));
                                                          }else{
                                                            Future.delayed(
                                                                Duration(
                                                                    seconds: 2),
                                                                    () =>
                                                                    showDialog(
                                                                        barrierDismissible:
                                                                        false,
                                                                        context:
                                                                        context,
                                                                        builder:
                                                                            (context) {
                                                                          return WillPopScope(
                                                                            onWillPop: () {
                                                                              return Future.value(false);},
                                                                            child: AlertDialog(
                                                                              elevation:
                                                                              3.0,
                                                                              shape:
                                                                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(displayWidth(context) * .04)),
                                                                              actionsPadding:
                                                                              EdgeInsets.all(8.0),
                                                                              backgroundColor:
                                                                              Color(0xff6646E6),
                                                                              content:
                                                                              Text(
                                                                                'Woohoo! Invites unlocked!  \n\n Invite your friends to play the game and challenge them to beat your score!',
                                                                                style: GoogleFonts.workSans(color: Colors.white, fontWeight: FontWeight.w600),
                                                                                textAlign: TextAlign.center,
                                                                              ),
                                                                              actions: [
                                                                                Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                  children: [
                                                                                    ElevatedButton(
                                                                                        onPressed: () async {
                                                                                          bool value = documentSnapshot.get('replay_level');
                                                                                          level = documentSnapshot.get('last_level');
                                                                                          int myBal = documentSnapshot.get('account_balance');
                                                                                          print('My bal $myBal');
                                                                                          level = level.toString().substring(6, 7);
                                                                                          int lev = int.parse(level);

                                                                                          if (value == true) {
                                                                                            Future.delayed(
                                                                                                Duration(
                                                                                                    seconds: 1),
                                                                                                    () =>
                                                                                                    showDialog(
                                                                                                        context:
                                                                                                        context,
                                                                                                        builder:
                                                                                                            (context) {
                                                                                                          return WillPopScope(
                                                                                                            onWillPop: () {
                                                                                                              return Future.value(false);},
                                                                                                            child: AlertDialog(
                                                                                                              elevation:
                                                                                                              3.0,
                                                                                                              shape:
                                                                                                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(displayWidth(context) * .04)),
                                                                                                              titlePadding:
                                                                                                              EdgeInsets.zero,
                                                                                                              title:
                                                                                                              Container(
                                                                                                                width: displayWidth(context),
                                                                                                                child: Padding(
                                                                                                                  padding: EdgeInsets.all(8.0),
                                                                                                                  child: Text(
                                                                                                                    'Congratulations! You have completed this level successfully',
                                                                                                                    textAlign: TextAlign.center,
                                                                                                                    style: GoogleFonts.workSans(fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.w500),
                                                                                                                  ),
                                                                                                                ),
                                                                                                                decoration: BoxDecoration(
                                                                                                                    borderRadius: BorderRadius.only(
                                                                                                                      topRight: Radius.circular(displayWidth(context) * .04),
                                                                                                                      topLeft: Radius.circular(displayWidth(context) * .04),
                                                                                                                    ),
                                                                                                                    color: Color(0xffE9E5FF)),
                                                                                                              ),
                                                                                                              content:
                                                                                                              Column(
                                                                                                                mainAxisSize: MainAxisSize.min,
                                                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                                                                children: [
                                                                                                                  if (lev > 1)
                                                                                                                    Text(
                                                                                                                      'Which level you want play ?',
                                                                                                                      style: GoogleFonts.workSans(fontSize: 12.sp, color: Colors.black, fontWeight: FontWeight.w400),
                                                                                                                    ),
                                                                                                                  if (lev > 1) _level1(lev),
                                                                                                                  if (lev > 2) _level2(lev),
                                                                                                                  if (lev > 3) _level3(lev),
                                                                                                                  if (lev > 4) _level4(lev),
                                                                                                                  if (lev > 5) _level5(lev),
                                                                                                                  Padding(
                                                                                                                    padding: EdgeInsets.only(top: displayHeight(context) * .03),
                                                                                                                    child: Text(
                                                                                                                      'Want to play current level ?',
                                                                                                                      style: GoogleFonts.workSans(fontSize: 12.sp, color: Colors.black, fontWeight: FontWeight.w400),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                  if (lev == 1) _level1(lev),
                                                                                                                  if (lev == 2) _level2(lev),
                                                                                                                  if (lev == 3) _level3(lev),
                                                                                                                  if (lev == 4) _level4(lev),
                                                                                                                  if (lev == 5) _level5(lev),
                                                                                                                ],
                                                                                                              ),
                                                                                                            ),
                                                                                                          );
                                                                                                        }));
                                                                                          }  else {
                                                                                            FlutterShare.share(title: 'https://finshark.page.link/finshark', text: 'Finshark App', linkUrl: 'https://finshark.page.link/finshark', chooserTitle: 'https://finshark.page.link/finshark').then((value) {
                                                                                              // Future.delayed(Duration(seconds: 2), () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LevelThreeSetUpPage(controller: PageController()))));
                                                                                            }).then((value) {
                                                                                              Navigator.pop(context);
                                                                                              Future.delayed(Duration(seconds: 1), () =>  _playLevelOrPopQuiz());
                                                                                            });
                                                                                          }
                                                                                        },
                                                                                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
                                                                                        child: Text(
                                                                                          'Click here to invite ',
                                                                                          style: GoogleFonts.workSans(
                                                                                            color: Color(0xff6646E6),
                                                                                          ),
                                                                                        )),
                                                                              GestureDetector(child: Text('Skip',style: GoogleFonts.workSans(color: Colors.white, fontWeight: FontWeight.w600, decoration: TextDecoration.underline,),),onTap: (){
                                                                                      Navigator.pop(context);
                                                                                      Future.delayed(Duration(seconds: 1), () =>  _playLevelOrPopQuiz());
                                                                                    },),
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          );
                                                                        }));
                                                          }


                                                        },
                                                        child: Padding(
                                                          padding:
                                                          EdgeInsets.only(
                                                              left: 6.0),
                                                          child: Center(
                                                            child: FittedBox(
                                                              child: RichText(
                                                                textAlign:
                                                                TextAlign
                                                                    .left,
                                                                overflow:
                                                                TextOverflow
                                                                    .clip,
                                                                text: TextSpan(
                                                                  text:
                                                                  'Play Next Level',
                                                                  style: GoogleFonts.workSans(
                                                                      color: color == Color(0xff00C673)
                                                                          ? Colors
                                                                          .white
                                                                          : Color(
                                                                          0xff4D5DDD),
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                      fontSize:
                                                                      15.sp),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        )),
                                                  );
                                          })),
                                      SizedBox(
                                        height: displayHeight(context) * .02,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    previewChild: PreviewOfBottomDrawer(),
                    expandedChild: ExpandedBottomDrawer(),
                    minExtent: displayHeight(context) * .14,
                    maxExtent: displayHeight(context) * .55,
                  )),
            ),
          );
        });
  }

  _playLevelOrPopQuiz() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return WillPopScope(
            onWillPop: () {
              return Future.value(false);},
            child: AlertDialog(
              elevation: 3.0,
              shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(displayWidth(context) * .04)),
              titlePadding: EdgeInsets.zero,
              title: Container(
                width: displayWidth(context),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Congrats! You’ve managed to achieve your savings goal! Mission accomplished!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.workSans(
                        fontSize: 14.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(displayWidth(context) * .04),
                      topLeft: Radius.circular(displayWidth(context) * .04),
                    ),
                    color: Color(0xffE9E5FF)),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Future.delayed(Duration(seconds: 2), () {
                          firestore.collection("User").doc(userId).update({
                            'bill_payment': 0,
                            'credit_card_bill': 0,
                            'previous_session_info': 'Level_3_Pop_Quiz',
                            'last_level': 'Level_3_Pop_Quiz',
                            'game_score': gameScore,
                            'credit_card_balance': 0,
                            'account_balance': 0,
                            'level_id': 0,
                            'credit_score': 0,
                            'payable_bill': 0,
                            'score': 0,
                            'need': 0,
                            'want': 0,
                          });
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => PopQuiz()));
                        });
                      },
                      child: Text('Play Pop Quiz')),
                  ElevatedButton(
                      onPressed: () {
                        // Future.delayed(Duration(seconds: 2), () {
                        //   FirebaseFirestore.instance
                        //       .collection('User')
                        //       .doc(userId)
                        //       .update({
                        //     'previous_session_info': 'Level_3_setUp_page',
                        //     'bill_payment': 0,
                        //     'game_score': gameScore + balance + qualityOfLife,
                        //     'level_id': 0,
                        //     'credit_card_balance': 0,
                        //     'credit_card_bill': 0,
                        //     'credit_score': 0,
                        //     'payable_bill': 0,
                        //     'last_level': 'Level_3_setUp_page',
                        //     'replay_level': false,
                        //     'score': 0,
                        //     'need': 0,
                        //     'want': 0,
                        //   });
                        //   Navigator.pushReplacement(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) => LevelThreeSetUpPage(
                        //               controller: PageController())));
                        // });
                      },
                      child: Text('Play Next Level'))
                ],
              ),
            ),
          );
        });
  }

  _optionSelect(
      int index,
      int qualityOfLife,
      int balance,
      int qol2,
      int creditBal,
      int creditScore,
      int creditCount,
      int payableBill,
      AsyncSnapshot<QuerySnapshot<Object?>> snapshot,
      document,
      int score,
      int priceOfOption,
      String option,
      StateSetter setState1,
      category) async {
    DocumentSnapshot doc = await firestore.collection('User').doc(userId).get();
    creditBal = doc['credit_card_balance'];
    if (index == snapshot.data!.docs.length - 1) {
      Future.delayed(
          Duration(seconds: 1),
          () => _levelCompleteSummary(
              context, gameScore, balance, qualityOfLife));
    }

    if (balance >= 0 && creditBal >= 0) {
      if (option.toString().trim().length >= 11 &&
          option.toString().substring(0, 11) == 'Credit Card') {
        double c = 2000 * 80 / 100;
        c = 2000 - c;
        if (creditBal <= c) {
          return showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return WillPopScope(
                  onWillPop: () {
                    return Future.value(false);},
                  child: AlertDialog(
                    elevation: 3.0,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(displayWidth(context) * .04)),
                    actionsPadding: EdgeInsets.all(8.0),
                    backgroundColor: Color(0xff6646E6),
                    content: Text(
                      'You have used 80% of your Credit Limit. Higher Credit utilisation negatively affects your Credit Score.',
                      style: GoogleFonts.workSans(
                          color: Colors.white, fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            if (creditBal >= priceOfOption) {
                              firestore.collection('User').doc(userId).update({
                                'score': FieldValue.increment(-50),
                                'credit_score': FieldValue.increment(-50),
                                'credit_card_balance':
                                    FieldValue.increment(-priceOfOption),
                                'credit_card_bill':
                                    FieldValue.increment(priceOfOption),
                              });
                              Navigator.pop(context);
                              controller.nextPage(
                                  duration: Duration(seconds: 1),
                                  curve: Curves.easeIn);
                            } else {
                              int price = priceOfOption;
                              _showDialogCreditBalNotEnough(
                                  context,
                                  balance,
                                  price,
                                  controller,
                                  gameScore,
                                  qualityOfLife,
                                  qol2,
                                  scroll,
                                  index);
                            }
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white)),
                          child: Text(
                            'Ok',
                            style: GoogleFonts.workSans(
                              color: Color(0xff6646E6),
                            ),
                          )),
                    ],
                  ),
                );
              });
        }
        if (creditBal >= priceOfOption) {
          firestore.collection('User').doc(userId).update({
            'credit_card_bill': FieldValue.increment(priceOfOption),
            'quality_of_life': FieldValue.increment(qol2),
            'game_score': gameScore + balance + qualityOfLife,
            'credit_card_balance': FieldValue.increment(-priceOfOption),
            'level_id': index + 1,
            'need': category == 'Need'
                ? FieldValue.increment(priceOfOption)
                : FieldValue.increment(0),
            'want': category == 'Want'
                ? FieldValue.increment(priceOfOption)
                : FieldValue.increment(0),
          }).then((value) {
            FirebaseFirestore.instance
                .collection('User')
                .doc(userId)
                .get()
                .then((string) {
              var data = string.data();
              creditBill = data!['credit_card_bill'];
              creditScore = data['credit_score'];
              payableBill = data['payable_bill'];
              score = data['score'];
              creditCount = creditCount - 10;
            }).then((value) {
              creditBill = payableBill + creditBill;
              double value = 100 - ((creditBill / 2000) * 100);
              print('simple! $value');
              value = value * 2;
              print('*2 $value');
              firestore.collection('User').doc(userId).update({
                'credit_score': creditCount >= 0
                    ? (score + value.ceil() + 10)
                    : (score + value.ceil()),
                'score': creditCount >= 0
                    ? FieldValue.increment(10)
                    : FieldValue.increment(0),
              });
            });
          });
          controller.nextPage(
              duration: Duration(seconds: 1), curve: Curves.easeIn);
        } else {
          int price = priceOfOption;
          _showDialogCreditBalNotEnough(context, balance, price, controller,
              gameScore, qualityOfLife, qol2, scroll, index);
        }
      } else {
        if (balance >= priceOfOption) {
          setState1(() {
            balance = balance - priceOfOption;
          });
          firestore.collection('User').doc(userId).update({
            'account_balance': balance,
            'quality_of_life': FieldValue.increment(qol2),
            'game_score': gameScore + balance + qualityOfLife,
            'level_id': index + 1,
            'need': category == 'Need'
                ? FieldValue.increment(priceOfOption)
                : FieldValue.increment(0),
            'want': category == 'Want'
                ? FieldValue.increment(priceOfOption)
                : FieldValue.increment(0),
            // 'credit_score' : debitCount >= 0 ? (350 + value + 10) : (350 + value)
          });
          controller.nextPage(
              duration: Duration(seconds: 1), curve: Curves.easeIn);
        } else {
          _showDialogDebitBalNotEnough(
              context,
              creditBill,
              balance,
              priceOfOption,
              controller,
              gameScore,
              qualityOfLife,
              qol2,
              scroll,
              index);
        }
      }
    } else {
      setState(() {
        scroll = false;
      });
      _showDialogForRestartLevel(context);
    }
  }

  _level1(int lev) {
    return Padding(
        padding: EdgeInsets.only(top: displayWidth(context) * .03),
        child: Container(
          width: displayWidth(context) * .40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(displayWidth(context) * .12)),
          child: ElevatedButton(
            onPressed: () {
              if (lev == 1) {
                firestore.collection('User').doc(userId).update({
                  'replay_level': false,
                  'previous_session_info': 'Level_1_setUp_page',
                  'account_balance': 0,
                  'bill_payment': 0,
                  'credit_card_balance': 0,
                  'credit_card_bill': 0,
                  'credit_score': 0,
                  'level_id': 0,
                  'payable_bill': 0,
                  'quality_of_life': 0,
                  'score': 0,
                  'last_level': 'Level_1_setUp_page',
                });
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                        child: LevelOneSetUpPage(
                          controller: PageController(),
                        ),
                        duration: Duration(milliseconds: 500),
                        type: PageTransitionType.bottomToTop));
              } else {
                firestore.collection('User').doc(userId).update({
                  'previous_session_info': 'Level_1_setUp_page',
                  'account_balance': 0,
                  'bill_payment': 0,
                  'credit_card_balance': 0,
                  'credit_card_bill': 0,
                  'credit_score': 0,
                  'level_id': 0,
                  'payable_bill': 0,
                  'quality_of_life': 0,
                  'score': 0
                });
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                        child: LevelOneSetUpPage(
                          controller: PageController(),
                        ),
                        duration: Duration(milliseconds: 500),
                        type: PageTransitionType.bottomToTop));
              }
            },
            child: Text('Level 1'),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
              Color(0xff828FCE),
            )),
          ),
        ));
  }
  _level2(int lev) {
    return Padding(
        padding: EdgeInsets.only(top: displayWidth(context) * .01),
        child: Container(
          width: displayWidth(context) * .40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(displayWidth(context) * .12)),
          child: ElevatedButton(
            onPressed: () {
              if (lev == 2) {
                firestore.collection('User').doc(userId).update({
                  'replay_level': false,
                  'previous_session_info': 'Level_2_setUp_page',
                  'last_level': 'Level_2_setUp_page',
                  'account_balance': 0,
                  'bill_payment': 0,
                  'credit_card_balance': 0,
                  'credit_card_bill': 0,
                  'credit_score': 0,
                  'level_id': 0,
                  'payable_bill': 0,
                  'quality_of_life': 0,
                  'score': 0
                });
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                        child: LevelTwoSetUpPage(
                          controller: PageController(),
                        ),
                        duration: Duration(milliseconds: 500),
                        type: PageTransitionType.bottomToTop));
              } else {
                firestore.collection('User').doc(userId).update({
                  'previous_session_info': 'Level_2_setUp_page',
                  'account_balance': 0,
                  'bill_payment': 0,
                  'credit_card_balance': 0,
                  'credit_card_bill': 0,
                  'credit_score': 0,
                  'level_id': 0,
                  'payable_bill': 0,
                  'quality_of_life': 0,
                  'score': 0
                });
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                        child: LevelTwoSetUpPage(
                          controller: PageController(),
                        ),
                        duration: Duration(milliseconds: 500),
                        type: PageTransitionType.bottomToTop));
              }
            },
            child: Text('Level 2'),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
              Color(0xff828FCE),
            )),
          ),
        ));
  }
  _level3(int lev) {
    return Padding(
        padding: EdgeInsets.only(top: displayWidth(context) * .02),
        child: Container(
          width: displayWidth(context) * .40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(displayWidth(context) * .12)),
          child: ElevatedButton(
            onPressed: () {
              if (lev == 3) {
                firestore.collection('User').doc(userId).update({
                  'replay_level': false,
                  'previous_session_info': 'Level_3_setUp_page',
                  'last_level': 'Level_3_setUp_page',
                  'account_balance': 0,
                  'bill_payment': 0,
                  'credit_card_balance': 0,
                  'credit_card_bill': 0,
                  'credit_score': 0,
                  'level_id': 0,
                  'payable_bill': 0,
                  'quality_of_life': 0,
                  'score': 0
                });
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                        child: LevelThreeSetUpPage(
                          controller: PageController(),
                        ),
                        duration: Duration(milliseconds: 500),
                        type: PageTransitionType.bottomToTop));
              }
              Navigator.pushReplacement(
                  context,
                  PageTransition(
                      child: LevelThreeSetUpPage(
                        controller: PageController(),
                      ),
                      duration: Duration(milliseconds: 500),
                      type: PageTransitionType.bottomToTop));
            },
            child: Text('Level 3'),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
              Color(0xff828FCE),
            )),
          ),
        ));
  }
  _level4(int lev) {
    return Padding(
        padding: EdgeInsets.only(top: displayWidth(context) * .02),
        child: Container(
          width: displayWidth(context) * .40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(displayWidth(context) * .12)),
          child: ElevatedButton(
            onPressed: () {},
            child: Text('Level 4'),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
              Color(0xff828FCE),
            )),
          ),
        ));
  }
  _level5(int lev) {
    return Padding(
        padding: EdgeInsets.only(top: displayWidth(context) * .02),
        child: Container(
          width: displayWidth(context) * .40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(displayWidth(context) * .12)),
          child: ElevatedButton(
            onPressed: () {},
            child: Text('Level 5'),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
              Color(0xff828FCE),
            )),
          ),
        ));
  }

}
