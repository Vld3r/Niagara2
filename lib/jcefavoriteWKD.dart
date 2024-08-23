import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'hcedb_newsSDKJ.dart';
import 'jhcenews_detailsWJD.dart';
import 'news_model.dart';

class ueFavoriteHGW extends StatefulWidget {
  const ueFavoriteHGW({super.key});

  @override
  State<ueFavoriteHGW> createState() => _ueFavoriteHGWState();
}

class _ueFavoriteHGWState extends State<ueFavoriteHGW> {
  List<News> favoriteItems = [];

  @override
  void initState() {
    super.initState();
    gwxloadFavoritesGFW();
  }

  Future<void> gwxloadFavoritesGFW() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoriteIds = prefs.getStringList('favorite_ids') ?? [];

    // Fetch favorite items from the database
    List<News> loadedFavorites = [];
    for (String id in favoriteIds) {
      int newsId = int.parse(id);
      News? newsItem = await NewsDatabase.instance.readNews(newsId);
      if (newsItem != null) {
        loadedFavorites.add(newsItem);
      }
    }

    setState(() {
      favoriteItems = loadedFavorites;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    SizedBox(width: 15.w),
                    Text(
                      'Favorite',
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
            Expanded(
              child: favoriteItems.isEmpty
                  ? Center(
                      child: Text(
                        'No Favorites Yet',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                        ),
                      ),
                    )
                  : GridView.builder(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.w,
                        mainAxisSpacing: 10.h,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: favoriteItems.length,
                      itemBuilder: (context, index) {
                        final newsItem = favoriteItems[index];
                        return NewsContainer(
                          newsItem.id.toString(),
                          newsItem.title,
                          newsItem.image,
                          newsItem.date,
                          true,
                          // Since it's the favorites page, all items are favorites
                          () {
                            // Navigate to details page of the favorite item
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewsDetails(
                                  newsId: newsItem.id.toString(),
                                ),
                              ),
                            ).then((onValue) {
                              gwxloadFavoritesGFW();
                            });
                          },
                          () {
                            // Handle removing from favorites
                            setState(() {
                              favoriteItems.removeAt(index);
                            });
                            SharedPreferences.getInstance().then((prefs) {
                              List<String> updatedFavorites = favoriteItems
                                  .map((item) => item.id.toString())
                                  .toList();
                              prefs.setStringList(
                                  'favorite_ids', updatedFavorites);
                            });
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
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
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      date,
                      style: TextStyle(color: Color(0xff6774B0)),
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
