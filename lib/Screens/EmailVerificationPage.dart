import 'package:financial/ReusableScreen/GlobleVariable.dart';
import 'package:financial/Screens/devicesSizePage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class EmailVerificationPage extends StatefulWidget {
  final  String email;
  const EmailVerificationPage({Key? key,required this.email }) : super(key: key);

  @override
  _EmailVerificationPageState createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent,elevation: 0,),
      body: Container(
        decoration: boxDecoration,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: displayHeight(context) * .26,
                width: displayWidth(context),
                child: Image.asset(
                  'assets/send.png',
                ),
              ),
              SizedBox(
                height: displayHeight(context) * .06,
              ),
              Text(
                'Check your email!',
                style: GoogleFonts.workSans(
                    fontSize: 28.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: displayHeight(context) * .03,
              ),
              Padding(
                padding: EdgeInsets.all(displayWidth(context) * .03),
                child: Text(
                  'The login link has been sent to your email address ${widget.email}',
                  style: GoogleFonts.workSans(
                      fontSize: 16.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
