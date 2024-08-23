import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:niagara/cjhedadd_newsWJKD.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'hcedb_newsSDKJ.dart';
import 'jhcenews_detailsWJD.dart';

import 'news_model.dart'; // Import your database helper

class hceNewsPageWJD extends StatefulWidget {
  const hceNewsPageWJD({super.key});

  @override
  State<hceNewsPageWJD> createState() => _hceNewsPageWJDState();
}

class _hceNewsPageWJDState extends State<hceNewsPageWJD> {
  bool notEn = false;
  List<String> cnfavoriteIdsCB = [];
  List<News> uenewsItemsSJ = []; // Use your News model

  @override
  void initState() {
    super.initState();
    hcgetDataWJD();
    uyceloadFavoritesHWJJD();
    uyeloadNewsFromDBWIUD(); // Load news items from the database
  }

  Future<void> hcgetDataWJD() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      notEn = sharedPreferences.getBool('not') ?? false;
    });
  }

  Future<void> uyceloadFavoritesHWJJD() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      cnfavoriteIdsCB = prefs.getStringList('favorite_ids') ?? [];
    });
  }

  Future<void> uyeloadNewsFromDBWIUD() async {
    final db = NewsDatabase.instance;
    final news = await db.readAllNews();

    setState(() {
      uenewsItemsSJ = news;
    });
  }

  Future<void> toggleFavorite(String newsId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if (cnfavoriteIdsCB.contains(newsId)) {
        cnfavoriteIdsCB.remove(newsId);
      } else {
        cnfavoriteIdsCB.add(newsId);
      }
    });
    prefs.setStringList('favorite_ids', cnfavoriteIdsCB);
  }

  void togEnb() async {
    setState(() {
      notEn = !notEn;
    });
    SharedPreferences jhdnnded = await SharedPreferences.getInstance();
    jhdnnded.setBool(
      "not",
      notEn,
    );

    if (notEn) {
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
                    bottomLeft: Radius.circular(25.r),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.paddingOf(context).top + 10.h,
              left: 16.w,
              right: 16.w,
            ),
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
                        SizedBox(width: 15.w),
                        Text(
                          'News',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 20.sp,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: togEnb,
                      child: Container(
                        padding: EdgeInsets.all(7.sp),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                        child: Icon(
                          notEn
                              ? Icons.notifications_none_rounded
                              : Icons.notifications_off_outlined,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.w,
                            mainAxisSpacing: 10.h,
                            childAspectRatio: 0.75,
                          ),
                          itemCount: uenewsItemsSJ.length,
                          itemBuilder: (context, index) {
                            final news = uenewsItemsSJ[index];
                            return NewsContainer(
                              news.id.toString(),
                              news.title,
                              news.image,
                              news.date,
                              cnfavoriteIdsCB.contains(news.id.toString()),
                              () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NewsDetails(
                                      newsId: news.id.toString(),
                                    ),
                                  ),
                                ).then((onValue) {
                                  uyceloadFavoritesHWJJD();
                                  uyeloadNewsFromDBWIUD();
                                });
                              },
                              () {
                                toggleFavorite(news.id.toString());
                              },
                            );
                          },
                        ),
                        SizedBox(height: 5.h), // Optional spacing
                        Row(
                          children: [
                            Expanded(child: SizedBox()),
                            Expanded(
                              child: GestureDetector(
                                onTap: () async {
                                  Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  uefAddNewsPageWOI()))
                                      .then((onValue) {
                                    uyceloadFavoritesHWJJD();
                                    uyeloadNewsFromDBWIUD();
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 14.h),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Color(0xff00D085),
                                  ),
                                  child: Text(
                                    '+ Add News',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 40.h,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget NewsContainer(String id, String title, String image, String date,
    bool isFavorite, VoidCallback onTap, VoidCallback onFavoriteTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: 150.w,
      height: 190.h,
      decoration: BoxDecoration(
        color: Color(0xff23273B),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: Color(0xff23273B),
              borderRadius: BorderRadius.circular(10.r),
            ),
            height: 100.w,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 12.w, right: 10.w, top: 5.h),
            child: Column(
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 13.sp),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      date,
                      style:
                          TextStyle(color: Color(0xff6774B0), fontSize: 8.sp),
                    ),
                    GestureDetector(
                      onTap: onFavoriteTap,
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        size: 20.w,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
