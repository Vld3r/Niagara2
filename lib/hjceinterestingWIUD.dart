import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:niagara/hjceinterestingWIUD.dart';
import 'package:niagara/jcesettingsWDF.dart';
import 'package:shared_preferences/shared_preferences.dart';

class hjufInterestingWJD extends StatefulWidget {
  const hjufInterestingWJD({super.key});

  @override
  State<hjufInterestingWJD> createState() => _hjufInterestingWJDState();
}

class _hjufInterestingWJDState extends State<hjufInterestingWJD> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff050B28),
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: BoxDecoration(
                      color: Color(0xff24165D),
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(25.r),
                          bottomLeft: Radius.circular(25.r))),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.paddingOf(context).top + 10.h,
                  left: 16.w,
                  right: 16.w),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(
                                  context); // Handle back button press
                            },
                            child: Image.asset(
                              'assets/back.png',
                              width: 38.w,
                            ),
                          ),
                          SizedBox(width: 15.w),
                          Text(
                            'Interesting Facts',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 20.sp,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 30.w,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InterestingContainer(
                          'assets/int1.png',
                          'Historical Significance of Fallsview Casino Resort',
                          'Fallsview Casino Resort is built on the site of the former transformer station for the Ontario Power Company, which was one of the earliest hydroelectric power stations harnessing the power of Niagara Falls. The resort, which opened in 2004, has since become a landmark of luxury and entertainment, featuring over 3,000 slot machines, 100 gaming tables, and an intimate 1,500-seat theatre known as the Avalon Theatre. The resort’s design also reflects its historical roots, incorporating elements that honor the site\'s industrial past',
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        InterestingContainer(
                          'assets/int2.png',
                          'The Unique Design of Great Wolf Lodge',
                          'Great Wolf Lodge in Niagara Falls is designed with families in mind, featuring a massive indoor water park that maintains a constant temperature of 84°F, making it a year-round attraction. The resort’s themed suites, such as the Wolf Den and KidCabin, are designed to create a magical experience for children. Each suite includes bunk beds and playful decor, providing a unique sleepover experience. Additionally, the resort offers daily activities like story time and character appearances, enhancing the family-friendly atmosphere',
                        ),
                        SizedBox(
                          height: 30.h,
                        )
                      ],
                    ),
                  ))
                ],
              ),
            )
          ],
        ));
  }
}

Widget InterestingContainer(String image, String title, String description) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(18.w),
    decoration: BoxDecoration(
        color: Color(0xff23273B), borderRadius: BorderRadius.circular(15.r)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          // Apply the same radius here
          child: Image.asset(
            width: 150.w,
            height: 100.w,
            image,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          height: 15.h,
        ),
        Text(
          title,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 15.sp),
        ),
        SizedBox(
          height: 10.h,
        ),
        Text(
          description,
          style: TextStyle(color: Color(0xff6774B0), fontSize: 13.sp),
        )
      ],
    ),
  );
}
