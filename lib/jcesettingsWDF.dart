import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:niagara/22urlsIND.dart';
import 'package:niagara/jcecontactWJD.dart';
import 'package:niagara/jcefavoriteWKD.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ytxSettingsXBVA extends StatefulWidget {
  const ytxSettingsXBVA({super.key});

  @override
  State<ytxSettingsXBVA> createState() => _ytxSettingsXBVAState();
}

class _ytxSettingsXBVAState extends State<ytxSettingsXBVA> {
  bool hxsnotEnXJHS = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hgxgetDataHSDF();
  }

  Future<void> hgxgetDataHSDF() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      hxsnotEnXJHS = sharedPreferences.getBool('not') ?? false;
    });
  }

  Future<void> trm() async {
    final Uri _url = Uri.parse(PLINKS.ters);

    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  Future<void> prc() async {
    final Uri _url = Uri.parse(PLINKS.pri);

    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  Future<void> reet() async {
    final InAppReview inAppReview = InAppReview.instance;
    if (await inAppReview.isAvailable()) {
      inAppReview.requestReview();
    }
  }

  void togEnb() async {
    setState(() {
      hxsnotEnXJHS = !hxsnotEnXJHS;
    });
    SharedPreferences jhdnnded = await SharedPreferences.getInstance();
    jhdnnded.setBool(
      "not",
      hxsnotEnXJHS,
    );

    if (hxsnotEnXJHS) {
      final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff050B28),
        body: Padding(
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
                          Navigator.pop(context); // Handle back button press
                        },
                        child: Image.asset(
                          'assets/back.png',
                          width: 38.w,
                        ),
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      Text(
                        'Settings',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 20.sp),
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: togEnb,
                    child: Container(
                      width: 40.w,
                      height: 40.w,
                      padding: EdgeInsets.all(7.sp),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50.r),
                      ),
                      child: Icon(
                          hxsnotEnXJHS
                              ? Icons.notifications_none_rounded
                              : Icons.notifications_off_outlined,
                          size: 20.sp),
                    ),
                  )
                ],
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    SettingsContainer('Favorite', 'assets/like.png', () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ueFavoriteHGW()));
                    }),
                    SettingsContainer('Rate Us', 'assets/star.png', reet),
                    SettingsContainer('Contact Us', 'assets/send.png', () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => iuceContactWIU()));
                    }),
                    SettingsContainer(
                        'Term of Service', 'assets/term.png', trm),
                    SettingsContainer(
                        'Privacy Policy', 'assets/privacy.png', prc),
                  ],
                ),
              ))
            ],
          ),
        ));
  }
}

Widget SettingsContainer(String text, String icon, VoidCallback onTap) {
  return GestureDetector(
    behavior: HitTestBehavior.translucent,
    onTap: onTap,
    child: Container(
      margin: EdgeInsets.only(top: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Color(0xff23273B), borderRadius: BorderRadius.circular(12.r)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                icon,
                width: 30.w,
              ),
              SizedBox(
                width: 10.w,
              ),
              Text(
                text,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 14.sp),
              )
            ],
          ),
          Image.asset(
            'assets/arrow_set.png',
            width: 20.w,
          )
        ],
      ),
    ),
  );
}
