import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:financial/ReusableScreen/ExpandedBottomDrawer.dart';
import 'package:financial/ReusableScreen/GameScorePage.dart';
import 'package:financial/ReusableScreen/GlobleVariable.dart';
import 'package:financial/Screens/LevelThreeSetUpPage.dart';
import 'package:financial/Screens/LevelTwoSetUpPage.dart';
import 'package:financial/Model/QueModel.dart';
import 'package:financial/ReusableScreen/PreviewOfBottomDrawer.dart';
import 'package:financial/Screens/devicesSizePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:draggable_bottom_sheet/draggable_bottom_sheet.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:sizer/sizer.dart';
import 'package:financial/Screens/LevelOneSetUpPage.dart';

//ignore: must_be_immutable
class AllQueLevelOne extends StatefulWidget {
  String level = '';
  int levelId = 0;
  int billPayment = 0;
  int qOl = 0;
  int savingBalance = 0;
  int gameScore = 0;
  int creditCardBalance = 0;
  int creditCardBill = 0;
  int payableBill = 0;

  AllQueLevelOne(
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
  _AllQueLevelOneState createState() => _AllQueLevelOneState();
}

class _AllQueLevelOneState extends State<AllQueLevelOne> {
  String level = '';
  var userId;

  // page contoller
  PageController controller = PageController();
  var document;

  // for option selection
  bool flag1 = false;
  bool flag2 = false;
  bool scroll = true;
  bool flagForKnow = false;

  //for model
  QueModel? queModel;
  List<QueModel> list = [];


  Future<QueModel?> getLevelId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userId = pref.getString('uId');
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("Level_1").get();
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
    gameScore = widget.gameScore;
    balance = widget.savingBalance;
    qualityOfLife = widget.qOl;
    level = widget.level;
    controller = PageController(initialPage: widget.levelId);
  }

