import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

import 'hcedb_newsSDKJ.dart';

import 'news_model.dart'; // Import your SQLite database helper

class uefAddNewsPageWOI extends StatefulWidget {
  const uefAddNewsPageWOI({
    super.key,
  });

  @override
  State<uefAddNewsPageWOI> createState() => _uefAddNewsPageWOIState();
}

class _uefAddNewsPageWOIState extends State<uefAddNewsPageWOI> {
  File? jceimageWOD;
  TextEditingController jeftitleControllerQOD = TextEditingController();
  TextEditingController uycedescriptionControllerWOD = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> icepickImageWODI() async {
    final ImagePicker icepickerWOD = ImagePicker();
    final XFile? pickedFile =
        await icepickerWOD.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        jceimageWOD = File(pickedFile.path);
      }
    });
  }

  Future<void> iuedsaveNewsWOD() async {
    if (jeftitleControllerQOD.text.isEmpty ||
        uycedescriptionControllerWOD.text.isEmpty ||
        jceimageWOD == null) {
      // Handle empty fields
      return;
    }

    // Create new news item
    String ifdcurrentDateJHFD =
        DateTime.now().toIso8601String().split('T').first;
    String imagePath = jceimageWOD!.path;

    // Save the new news item to the SQLite database
    final db = NewsDatabase.instance;
    await db.createNews(News(
      id: null,
      // SQLite will auto-increment the ID
      title: jeftitleControllerQOD.text,
      description: uycedescriptionControllerWOD.text,
      image: imagePath,
      date: ifdcurrentDateJHFD,
    ));

    // Clear fields
    jeftitleControllerQOD.clear();
    uycedescriptionControllerWOD.clear();
    setState(() {
      jceimageWOD = null;
    });

    // Navigate back or show a success message
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff050B28),
      body: Padding(
          padding: EdgeInsets.only(
              left: 16.w,
              right: 16.w,
              top: MediaQuery.paddingOf(context).top + 10.h),
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
                        'Add News',
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
              SizedBox(
                height: 20.h,
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add News Photo',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 10.h),
                    GestureDetector(
                      onTap: icepickImageWODI,
                      child: Container(
                        width: double.infinity,
                        height: 100.h,
                        decoration: BoxDecoration(
                          color: Color(0xff23273B),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: jceimageWOD != null
                            ? Image.file(jceimageWOD!, fit: BoxFit.cover)
                            : Icon(Icons.add_a_photo,
                                color: Colors.white, size: 50.w),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'News Headline',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 10.h),
                    TextField(
                      controller: jeftitleControllerQOD,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Enter a Title',
                        hintStyle: TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Color(0xff23273B),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'News Text',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 10.h),
                    TextField(
                      controller: uycedescriptionControllerWOD,
                      maxLines: 5,
                      keyboardType: TextInputType.text,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Enter a Text',
                        hintStyle: TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Color(0xff23273B),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    GestureDetector(
                      onTap: iuedsaveNewsWOD,
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                        decoration: BoxDecoration(
                          color: Color(0xff00D085),
                          borderRadius: BorderRadius.circular(100.r),
                        ),
                        child: Text(
                          'Publish',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ))
            ],
          )),
    );
  }
}
