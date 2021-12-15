import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:financial/ReusableScreen/GradientText.dart';
import 'package:financial/Screens/AllQueLevelOne.dart';
import 'package:financial/Screens/devicesSizePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with WidgetsBindingObserver {
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();
  final _emailController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool showLoading = false;
  String? dropdownvalue = '+91';
  FirebaseAuth _auth = FirebaseAuth.instance;

  //for password visibility
  bool hidePassword = true;

  Timer? _timer;
  int _counter = 0;
  late StreamController<int> _events;

  void startTimer() {
    _counter = 60;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      //setState(() {
      (_counter > 0) ? _counter-- : _timer!.cancel();
      //});
      print(_counter);
      _events.add(_counter);
    });
  }

  //function for user login
  Future<bool?> loginUser(String phone, BuildContext context) async {
    try {
      _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationFailed: (FirebaseAuthException exception) {
          print(exception);
          setState(() {
            showLoading = false;
          });
          Fluttertoast.showToast(msg: exception.code.toString());
          Fluttertoast.showToast(msg: 'Please try later');
          Navigator.pop(context);
          // Navigator.pushReplacement(
          //     context, MaterialPageRoute(builder: (context) => LoginPage()));
        },
        codeSent: (String verificationId, [int? forceResendingToken]) {
          showLoading = false;
          Fluttertoast.showToast(msg: "Code send to your device");
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext bContext) {
                return AlertDialog(
                  insetPadding: EdgeInsets.zero,
                  contentPadding: EdgeInsets.all(displayWidth(context) * .02),
                  title: Container(
                    height: displayHeight(context) * .06,
                    child: Image.asset('assets/otp.png'),
                  ),
                  elevation: 2.0,
                  backgroundColor: Color(0xff6448E8),
                  content: StreamBuilder<int>(
                    stream: _events.stream,
                    builder: (context, snapshot) {
                      return Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'OTP Verification',
                              style: GoogleFonts.workSans(
                                  color: Colors.white,
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.w700),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: displayHeight(context) * .02,
                            ),
                            Text(
                              'Enter the OTP send to \n${dropdownvalue.toString() + '  ' + _phoneController.text}',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.workSans(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: displayHeight(context) * .02,
                            ),
                            Container(
                              width: displayWidth(context) * .40,
                              child: PinCodeTextField(
                                  appContext: context,
                                  length: 6,
                                  obscureText: true,
                                  obscuringCharacter: '*',
                                  //controller: _codeController,
                                  blinkWhenObscuring: true,
                                  textStyle:
                                      GoogleFonts.workSans(color: Colors.white),
                                  animationType: AnimationType.fade,
                                  pinTheme: PinTheme(
                                    inactiveColor: Colors.white,
                                    activeColor: Colors.white,
                                  ),
                                  //  controller: _codeController,
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    _codeController.text = value;
                                    print(value);
                                  }),
                            ),
                            snapshot.data.toString() == '0'
                                ? TextButton(
                                    child: Text(
                                      'Resend OTP',
                                      style: GoogleFonts.workSans(
                                          //color: Color(0xff3425a7),
                                          color: Colors.white,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _events.add(60);
                                        startTimer();
                                      });
                                      print('Phone ${_phoneController.text}');
                                      _auth.verifyPhoneNumber(
                                        phoneNumber: phone,
                                        timeout: Duration(seconds: 60),
                                        verificationFailed:
                                            (FirebaseAuthException exception) {
                                          print(exception);
                                          setState(() {
                                            showLoading = false;
                                          });
                                          Fluttertoast.showToast(
                                              msg: exception.code.toString());
                                          Fluttertoast.showToast(
                                              msg: 'Please try later');
                                          Navigator.pop(context);
                                          // Navigator.pushReplacement(
                                          //     context, MaterialPageRoute(builder: (context) => LoginPage()));
                                        },
                                        codeSent: (String verificationId,
                                            [int? forceResendingToken]) {},
                                        verificationCompleted:
                                            (AuthCredential credential) async {
                                          _verificationCompleted(credential);
                                        },
                                        codeAutoRetrievalTimeout:
                                            (String verificationId) {
                                          Fluttertoast.showToast(
                                              msg: "codeAutoRetrievalTimeout");
                                        },
                                      );
                                    },
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/clock.png',
                                        height: displayHeight(context) * .06,
                                        width: displayWidth(context) * .06,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: displayWidth(context) * .02,
                                      ),
                                      Text(
                                        snapshot.data.toString(),
                                        style: GoogleFonts.workSans(
                                            color: Colors.white,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                      );
                    },
                  ),
                  actions: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: displayHeight(context) * .02,
                          top: displayHeight(context) * .02),
                      child: Center(
                        child: GestureDetector(
                          onTap: () async {
                            // PhoneAuthCredential? authCredential;
                            // print(authCredential?.smsCode);
                            try {
                              final code = _codeController.text.trim();
                              AuthCredential credential =
                                  PhoneAuthProvider.credential(
                                verificationId: verificationId,
                                smsCode: code,
                              );
                              _verificationCompleted(credential);
                            } catch (e) {
                              print('${e.toString()}');
                              // Fluttertoast.showToast(msg: e.toString());
                              Fluttertoast.showToast(
                                  msg: 'Please enter valid OTP');
                            }
                          },
                          child: Container(
                            height: displayHeight(context) * .06,
                            width: displayWidth(context) * .30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    displayWidth(context) * .12),
                                color: Colors.white),
                            child: Center(
                              child: Text(
                                'VERIFY',
                                style: GoogleFonts.workSans(
                                    color: Color(0XFF6448E8),
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              });
        },
        verificationCompleted: (AuthCredential credential) async {
          _verificationCompleted(credential);
          //This callback would gets called when verification is done auto maticlly
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          Fluttertoast.showToast(msg: "codeAutoRetrievalTimeout");
        },
      );
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    _events = new StreamController<int>();
    _events.add(60);
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    _emailController.dispose();
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      final PendingDynamicLinkData? data =
          await FirebaseDynamicLinks.instance.getInitialLink();
      if (data?.link != null) {
        handleLink(data!.link);
      }
      FirebaseDynamicLinks.instance.onLink(
          onSuccess: (PendingDynamicLinkData? dynamicLink) async {
        final Uri deepLink = dynamicLink!.link;
        handleLink(deepLink);
      }, onError: (OnLinkErrorException e) async {
        print('onLinkError');
        print(e.message);
      });
    }
  }

  void handleLink(Uri link) async {
    if (link != null) {
      final User? user = (await _auth.signInWithEmailLink(
        email: _emailController.text,
        emailLink: link.toString(),
      ))
          .user;
      try {
        if (user != null) {
          Fluttertoast.showToast(msg: 'Verification Completed');
          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.setString('uId', user.uid);
          print('Sign in ');
          print(user.uid);
          CollectionReference users =
              FirebaseFirestore.instance.collection("User");
          users
              .doc(user.uid)
              .set({
                'credit_card_bill': 0,
                'payable_bill': 0,
                'credit_card_balance': 0,
                'level_id': 0,
                'bill_payment': 0,
                'credit_score': 0,
                'game_score': 0,
                'mobile_number': _emailController.text,
                'net_worth': 0,
                'previous_session_info': 'Level_1',
                'quality_of_life': 0,
                'account_balance': 200,
                'score': 0,
                'replay_level': false,
                'last_level': 'Level_1',
                'need': 0,
                'want': 0,
                'level_1_id': 0,
                'level_2_id': 0,
                'level_3_id': 0,
                'level_4_id': 0,
                'level_5_id': 0,
                'level_6_id': 0,
                'level_2_popQuiz_id': 0,
                'level_3_popQuiz_id': 0,
              })
              .then((value) => print('add'))
              .catchError((error) => print('$error'));
          print(users.id);
          Navigator.of(context).pop();
          Fluttertoast.showToast(msg: 'You are Logged in Successfully');
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => AllQueLevelOne(
                  billPayment: 0,
                  gameScore: 0,
                  level: 'Level_1',
                  levelId: 0,
                  qOl: 0,
                  savingBalance: 200,
                  creditCardBalance: 0,
                  creditCardBill: 0,
                  payableBill: 0,
                ),
              ),
              (Route<dynamic> route) => false);
        } else {
          print("Error");
        }
      } on FirebaseAuthException catch (e) {
        Fluttertoast.showToast(msg: e.message.toString());
      }
    } else {
      setState(() {
        // _success = false;
      });
    }
    setState(() {});
  }

  Future<void> _signInWithEmailAndLink() async {
    _emailController.text = _emailController.text;
    return await FirebaseAuth.instance
        .sendSignInLinkToEmail(
            email: _emailController.text,
            actionCodeSettings: ActionCodeSettings(
              url: 'https://finshark.page.link/finsharkApp',
              handleCodeInApp: true,
              androidPackageName: 'com.finshark',
              androidMinimumVersion: "1",
            ))
        .then(
          (value) => showDialog(
              // barrierDismissible: false,
              context: context,
              builder: (BuildContext bContext) {
                return AlertDialog(
                  insetPadding: EdgeInsets.zero,
                  contentPadding: EdgeInsets.all(displayWidth(context) * .02),
                  title: Container(
                    height: displayHeight(context) * .15,
                    child: Image.asset('assets/sendMail.png'),
                  ),
                  elevation: 2.0,
                  backgroundColor: Color(0xff6448E8),
                  content: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Check your email!',
                          style: GoogleFonts.workSans(
                              color: Colors.white,
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w700),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: displayHeight(context) * .02,
                        ),
                        Container(
                          width: displayWidth(context) * .80,
                          child: Padding(
                            padding:
                                EdgeInsets.all(displayWidth(context) * .03),
                            child: Text(
                              'The login link has been sent to your email address',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.workSans(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        Container(
                          width: displayWidth(context) * .80,
                          child: Padding(
                            padding:
                                EdgeInsets.all(displayWidth(context) * .02),
                            child: Text(
                              _emailController.text,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.workSans(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: displayHeight(context) * .02,
                        ),
                      ],
                    ),
                  ),
                );
              }),
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) =>
          //             EmailVerificationPage(email: _emailController.text)))
        );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: displayHeight(context) * .03,
                ),
                Center(
                  child: GradientText(
                      text: 'finshark',
                      style: GoogleFonts.workSans(
                          fontSize: 30.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff8F45ED),
                          Color(0xff907DE5),
                          Color(0xff5B45C1),
                          Color(0xff513BB5),
                          Color(0xff391BC9)
                        ],
                      )),
                ),
                Container(
                  child: Image.asset(
                    'assets/login.png',
                    fit: BoxFit.contain,
                  ),
                  height: displayHeight(context) * .43,
                  width: displayWidth(context),
                ),
                Center(
                    child: Text(
                  'SIGN UP / LOGIN',
                  style: GoogleFonts.workSans(
                      color: Color(0xff6348E8),
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700),
                )),
                SizedBox(
                  height: displayHeight(context) * .03,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: displayWidth(context) * .26,
                        child: CountryCodePicker(
                          onChanged: _onCountryChange,
                          showCountryOnly: false,
                          initialSelection: 'IN',
                          // hideMainText: true,
                          favorite: ['+91', 'IN'],
                          showFlagMain: true,
                          textStyle: GoogleFonts.workSans(
                              color: Color(0xffB5AEBD), fontSize: 12.sp),
                          dialogSize: Size(displayWidth(context) * .80,
                              displayHeight(context) * .80),
                          padding: EdgeInsets.symmetric(
                            vertical: displayHeight(context) * .01,
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xffE9DBFC),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          border: Border.all(
                            color: Color(0xff8F45ED),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: displayWidth(context) * .02,
                      ),
                      Container(
                        width: displayWidth(context) * .56,
                        child: TextFormField(
                          decoration: InputDecoration(
                              contentPadding: new EdgeInsets.symmetric(
                                  vertical: displayHeight(context) * .02,
                                  horizontal: displayHeight(context) * .01),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          displayWidth(context) * .02)),
                                  borderSide: BorderSide(color: Colors.grey)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          displayWidth(context) * .02)),
                                  borderSide:
                                      BorderSide(color: Color(0xff8F45ED))),
                              fillColor: Color(0xffE9DBFC),
                              filled: true,
                              hintStyle: GoogleFonts.workSans(
                                  color: Color(0xffB5AEBD), fontSize: 13.sp),
                              hintText: " Enter mobile Number"),
                          controller: _phoneController,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: displayHeight(context) * .04,
                  child: Center(
                      child: Text(
                    'OR',
                    style: GoogleFonts.workSans(
                        color: Color(0xffB5AEBD), fontSize: 12.sp),
                  )),
                ),
                Container(
                  width: displayWidth(context) * .84,
                  child: TextFormField(
                    decoration: InputDecoration(
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: displayHeight(context) * .02,
                            horizontal: displayHeight(context) * .00),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(displayWidth(context) * .02)),
                            borderSide: BorderSide(color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(displayWidth(context) * .02)),
                            borderSide: BorderSide(color: Color(0xff8F45ED))),
                        fillColor: Color(0xffE9DBFC),
                        filled: true,
                        hintStyle: GoogleFonts.workSans(
                            color: Color(0xffB5AEBD), fontSize: 13.sp),
                        hintText: "  Enter Email Address",
                        prefixIcon: Padding(
                          padding:  EdgeInsets.only(left: displayWidth(context) * .02),
                          child: Image.asset(
                            'assets/mail.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                        prefixIconConstraints: BoxConstraints(
                          minWidth:  displayWidth(context) * .03,
                          maxHeight:   displayHeight(context) * .04,
                        )),
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                SizedBox(
                  height: displayHeight(context) * .02,
                ),
                Text(
                  'We need this information to create your account.',
                  style: GoogleFonts.workSans(
                      fontWeight: FontWeight.w400,
                      color: Color(0xffB5AEBD),
                      fontSize: 10.sp),
                ),
                SizedBox(
                  height: displayHeight(context) * .02,
                ),
                //  Spacer(),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      // String pattern = r'^([0-9]{10})$';
                      String patternEmail =
                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                      if (_phoneController.text.isEmpty &&
                          _emailController.text.isEmpty) {
                        Fluttertoast.showToast(
                            msg: 'Please enter your phone number or email');
                      } else {
                        if (_phoneController.text.isNotEmpty &&
                            _emailController.text.isEmpty) {
                          if (dropdownvalue!.isEmpty) {
                            Fluttertoast.showToast(
                                msg: 'Please select your country code');
                            return null;
                          }
                          if (_phoneController.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: 'Please enter your phone number');
                            return null;
                          }
                          // else {
                          //   RegExp regExp = RegExp(pattern);
                          //   if (!regExp.hasMatch(_phoneController.text)) {
                          //     Fluttertoast.showToast(
                          //         msg: 'Please enter valid  phone number');
                          //     return null;
                          //   }
                          // }
                          if (dropdownvalue!.isNotEmpty &&
                              _phoneController.text.isNotEmpty) {
                            showLoading = true;
                            if (showLoading)
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CircularProgressIndicator(backgroundColor: Color(0xff4D6EF2)),
                                    ],
                                  );
                                },
                              );
                          }
                          print("drop " + dropdownvalue.toString());
                          final phone =
                              dropdownvalue! + _phoneController.text.trim();
                          //PhoneAuthCredential? authCredential;
                          setState(() {
                            startTimer();
                          });
                          loginUser(phone, context).then((value) {
                            showLoading = false;
                          });
                        }
                        if (_emailController.text.isNotEmpty &&
                            _phoneController.text.isEmpty) {
                          if (_emailController.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: 'Please enter your email');
                            return null;
                          } else {
                            RegExp regExp = RegExp(patternEmail);
                            if (!regExp.hasMatch(_emailController.text)) {
                              Fluttertoast.showToast(
                                  msg: 'Please enter valid  email ');
                              return null;
                            }
                          }
                          _signInWithEmailAndLink();
                        }
                      }
                      if (_phoneController.text.isNotEmpty &&
                          _emailController.text.isNotEmpty) {
                        // RegExp regExp = RegExp(pattern);
                        // RegExp regExpEmail = RegExp(patternEmail);
                        // if (!regExp.hasMatch(_phoneController.text)) {
                        //   Fluttertoast.showToast(
                        //       msg: 'Please enter valid  phone number');
                        //   return null;
                        // } else {
                        final phone =
                            dropdownvalue! + _phoneController.text.trim();
                        //PhoneAuthCredential? authCredential;
                        setState(() {
                          startTimer();
                        });
                        loginUser(phone, context).then((value) {
                          showLoading = false;
                        });
                        // }
                      }
                    },
                    child: Container(
                      height: displayHeight(context) * .08,
                      width: displayWidth(context) * .60,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xff4D6EF2),
                            Color(0xff6448E8),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius:
                            BorderRadius.circular(displayWidth(context) * .12),
                      ),
                      child: Center(
                        child: Text(
                          'SEND',
                          style: GoogleFonts.workSans(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ),
                // SizedBox(
                //   height: displayHeight(context) * .01,
                // ),
                // Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onCountryChange(CountryCode countryCode) {
    // this.phoneNumber =  countryCode.toString();
    setState(() {
      dropdownvalue = countryCode.toString();
    });
    print("New Country selected: " + countryCode.toString());
  }

  _verificationCompleted(AuthCredential credential) async {
    setState(() {
      _timer!.cancel();
    });
    Fluttertoast.showToast(msg: 'Verification Completed');
    Fluttertoast.showToast(msg: 'You are Logged In succesfully');
    UserCredential result = await _auth.signInWithCredential(credential);
    User? user = result.user;
    if (user != null) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('uId', user.uid);
      pref.setString('number', user.phoneNumber.toString());
      CollectionReference users = FirebaseFirestore.instance.collection("User");
      users
          .doc(user.uid)
          .set({
            'credit_card_bill': 0,
            'payable_bill': 0,
            'credit_card_balance': 0,
            'level_id': 0,
            'bill_payment': 0,
            'credit_score': 0,
            'game_score': 0,
            'mobile_number': user.phoneNumber,
            'net_worth': 0,
            'previous_session_info': 'Level_1',
            'quality_of_life': 0,
            'account_balance': 200,
            'score': 0,
            'replay_level': false,
            'last_level': 'Level_1',
            'need': 0,
            'want': 0,
            'level_1_id': 0,
            'level_2_id': 0,
            'level_3_id': 0,
            'level_4_id': 0,
            'level_5_id': 0,
            'level_6_id': 0,
            'level_2_popQuiz_id': 0,
            'level_3_popQuiz_id': 0,
          })
          .then((value) => print('add'))
          .catchError((error) => print('$error'));

      Navigator.of(context).pop();
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => AllQueLevelOne(
              billPayment: 0,
              gameScore: 0,
              level: 'Level_1',
              levelId: 0,
              qOl: 0,
              savingBalance: 200,
              creditCardBalance: 0,
              creditCardBill: 0,
              payableBill: 0,
            ),
          ),
          (Route<dynamic> route) => false);
    } else {
      Fluttertoast.showToast(msg: "Failed to Verify Phone Number");
    }
  }
}