  @override
  Widget build(BuildContext context) {
    //var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var portrait = displayHeight(context);
    var bottomHeightPotrait = displayHeight(context) * .14;
    var forPortrait = portrait - bottomHeightPotrait;

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
              stream: firestore.collection('Level_1').orderBy('id').snapshots(),
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
                      onPageChanged: (b) {
                        flag1 = false;
                        flag2 = false;
                        flagForKnow = false;
                      },
                      itemBuilder: (context, index) {
                        document = snapshot.data!.docs[index];
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
                                              width:
                                                  displayWidth(context) * .80,
                                              height: forPortrait * .81 -
                                                  bottomHeightPotrait,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    displayWidth(context) * .08,
                                                  ),
                                                  color: Color(0xff6A81F4)),
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top:
                                                              displayHeight(
                                                                      context) *
                                                                  .03,
                                                          left: displayWidth(
                                                                  context) *
                                                              .03,
                                                          right: displayWidth(
                                                                  context) *
                                                              .03),
                                                      child: Center(
                                                        child: Text(
                                                          document[
                                                              'description'],
                                                          style: GoogleFonts
                                                              .workSans(
                                                            fontSize: 16.sp,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Colors.white,
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: displayHeight(
                                                                  context) *
                                                              .03),
                                                      child: StatefulBuilder(
                                                          builder: (context,
                                                              _setState1) {
                                                        return Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width: displayWidth(
                                                                  context) *
                                                              .62,
                                                          height: displayHeight(
                                                                  context) *
                                                              .07,
                                                          decoration: BoxDecoration(
                                                              color: list[index]
                                                                          .isSelected1 ==
                                                                      true
                                                                  ? Color(
                                                                      0xff00C673)
                                                                  : Colors
                                                                      .white,
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      displayWidth(
                                                                              context) *
                                                                          .12)),
                                                          child: SizedBox(
                                                            height: displayHeight(
                                                                    context) *
                                                                .07,
                                                            width: displayWidth(
                                                                    context) *
                                                                .62,
                                                            child: list[index]
                                                                            .isSelected2 ==
                                                                        true ||
                                                                    list[index]
                                                                            .isSelected1 ==
                                                                        true
                                                                ? TextButton(
                                                                    style: ButtonStyle(
                                                                        alignment:
                                                                            Alignment
                                                                                .centerLeft),
                                                                    onPressed:
                                                                        () {},
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          FittedBox(
                                                                        child:
                                                                            RichText(
                                                                          overflow:
                                                                              TextOverflow.clip,
                                                                          text:
                                                                              TextSpan(
                                                                            text:
                                                                                document['option_1'],
                                                                            style: GoogleFonts.workSans(
                                                                                color: list[index].isSelected1 == true ? Colors.white : Color(0xffFFA500),
                                                                                fontWeight: FontWeight.w500,
                                                                                fontSize: 15.sp),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ))
                                                                : TextButton(
                                                                    style: ButtonStyle(
                                                                        alignment:
                                                                            Alignment
                                                                                .centerLeft),
                                                                    onPressed:
                                                                        () async {
                                                                      _setState1(
                                                                          () {
                                                                        flag1 =
                                                                            true;
                                                                      });

                                                                      if (flag2 ==
                                                                          false) {
                                                                        list[index].isSelected1 =
                                                                            true;
                                                                        int qol1 =
                                                                            document['quality_of_life_1'];
                                                                        balance =
                                                                            ((balance - document['option_1_price'])
                                                                                as int?)!;
                                                                        qualityOfLife =
                                                                            qualityOfLife +
                                                                                qol1;
                                                                        var category =
                                                                            document['category'];
                                                                        int price =
                                                                            document['option_1_price'];

                                                                        _optionSelect(
                                                                            index,
                                                                            qol1,
                                                                            balance,
                                                                            qualityOfLife,
                                                                            snapshot,
                                                                            document,
                                                                            category,
                                                                            price);
                                                                      } else {
                                                                        Fluttertoast.showToast(
                                                                            msg:
                                                                                'Sorry, you already selected option');
                                                                      }
                                                                    },
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          FittedBox(
                                                                        child:
                                                                            RichText(
                                                                          overflow:
                                                                              TextOverflow.clip,
                                                                          text:
                                                                              TextSpan(
                                                                            text:
                                                                                document['option_1'],
                                                                            style: GoogleFonts.workSans(
                                                                                color: list[index].isSelected1 == true ? Colors.white : Color(0xffFFA500),
                                                                                fontWeight: FontWeight.w500,
                                                                                fontSize: 15.sp),
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
                                                              Alignment.center,
                                                          width: displayWidth(
                                                                  context) *
                                                              .62,
                                                          height: displayHeight(
                                                                  context) *
                                                              .07,
                                                          decoration: BoxDecoration(
                                                              color: list[index]
                                                                          .isSelected2 ==
                                                                      true
                                                                  ? Color(
                                                                      0xff00C673)
                                                                  : Colors
                                                                      .white,
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      displayWidth(
                                                                              context) *
                                                                          .12)),
                                                          child: SizedBox(
                                                            height: displayHeight(
                                                                    context) *
                                                                .07,
                                                            width: displayWidth(
                                                                    context) *
                                                                .62,
                                                            child: list[index]
                                                                            .isSelected2 ==
                                                                        true ||
                                                                    list[index]
                                                                            .isSelected1 ==
                                                                        true
                                                                ? TextButton(
                                                                    style: ButtonStyle(
                                                                        alignment:
                                                                            Alignment
                                                                                .centerLeft),
                                                                    onPressed:
                                                                        () {},
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          FittedBox(
                                                                        child:
                                                                            RichText(
                                                                          overflow:
                                                                              TextOverflow.clip,
                                                                          textAlign:
                                                                              TextAlign.left,
                                                                          text:
                                                                              TextSpan(
                                                                            text:
                                                                                document['option_2'],
                                                                            style: GoogleFonts.workSans(
                                                                                color: list[index].isSelected2 == true ? Colors.white : Color(0xffFFA500),
                                                                                fontWeight: FontWeight.w500,
                                                                                fontSize: 15.sp),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ))
                                                                : TextButton(
                                                                    style: ButtonStyle(
                                                                        alignment:
                                                                            Alignment
                                                                                .centerLeft),
                                                                    onPressed:
                                                                        () async {
                                                                      _setState2(
                                                                          () {
                                                                        flag2 =
                                                                            true;
                                                                      });

                                                                      if (flag1 ==
                                                                          false) {
                                                                        list[index].isSelected2 =
                                                                            true;
                                                                        int qol2 =
                                                                            document['quality_of_life_2'];
                                                                        balance =
                                                                            ((balance - document['option_2_price'])
                                                                                as int?)!;
                                                                        qualityOfLife =
                                                                            qualityOfLife +
                                                                                qol2;
                                                                        var category =
                                                                            document['category'];
                                                                        int price =
                                                                            document['option_2_price'];
                                                                        _optionSelect(
                                                                            index,
                                                                            qol2,
                                                                            balance,
                                                                            qualityOfLife,
                                                                            snapshot,
                                                                            document,
                                                                            category,
                                                                            price);
                                                                      } else {
                                                                        Fluttertoast.showToast(
                                                                            msg:
                                                                                'Sorry, you already selected option');
                                                                      }
                                                                    },
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          FittedBox(
                                                                        child:
                                                                            RichText(
                                                                          overflow:
                                                                              TextOverflow.clip,
                                                                          textAlign:
                                                                              TextAlign.left,
                                                                          text:
                                                                              TextSpan(
                                                                            text:
                                                                                document['option_2'],
                                                                            style: GoogleFonts.workSans(
                                                                                color: list[index].isSelected2 == true ? Colors.white : Color(0xffFFA500),
                                                                                fontWeight: FontWeight.w500,
                                                                                fontSize: 15.sp),
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
                                                          .01,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ))
                                        ],
                                      ),
                                    ),
                                    previewChild: PreviewOfBottomDrawer(),
                                    expandedChild: ExpandedBottomDrawer(),
                                    minExtent: displayHeight(context) * .14,
                                    maxExtent: displayHeight(context) * .55,
                                  ),
                                ))
                            : _insightsPage(index, snapshot, document);
                      },
                    );
                }
              },
            ),
    ));
  }

  _insightsPage(
      int index, AsyncSnapshot<QuerySnapshot<Object?>> snapshot, document) {
    var portrait = displayHeight(context);
    var bottomHeightPotrait = displayHeight(context) * .14;
    var forPortrait = portrait - bottomHeightPotrait;

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
                  return GestureDetector(
                      onTap: () async {
                        setState(() {
                          flagForKnow = true;
                        });
                        if (index == snapshot.data!.docs.length - 1) {
                          Future.delayed(Duration(seconds: 1),
                              () => _levelCompleteSummary());
                        } else {
                          controller.nextPage(
                              duration: Duration(seconds: 1),
                              curve: Curves.easeIn);
                        }
                      },
                      child: Container(
                        height: displayHeight(context) * .08,
                        width: displayWidth(context) * .75,
                        decoration: BoxDecoration(
                            color:
                                flagForKnow ? Color(0xff00C673) : Colors.white,
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

  _showDialogForRestartLevel(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return WillPopScope(
            onWillPop: () {
              return Future.value(false);
            },
            child: AlertDialog(
              elevation: 3.0,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(displayWidth(context) * .04)),
              actionsPadding: EdgeInsets.all(8.0),
              backgroundColor: Color(0xff6646E6),
              title: Text(
                'Oops! You’ve run out of money\!. '
                'You seem to have fallen prey to mental accounting. Mental accounting is when we value the same amount of money differently because of certain mental associations.',
                style: GoogleFonts.workSans(
                    color: Colors.white, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              content: Text(
                'For example, when we receive a \$200 gift, we are more prone to spend it on discretionary wants, because in our mind, that money is \'free money\'. We might be more careful with spending the same amount, had we earned it.',
                style: GoogleFonts.workSans(
                    color: Colors.white, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              contentPadding: EdgeInsets.all(displayWidth(context) * .04),
              buttonPadding:
                  EdgeInsets.only(right: displayWidth(context) * .04),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          PageTransition(
                              child: LevelOneSetUpPage(
                                  controller: PageController()),
                              type: PageTransitionType.bottomToTop,
                              duration: Duration(milliseconds: 500)));
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white)),
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

  _optionSelect(
      int index,
      int qol2,
      int balance,
      int qualityOfLife,
      AsyncSnapshot<QuerySnapshot<Object?>> snapshot,
      document,
      category,
      int price) async {
    if (index == snapshot.data!.docs.length - 1) {
      Future.delayed(Duration(seconds: 1), () => _levelCompleteSummary());
    }
    if (balance >= 0 || balance == 0) {
      firestore.collection('User').doc(userId).update({
        'account_balance': balance,
        'quality_of_life': FieldValue.increment(qol2),
        'game_score': gameScore + balance + qualityOfLife,
        'level_id': index + 1,
        'need': category == 'Need'
            ? FieldValue.increment(price)
            : FieldValue.increment(0),
        'want': category == 'Want'
            ? FieldValue.increment(price)
            : FieldValue.increment(0),
      });
      controller.nextPage(duration: Duration(seconds: 1), curve: Curves.easeIn);
    } else {
      setState(() {
        scroll = false;
      });
      _showDialogForRestartLevel(context);
    }
  }

  _levelCompleteSummary() async {
    var forPortrait = displayHeight(context);
    var bottomHeightPotrait = displayHeight(context) * .14;
    forPortrait = forPortrait - bottomHeightPotrait;
    DocumentSnapshot documentSnapshot =
        await firestore.collection('User').doc(userId).get();
    int need = documentSnapshot['need'];
    int want = documentSnapshot['want'];

    Color color = Colors.white;
    return showDialog(
        context: context, // <<----
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () {
              return Future.value(false);
            },
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
                                            top: displayHeight(context) * .01,
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
                                          top: displayHeight(context) * .04,
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
                                                    text: (need + want)
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
                                            return Container(
                                              alignment: Alignment.centerLeft,
                                              width:
                                                  displayWidth(context) * .62,
                                              height:
                                                  displayHeight(context) * .07,
                                              decoration: BoxDecoration(
                                                  color: color,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          displayWidth(
                                                                  context) *
                                                              .12)),
                                              child: color == Color(0xff00C673)
                                                  ? TextButton(
                                                      onPressed: () async {},
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
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ))
                                                  : TextButton(
                                                      onPressed: () async {
                                                        setState(() {
                                                          color =
                                                              Color(0xff00C673);
                                                        });

                                                        bool value =
                                                            documentSnapshot.get(
                                                                'replay_level');
                                                        level = documentSnapshot
                                                            .get('last_level');
                                                        gameScore =
                                                            documentSnapshot.get(
                                                                'game_score');
                                                        print('level $level');
                                                        level = level
                                                            .toString()
                                                            .substring(6, 7);
                                                        int lev =
                                                            int.parse(level);
                                                        print('levv $lev');
                                                        if (lev != 1 &&
                                                            value == true) {
                                                          Future.delayed(
                                                              Duration(
                                                                  seconds: 1),
                                                              () => showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return WillPopScope(
                                                                      onWillPop:
                                                                          () {
                                                                        return Future.value(
                                                                            false);
                                                                      },
                                                                      child:
                                                                          AlertDialog(
                                                                        elevation:
                                                                            3.0,
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(displayWidth(context) * .04)),
                                                                        titlePadding:
                                                                            EdgeInsets.zero,
                                                                        title:
                                                                            Container(
                                                                          width:
                                                                              displayWidth(context),
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                EdgeInsets.all(8.0),
                                                                            child:
                                                                                Text(
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
                                                                          mainAxisSize:
                                                                              MainAxisSize.min,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            if (lev >
                                                                                1)
                                                                              Text(
                                                                                'Which level you want play ?',
                                                                                style: GoogleFonts.workSans(fontSize: 12.sp, color: Colors.black, fontWeight: FontWeight.w400),
                                                                              ),
                                                                            if (lev >
                                                                                1)
                                                                              _level1(lev),
                                                                            if (lev >
                                                                                2)
                                                                              _level2(lev),
                                                                            if (lev >
                                                                                3)
                                                                              _level3(lev),
                                                                            if (lev >
                                                                                4)
                                                                              _level4(lev),
                                                                            if (lev >
                                                                                5)
                                                                              _level5(lev),
                                                                            Padding(
                                                                              padding: EdgeInsets.only(top: displayHeight(context) * .03),
                                                                              child: Text(
                                                                                'Want to play current level ?',
                                                                                style: GoogleFonts.workSans(fontSize: 12.sp, color: Colors.black, fontWeight: FontWeight.w400),
                                                                              ),
                                                                            ),
                                                                            if (lev ==
                                                                                1)
                                                                              _level1(lev),
                                                                            if (lev ==
                                                                                2)
                                                                              _level2(lev),
                                                                            if (lev ==
                                                                                3)
                                                                              _level3(lev),
                                                                            if (lev ==
                                                                                4)
                                                                              _level4(lev),
                                                                            if (lev ==
                                                                                5)
                                                                              _level5(lev),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }));
                                                        } else {
                                                          firestore
                                                              .collection(
                                                                  'User')
                                                              .doc(userId)
                                                              .update({
                                                            'previous_session_info':
                                                                'Level_2_setUp_page',
                                                            'level_id': 0,
                                                            'bill_payment': 0,
                                                            'credit_card_balance':
                                                                0,
                                                            'credit_card_bill':
                                                                0,
                                                            'credit_score': 0,
                                                            'payable_bill': 0,
                                                            'score': 0,
                                                            'replay_level':
                                                                false,
                                                            'last_level':
                                                                'Level_2_setUp_page',
                                                            'need': 0,
                                                            'want': 0,
                                                          });
                                                          Future.delayed(
                                                              Duration(
                                                                  seconds: 3),
                                                              () => Navigator
                                                                  .pushReplacement(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                LevelTwoSetUpPage(controller: PageController()),
                                                                      )));
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

// _optionSelectForReplayLevel(int index, int qol2, int replayBal, int replayQol) async {
//   if (replayBal >= 0 || replayBal == 0) {
//     firestore.collection('Replay_Level_Data').doc('asdasd').update({
//       'account_balance': replayBal,
//       'quality_of_life': FieldValue.increment(qol2),
//       'game_score': replayBal + replayQol,
//       'level_id': index + 1
//     });
//     controller.nextPage(duration: Duration(seconds: 1), curve: Curves.easeIn);
//   } else {
//     setState(() {
//       scroll = false;
//     });
//     _showDialogForRestartLevel(context);
//   }
//
//
// }
}
