import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'jcchotelsItemWKD.dart';
import 'uedspa_detailsOWQ.dart';

class jhcxewHotelAndSpaWDJK extends StatefulWidget {
  const jhcxewHotelAndSpaWDJK({super.key});

  @override
  State<jhcxewHotelAndSpaWDJK> createState() => _jhcxewHotelAndSpaWDJKState();
}

class _jhcxewHotelAndSpaWDJKState extends State<jhcxewHotelAndSpaWDJK> {
  bool notEn = false;
  List<String> hcefavoriteIdsWJKD = [];
  bool jcxwshowFavoritesOnlyKDF = false;

  @override
  void initState() {
    super.initState();
    jcgetDataKJH();
    hcloadFavoritesWFX();
  }

  Future<void> jcgetDataKJH() async {
    SharedPreferences hcesharedWDF = await SharedPreferences.getInstance();
    setState(() {
      notEn = hcesharedWDF.getBool('not') ?? false;
    });
  }

  Future<void> hcloadFavoritesWFX() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      hcefavoriteIdsWJKD = prefs.getStringList('favorite_ids_hotel') ?? [];
    });
  }

  Future<void> jhcwtoggleFavoriteWOF(String hotelsId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if (hcefavoriteIdsWJKD.contains(hotelsId)) {
        hcefavoriteIdsWJKD.remove(hotelsId);
      } else {
        hcefavoriteIdsWJKD.add(hotelsId);
      }
    });
    prefs.setStringList('favorite_ids_hotel', hcefavoriteIdsWJKD);
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
    // Filter the hotelsItems list based on the favoriteIds if showFavoritesOnly is true
    List<Map<String, String>> displayedHotels = jcxwshowFavoritesOnlyKDF
        ? hotelsItems
            .where((hotel) => hcefavoriteIdsWJKD.contains(hotel['id']))
            .toList()
        : hotelsItems;

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
                          'Hotels & Spa',
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
                          itemCount: displayedHotels.length,
                          itemBuilder: (context, index) {
                            final hotel = displayedHotels[index];
                            return HotelContainer(
                              hotel['id']!,
                              hotel['title']!,
                              hotel['image']!,
                              hotel['date']!,
                              hcefavoriteIdsWJKD.contains(hotel['id']!),
                              () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => yceSpaDetailsWDC(
                                      hotelId: hotel['id']!,
                                    ),
                                  ),
                                ).then((onValue) {
                                  hcloadFavoritesWFX();
                                });
                              },
                              () {
                                jhcwtoggleFavoriteWOF(hotel['id']!);
                              },
                            );
                          },
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

Widget HotelContainer(String id, String title, String image, String date,
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
                      fontSize: 14.sp),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'more..',
                      style:
                          TextStyle(color: Color(0xff6774B0), fontSize: 12.sp),
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
