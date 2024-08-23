import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:niagara/hceasosiyWKJ.dart';
import 'package:shared_preferences/shared_preferences.dart';

class yceOnboardingWUYD extends StatefulWidget {
  const yceOnboardingWUYD({super.key});

  @override
  State<yceOnboardingWUYD> createState() => _yceOnboardingWUYDState();
}

class _yceOnboardingWUYDState extends State<yceOnboardingWUYD> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff050B28),
      body: Column(
        children: [
          Expanded(
              child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/onboarding.png'),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20.r),
                    bottomLeft: Radius.circular(20.r))),
          )),
          SizedBox(
            height: 10.h,
          ),
          Container(
            width: double.infinity,
            child: Column(
              children: [
                Text(
                  'Welcome to',
                  style: TextStyle(color: Colors.white, fontSize: 18.sp),
                ),
                Text(
                  'Niagara Falls Resort & Spa',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 20.sp),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Text(
                    'Here you will find all the information you need about Niagara Falls, what places to visit and a lot of useful content',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xff6774B0), fontSize: 14.sp),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                GestureDetector(
                  onTap: () async {
                    SharedPreferences sharedPrefs =
                        await SharedPreferences.getInstance();
                    sharedPrefs.setBool('bbb', true);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => jceAsosiyWJD()));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    padding:
                        EdgeInsets.symmetric(horizontal: 40.w, vertical: 12.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Color(0xff00D085)),
                    child: Text(
                      'Continue',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 18.sp),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.paddingOf(context).bottom,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
