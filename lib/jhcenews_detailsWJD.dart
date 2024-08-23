import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'hcedb_newsSDKJ.dart';
import 'news_model.dart';

class NewsDetails extends StatefulWidget {
  final String newsId;

  const NewsDetails({super.key, required this.newsId});

  @override
  State<NewsDetails> createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  News? hrgselectedNewsIUWD;
  List<String> crhcommentsEIU = [];
  List<String> ycrfavoriteIdsED = [];
  TextEditingController urnameControllerWD = TextEditingController();
  TextEditingController ceumessageControllerUEY = TextEditingController();
  int iuceuserRatingEJD = 0;
  final double uceaverageRatingWUID = 4.8; // Fixed average rating
  final int ceftotalRatingsIUW = 19; // Fixed total ratings

  @override
  void initState() {
    super.initState();
    fetchNewsDetails(); // Fetch the news details from the database
    loadComments();
    loadRating();
    loadFavorites(); // Load favorite IDs
  }

  Future<void> fetchNewsDetails() async {
    final db = NewsDatabase.instance;
    News? news = await db.readNews(int.parse(widget.newsId));
    setState(() {
      hrgselectedNewsIUWD = news;
    });
  }

  Future<void> loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      ycrfavoriteIdsED = prefs.getStringList('favorite_ids') ?? [];
    });
  }

  Future<void> toggleFavorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if (ycrfavoriteIdsED.contains(widget.newsId)) {
        ycrfavoriteIdsED.remove(widget.newsId);
      } else {
        ycrfavoriteIdsED.add(widget.newsId);
      }
    });
    prefs.setStringList('favorite_ids', ycrfavoriteIdsED);
  }

  bool isFavorite() {
    return ycrfavoriteIdsED.contains(widget.newsId);
  }

  Future<void> loadComments() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      crhcommentsEIU = prefs.getStringList('${widget.newsId}_comments') ?? [];
    });
  }

  Future<void> addComment(String name, String message) async {
    if (name.isNotEmpty && message.isNotEmpty) {
      String comment = "$name: $message";
      setState(() {
        crhcommentsEIU.add(comment);
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setStringList('${widget.newsId}_comments', crhcommentsEIU);
      urnameControllerWD.clear();
      ceumessageControllerUEY.clear();
    }
  }

  Future<void> loadRating() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      iuceuserRatingEJD = prefs.getInt('${widget.newsId}_rating') ?? 0;
    });
  }

  Future<void> saveRating(int rating) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      iuceuserRatingEJD = rating;
    });
    prefs.setInt('${widget.newsId}_rating', rating);
  }

  @override
  Widget build(BuildContext context) {
    if (hrgselectedNewsIUWD == null) {
      return Scaffold(
        backgroundColor: Color(0xff050B28),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Color(0xff050B28),
      body: Padding(
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
                    SizedBox(
                      width: 15.w,
                    ),
                    Text(
                      'Details',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 20.sp,
                      ),
                    )
                  ],
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: hrgselectedNewsIUWD!.image.startsWith('assets/')
                          ? Image.asset(
                              hrgselectedNewsIUWD!.image,
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              File(hrgselectedNewsIUWD!.image),
                              fit: BoxFit.cover,
                            ),
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            hrgselectedNewsIUWD!.title,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 21.sp,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            toggleFavorite();
                          },
                          child: Container(
                            padding: EdgeInsets.all(5.w),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Icon(
                              isFavorite()
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.white,
                              size: 35.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                          color: Color(0xff23273B),
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            hrgselectedNewsIUWD!.date,
                            style: TextStyle(
                              color: Color(0xff6774B0),
                              fontSize: 16.sp,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "$uceaverageRatingWUID ($ceftotalRatingsIUW)",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                ),
                              ),
                              SizedBox(width: 5.w),
                              Icon(
                                Icons.star,
                                color: Color(0xff00D085),
                                size: 18.sp,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      hrgselectedNewsIUWD!.description,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      "Rate this Material?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(
                        5,
                        (index) => GestureDetector(
                          onTap: () {
                            saveRating(index + 1);
                          },
                          child: Icon(
                            index < iuceuserRatingEJD
                                ? Icons.star
                                : Icons.star_border,
                            color: index < iuceuserRatingEJD
                                ? Colors.yellow
                                : Colors.white,
                            size: 30.sp,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    ...crhcommentsEIU.map((comment) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 10.h),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10.w),
                          decoration: BoxDecoration(
                            color: Color(0xff23273B),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Text(
                            comment,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.sp,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Comments ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "(${crhcommentsEIU.length})",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    TextField(
                      controller: urnameControllerWD,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Your Name",
                        hintStyle: TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Color(0xff23273B),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    TextField(
                      controller: ceumessageControllerUEY,
                      maxLines: 5,
                      keyboardType: TextInputType.text,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Your Message",
                        hintStyle: TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Color(0xff23273B),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    GestureDetector(
                      onTap: () {
                        addComment(urnameControllerWD.text,
                            ceumessageControllerUEY.text);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Color(0xff00D085),
                        ),
                        child: Text(
                          'Add comment',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18.sp,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
