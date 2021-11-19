import 'dart:async';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:financial/ReusableScreen/GlobleVariable.dart';
import 'package:financial/ReusableScreen/GradientText.dart';
import 'package:financial/Screens/RentPlan.dart';
import 'package:financial/Screens/GroceryPlan.dart';
import 'package:financial/Screens/devicesSizePage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'dart:math' as math;

class TvAndInternetPlan extends StatefulWidget {
  TvAndInternetPlan({
    Key? key,
  }) : super(key: key);

  @override
  _TvAndInternetPlanState createState() => _TvAndInternetPlanState();
}

class _TvAndInternetPlanState extends State<TvAndInternetPlan>
    with SingleTickerProviderStateMixin {
//animation controller and for selected option
  late AnimationController _animationController;
  bool isSelected1 = false;
  bool isSelected2 = false;
  bool isSelected3 = false;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    Timer(Duration(milliseconds: 600), () => _animationController.forward());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var forPortrait = displayHeight(context);
    var bottomHeightPotrait = displayHeight(context) * .14;
    forPortrait = forPortrait - bottomHeightPotrait;

    return SafeArea(
      child: Scaffold(
        body: DoubleBackToCloseApp(
            snackBar: const SnackBar(
              content: Text('Tap back again to leave'),
            ),
            child: Container(
                width: displayWidth(context),
                height: displayHeight(context),
                decoration: boxDecoration,
                child: Column(
                  children: [
                    SlideTransition(
                      position: Tween<Offset>(
                        begin: Offset(-1, 0),
                        end: Offset.zero,
                      ).animate(_animationController),
                      child: Column(
                        children: [
                          SizedBox(
                            height: displayHeight(context) * .04,
                          ),
                          Center(
                            child: Container(
                              height: displayHeight(context) * .08,
                              width: displayWidth(context) * .62,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    displayWidth(context) * .14),
                                color: Color(0xffEF645B),
                              ),
                              child: Center(
                                  child: Text(
                                'Step 2',
                                style: GoogleFonts.workSans(
                                    color: Colors.white,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600),
                              )),
                            ),
                          ),
                          SizedBox(
                            height: displayHeight(context) * .04,
                          ),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  right: displayWidth(context) * .10,
                                  left: displayWidth(context) * .10),
                              child: Text(
                                'TV AND BROADBAND PLAN',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.workSans(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18.sp,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: displayHeight(context) * .04,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isSelected1 = true;
                                isSelected2 = false;
                                isSelected3 = false;
                              });
                            },
                            child: Card(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: isSelected1
                                          ? [
                                              Color(0xff2DDA91),
                                              Color(0xff0DA867)
                                            ]
                                          : [Colors.white, Colors.white],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                width: displayWidth(context) * .85,
                                height: displayHeight(context) * .16,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: displayWidth(context) * .30,
                                      child: Container(
                                        child: Image.asset(
                                          'assets/level_2_first_image.png',
                                          width: displayWidth(context) * .20,
                                          height: displayHeight(context) * .12,
                                          fit: BoxFit.contain,
                                          color:
                                              isSelected1 ? Colors.white : null,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: displayWidth(context) * .55,
                                      child: Container(
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'NO TV. 1 MBPS UNLIMITED INTERNET',
                                                textAlign: TextAlign.left,
                                                style: GoogleFonts.workSans(
                                                    color: isSelected1
                                                        ? Colors.white
                                                        : Color(0xff3D3D3D),
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12.sp),
                                              ),
                                              SizedBox(
                                                height: displayHeight(context) *
                                                    .01,
                                              ),
                                              RichText(
                                                  text: TextSpan(
                                                      text: ' ${'\$50\/'}',
                                                      style: GoogleFonts.workSans(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: isSelected1
                                                              ? Colors.white
                                                              : Color(
                                                                  0xff4D5DDD),
                                                          fontSize: 14.sp),
                                                      children: [
                                                    TextSpan(
                                                      text: 'month',
                                                      style: GoogleFonts.workSans(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: isSelected1
                                                              ? Colors.white
                                                              : Color(
                                                                  0xff4D5DDD),
                                                          fontSize: 14.sp),
                                                    )
                                                  ])),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              elevation: 6.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: displayHeight(context) * .02,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isSelected1 = false;
                                isSelected2 = true;
                                isSelected3 = false;
                              });
                            },
                            child: Card(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: isSelected2
                                          ? [
                                              Color(0xff2DDA91),
                                              Color(0xff0DA867)
                                            ]
                                          : [Colors.white, Colors.white],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                width: displayWidth(context) * .85,
                                height: displayHeight(context) * .16,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: displayWidth(context) * .30,
                                      child: Container(
                                        child: Image.asset(
                                          'assets/level_2_second_image.png',
                                          width: displayWidth(context) * .20,
                                          height: displayHeight(context) * .12,
                                          fit: BoxFit.contain,
                                          color:
                                              isSelected2 ? Colors.white : null,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: displayWidth(context) * .55,
                                      child: Container(
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'LOCAL CABLE. 25 MBPS UNLIMITED INTERNET',
                                                textAlign: TextAlign.left,
                                                style: GoogleFonts.workSans(
                                                    color: isSelected2
                                                        ? Colors.white
                                                        : Color(0xff3D3D3D),
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12.sp),
                                              ),
                                              SizedBox(
                                                height: displayHeight(context) *
                                                    .01,
                                              ),
                                              RichText(
                                                  text: TextSpan(
                                                      text: '${'\$80\/'}',
                                                      style: GoogleFonts.workSans(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: isSelected2
                                                              ? Colors.white
                                                              : Color(
                                                                  0xff4D5DDD),
                                                          fontSize: 14.sp),
                                                      children: [
                                                    TextSpan(
                                                      text: 'month',
                                                      style: GoogleFonts.workSans(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: isSelected2
                                                              ? Colors.white
                                                              : Color(
                                                                  0xff4D5DDD),
                                                          fontSize: 14.sp),
                                                    )
                                                  ])),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              elevation: 6.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: displayHeight(context) * .02,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isSelected1 = false;
                                isSelected2 = false;
                                isSelected3 = true;
                              });
                            },
                            child: Card(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: isSelected3
                                          ? [
                                              Color(0xff2DDA91),
                                              Color(0xff0DA867)
                                            ]
                                          : [Colors.white, Colors.white],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                width: displayWidth(context) * .85,
                                height: displayHeight(context) * .16,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: displayWidth(context) * .30,
                                      child: Container(
                                        child: Image.asset(
                                          'assets/level_2_third_image.png',
                                          width: displayWidth(context) * .20,
                                          height: displayHeight(context) * .12,
                                          fit: BoxFit.contain,
                                          color:
                                              isSelected3 ? Colors.white : null,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: displayWidth(context) * .55,
                                      child: Container(
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'CABLE TV. 100 MBPS UNLIMITED INTERNET',
                                                textAlign: TextAlign.left,
                                                style: GoogleFonts.workSans(
                                                    color: isSelected3
                                                        ? Colors.white
                                                        : Color(0xff3D3D3D),
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12.sp),
                                              ),
                                              SizedBox(
                                                height: displayHeight(context) *
                                                    .01,
                                              ),
                                              RichText(
                                                  text: TextSpan(
                                                      text: '${'\$120\/'}',
                                                      style: GoogleFonts.workSans(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: isSelected3
                                                              ? Colors.white
                                                              : Color(
                                                                  0xff4D5DDD),
                                                          fontSize: 14.sp),
                                                      children: [
                                                    TextSpan(
                                                      text: 'month',
                                                      style: GoogleFonts.workSans(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: isSelected3
                                                              ? Colors.white
                                                              : Color(
                                                                  0xff4D5DDD),
                                                          fontSize: 14.sp),
                                                    )
                                                  ])),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              elevation: 6.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: displayHeight(context) * .02,
                          ),
                          isSelected1 == true ||
                                  isSelected2 == true ||
                                  isSelected3 == true
                              ? Text('')
                              : Text(
                                  'Please, choose one option',
                                  style: GoogleFonts.workSans(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp),
                                ),
                          SizedBox(
                            height: displayHeight(context) * .02,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                              onTap: () {
                                globalVar = globalVar - forPlan1;
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RentPlan()));
                              },
                              child: SlideTransition(
                                position: Tween<Offset>(
                                  begin: Offset(-1, 0),
                                  end: Offset.zero,
                                ).animate(_animationController),
                                child: FadeTransition(
                                  opacity: _animationController,
                                  child: Container(
                                    width: displayWidth(context) * .30,
                                    height: displayHeight(context) * .07,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(28.0),
                                          topRight: Radius.circular(28.0),
                                        )),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                            child: Icon(
                                          Icons.arrow_back_ios_outlined,
                                          size: 18.0,
                                          color: Color(0xff6D00C2),
                                        )),
                                        SizedBox(
                                          width: displayWidth(context) * .03,
                                        ),
                                        GradientText(
                                            text: 'Prev',
                                            style: GoogleFonts.workSans(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white),
                                            gradient: const LinearGradient(
                                                colors: [
                                                  Colors.white,
                                                  Color(0xff6D00C2)
                                                ],
                                                transform: GradientRotation(
                                                    math.pi / 2))),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () async {
                                SharedPreferences pref =
                                    await SharedPreferences.getInstance();
                                if (isSelected1 == true) {
                                  forPlan2 = 50;
                                  globalVar = globalVar + forPlan2;
                                  pref.setInt('plan2', 50);
                                } else if (isSelected2 == true) {
                                  forPlan2 = 80;
                                  globalVar = globalVar + forPlan2;
                                  pref.setInt('plan2', 80);
                                } else if (isSelected3 == true) {
                                  forPlan2 = 120;
                                  globalVar = globalVar + forPlan2;
                                  pref.setInt('plan2', 120);
                                }
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            GroceryPlan()));
                              },
                              child: SlideTransition(
                                position: Tween<Offset>(
                                  begin: Offset(1, 0),
                                  end: Offset.zero,
                                ).animate(_animationController),
                                child: FadeTransition(
                                  opacity: _animationController,
                                  child: Container(
                                    width: displayWidth(context) * .30,
                                    height: displayHeight(context) * .07,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(28.0),
                                          bottomLeft: Radius.circular(28.0),
                                        )),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: displayWidth(context) * .04),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          GradientText(
                                              text: 'Next',
                                              style: GoogleFonts.workSans(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white),
                                              gradient: const LinearGradient(
                                                  colors: [
                                                    Colors.white,
                                                    Color(0xff6D00C2)
                                                  ],
                                                  transform: GradientRotation(
                                                      math.pi / 2))),
                                          SizedBox(
                                            width: displayWidth(context) * .03,
                                          ),
                                          Container(
                                              child: Icon(
                                            Icons.arrow_forward_ios_outlined,
                                            size: 18.0,
                                            color: Color(0xff6D00C2),
                                          )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: displayHeight(context) * .01,
                    )
                  ],
                ))),
      ),
    );
  }
}
