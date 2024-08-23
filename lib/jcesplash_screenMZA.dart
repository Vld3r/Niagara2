import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:niagara/jcenewsItemJHW.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'hcedb_newsSDKJ.dart';

import 'hceasosiyWKJ.dart';
import 'news_model.dart';
import 'jhceonboardingWDKJ.dart';

class gxwSplashScreenXW extends StatefulWidget {
  const gxwSplashScreenXW({super.key});

  @override
  State<gxwSplashScreenXW> createState() => _gxwSplashScreenXWState();
}

class _gxwSplashScreenXWState extends State<gxwSplashScreenXW>
    with SingleTickerProviderStateMixin {
  late AnimationController cye_animationControllerWIF;
  late Animation<double> ce_animationFIf;
  List<News> xwnewsItemsssFE = [];

  @override
  void initState() {
    super.initState();
    cye_animationControllerWIF = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    ce_animationFIf = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: cye_animationControllerWIF, curve: Curves.easeInOut),
    );
    cye_animationControllerWIF.forward();
    cye_animationControllerWIF.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        await checkAndLoadNews();
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        bool seenOnboarding = sharedPreferences.getBool('bbb') ?? false;
        if (seenOnboarding) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => jceAsosiyWJD()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => yceOnboardingWUYD()),
          );
        }
      }
    });
  }

  Future<void> checkAndLoadNews() async {
    final db = NewsDatabase.instance;

    // Check if the database is empty
    final existingNews = await db.readAllNews();

    if (existingNews.isEmpty) {
      for (var item in newsItems) {
        final news = News(
          title: item['title']!,
          description: item['description']!,
          image: item['image']!,
          date: item['date']!,
        );
        await db.createNews(news);
      }

      // Reload the news after populating the database
      xwnewsItemsssFE = await db.readAllNews();
    } else {
      // Load the existing news from the database
      xwnewsItemsssFE = existingNews;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff050B28),
        body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/logo_icon.png',
                      width: 140.w,
                    ),
                  ),
                  SizedBox(height: 25.h),
                  Text(
                    'Loading...',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    width: 140.w,
                    child: AnimatedBuilder(
                      animation: ce_animationFIf,
                      builder: (context, child) {
                        return LinearProgressIndicator(
                          value: ce_animationFIf.value,
                          backgroundColor: Color(0xff23273B),
                          color: Color(0xFF00CF84),
                          minHeight: 2.h,
                        );
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
