import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:niagara/jcesettingsWDF.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bhcehotel_and_spaWID.dart';
import 'jceinformationsWIOD.dart';
import 'hjceinterestingWIUD.dart';
import 'hjcenewsWJHD.dart';
import 'jhcenews_detailsWJD.dart';
import 'hcedb_newsSDKJ.dart';
import 'news_model.dart';

class jceAsosiyWJD extends StatefulWidget {
  const jceAsosiyWJD({super.key});

  @override
  State<jceAsosiyWJD> createState() => _jceAsosiyWJDState();
}

class _jceAsosiyWJDState extends State<jceAsosiyWJD> {
  bool notEn = false;
  List<String> jcefavoriteIdsWKD = [];
  List<News> uierecentNewsWKC = [];
  List<String> uyrgalleryImagesEIU = [];

  @override
  void initState() {
    super.initState();
    ucegetDataUIE();
    uyrloadFavoritesEUYF();
    cefloadRecentNewsWIUD(); // Load recent news from the database
    hce_loadGalleryImagesIUFD(); // Load gallery images
  }

  Future<void> ucegetDataUIE() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      notEn = sharedPreferences.getBool('not') ?? false;
    });
  }

  Future<void> uyrloadFavoritesEUYF() async {
    SharedPreferences urprefsWID = await SharedPreferences.getInstance();
    setState(() {
      jcefavoriteIdsWKD = urprefsWID.getStringList('favorite_ids') ?? [];
    });
  }

  Future<void> cefloadRecentNewsWIUD() async {
    List<News> newsList = await NewsDatabase.instance.readAllNews();
    setState(() {
      uierecentNewsWKC =
          newsList.reversed.take(4).toList(); // Get the last 4 news items
    });
  }

  Future<void> ucetoggleFavoriteWOD(String newsId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if (jcefavoriteIdsWKD.contains(newsId)) {
        jcefavoriteIdsWKD.remove(newsId);
      } else {
        jcefavoriteIdsWKD.add(newsId);
      }
    });
    prefs.setStringList('favorite_ids', jcefavoriteIdsWKD);
  }

  bool isFavorite(String newsId) {
    return jcefavoriteIdsWKD.contains(newsId);
  }

  void togEnb() async {
    setState(() {
      notEn = !notEn;
    });
    SharedPreferences jhdnnded = await SharedPreferences.getInstance();
    jhdnnded.setBool("not", notEn);

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

  Future<String> _saveImageToDocumentsDirectory(File image) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = p.join(directory.path, p.basename(image.path));
    return image.copy(path).then((File newImage) => newImage.path);
  }

  Future<void> uyceaddGalleryImageWIU() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final savedPath =
          await _saveImageToDocumentsDirectory(File(pickedFile.path));
      setState(() {
        uyrgalleryImagesEIU.add(savedPath);
        _saveGalleryImages();
      });
    }
  }

  Future<void> _saveGalleryImages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('gallery_images', uyrgalleryImagesEIU);
  }

  Future<void> hce_loadGalleryImagesIUFD() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      uyrgalleryImagesEIU = prefs.getStringList('gallery_images') ?? [];
    });
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          'Choose a category',
                          style: TextStyle(
                            color: Color(0xff6774B0),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ytxSettingsXBVA(),
                              ),
                            ).then((onValue) {
                              ucegetDataUIE();
                              uyrloadFavoritesEUYF();
                            });
                          },
                          child: Image.asset(
                            'assets/settings.png',
                            width: 40.w,
                          ),
                        ),
                        SizedBox(width: 10.w),
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
                                notEn
                                    ? Icons.notifications_none_rounded
                                    : Icons.notifications_off_outlined,
                                size: 20.sp),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'assets/news.png',
                                  width: 20.w,
                                ),
                                SizedBox(width: 5.w),
                                Text(
                                  'Latest News',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => hceNewsPageWJD(),
                                  ),
                                ).then((onValue) {
                                  uyrloadFavoritesEUYF();
                                  cefloadRecentNewsWIUD();
                                });
                              },
                              child: Text(
                                'View All',
                                style: TextStyle(
                                  color: Color(0xff00D085),
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Container(
                          height: 230.h,
                          width: MediaQuery.of(context).size.width,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(
                                uierecentNewsWKC.length,
                                (index) {
                                  final newsItem = uierecentNewsWKC[index];
                                  return Padding(
                                    padding: EdgeInsets.only(right: 10.w),
                                    child: NewsContainer(
                                      newsItem.id.toString(),
                                      newsItem.title,
                                      newsItem.image,
                                      newsItem.date,
                                      isFavorite(newsItem.id.toString()),
                                      () {
                                        ucetoggleFavoriteWOD(
                                          newsItem.id.toString(),
                                        );
                                      },
                                      context,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => jhcxewHotelAndSpaWDJK(),
                              ),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(
                              left: 16.w,
                              right: 16.w,
                              top: 10.h,
                              bottom: 10.h,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xff520087),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      'assets/hotel.png',
                                      width: 50.w,
                                    ),
                                    Image.asset(
                                      'assets/arrow.png',
                                      width: 25.w,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15.h),
                                Text(
                                  'Hotels & Spa',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 17.sp,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  'A detailed description of the hotels and establishments you can enjoy while visiting Niagara Falls',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.4),
                                    fontSize: 13.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          hjufInterestingWJD(),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 199.h,
                                  padding: EdgeInsets.all(10.sp),
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                    color: Color(0xffEA3442),
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        'assets/facts.png',
                                        width: 50.w,
                                      ),
                                      SizedBox(height: 38.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Interesting \nFacts',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 13.sp,
                                            ),
                                          ),
                                          Image.asset(
                                            'assets/arrow.png',
                                            width: 30.w,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 20.w),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ytxInformationsYGWT(),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 199.h,
                                  padding: EdgeInsets.all(10.sp),
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                    color: Color(0xff1F0E60),
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        'assets/informations.png',
                                        width: 50.w,
                                      ),
                                      SizedBox(height: 38.h),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Informations',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 13.sp,
                                            ),
                                          ),
                                          Image.asset(
                                            'assets/arrow.png',
                                            width: 30.w,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 50.h,
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

Widget NewsContainer(
  String id,
  String title,
  String image,
  String date,
  bool isFavorite,
  VoidCallback onFavoriteTap,
  BuildContext context,
) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NewsDetails(newsId: id),
        ),
      );
    },
    child: Container(
      width: 150.w,
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
            height: 90.w,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: image.startsWith('assets/')
                  ? Image.asset(
                      image,
                      fit: BoxFit.cover,
                    )
                  : Image.file(
                      File(image),
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey,
                          child: Center(
                            child: Icon(
                              Icons.broken_image,
                              color: Colors.white,
                              size: 50,
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 12.w, right: 10.w, top: 5.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 10.h),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        date,
                        style: TextStyle(
                          color: Color(0xff6774B0),
                          fontSize: 9.sp,
                        ),
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
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
