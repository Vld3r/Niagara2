import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:niagara/hjceinterestingWIUD.dart';
import 'package:niagara/jcesettingsWDF.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ytxInformationsYGWT extends StatefulWidget {
  const ytxInformationsYGWT({super.key});

  @override
  State<ytxInformationsYGWT> createState() => _ytxInformationsYGWTState();
}

class _ytxInformationsYGWTState extends State<ytxInformationsYGWT> {
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
                            'Information',
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
                          'assets/info1.png',
                          'Advantages of Visiting Niagara Falls Resorts',
                          'Niagara Falls Resorts offer a blend of breathtaking natural beauty and world-class amenities. Guests can enjoy stunning views of the iconic waterfalls directly from their hotel rooms, luxurious spa services, and a variety of entertainment options such as casinos and live performances. Resorts like the Marriott Fallsview and Sheraton Fallsview provide easy access to major attractions, making them ideal for visitors looking to experience both relaxation and adventure in one trip. The proximity to the falls, combined with exceptional dining and recreational facilities, makes these resorts a perfect choice for both romantic getaways and family vacations',
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        InterestingContainer(
                          'assets/info2.png',
                          'Best Time of Year to Visit',
                          'While Niagara Falls is a year-round destination, the best time to visit is between June and August. During the summer, the weather is warm, and all the attractions, including boat tours like the Maid of the Mist and the Journey Behind the Falls, are fully operational. The summer months also feature nightly fireworks over the falls and extended hours for many activities, allowing visitors to make the most of their time. However, visiting in the winter has its own charm, with the falls partially frozen and beautifully illuminated, along with lower crowds and off-season hotel rates',
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        InterestingContainer(
                          'assets/info3.png',
                          'What to Visit and Trip Planning',
                          'When planning a trip to Niagara Falls, it\'s recommended to stay for at least two to three days to fully explore the area. Must-visit attractions include the Hornblower Niagara Cruises, the Cave of the Winds, and the Skylon Tower for panoramic views. Beyond the falls, visitors should explore the nearby Niagara-on-the-Lake, known for its charming town, wineries, and the Shaw Festival theatre. Clifton Hill offers family-friendly fun with arcades, museums, and the Niagara SkyWheel. For nature enthusiasts, a visit to the Niagara Parks Botanical Gardens or a hike along the Niagara Gorge is highly recommended',
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
            width: double.infinity,
            height: 150.w,
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
