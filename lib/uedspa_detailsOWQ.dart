import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'jcchotelsItemWKD.dart';

class yceSpaDetailsWDC extends StatefulWidget {
  final String hotelId;

  const yceSpaDetailsWDC({super.key, required this.hotelId});

  @override
  State<yceSpaDetailsWDC> createState() => _yceSpaDetailsWDCState();
}

class _yceSpaDetailsWDCState extends State<yceSpaDetailsWDC> {
  List<String> gcecommentsWDF = [];
  List<Map<String, String>> hcefactsWIU = [];
  List<String> gycgalleryImagesHGE = [];
  int userRating = 0;
  bool isFavorite = false;
  int currentPage = 0;
  String selectedImagePath = '';
  PageController _pageController = PageController();
  List<String> favoriteIds = [];

  TextEditingController uhcrnameControllerWUDF = TextEditingController();
  TextEditingController ucemessageControllerWIU = TextEditingController();
  TextEditingController bcfactTitleControllerKJD = TextEditingController();
  TextEditingController uyefactMessageControllerRUY = TextEditingController();

  @override
  void initState() {
    super.initState();
    yrloadCommentsIUE();
    rfiuloadFactsIUE();
    uyrloadGalleryImagesIUE();
    ywloadRatingWO();
    ucerloadFavoritesEU();
  }

  Future<void> ucerloadFavoritesEU() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      favoriteIds = prefs.getStringList('favorite_ids_hotel') ?? [];
      isFavorite = favoriteIds.contains(widget.hotelId);
    });
  }

  Future<void> uycetoggleFavoriteStatusEIU() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if (favoriteIds.contains(widget.hotelId)) {
        favoriteIds.remove(widget.hotelId);
        isFavorite = false;
      } else {
        favoriteIds.add(widget.hotelId);
        isFavorite = true;
      }
    });
    prefs.setStringList('favorite_ids_hotel', favoriteIds);
  }

  Future<void> yrloadCommentsIUE() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      gcecommentsWDF =
          prefs.getStringList('${widget.hotelId}_comments_hotel') ?? [];
    });
  }

  Future<void> rfiuloadFactsIUE() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      hcefactsWIU =
          prefs.getStringList('${widget.hotelId}_facts_hotel')?.map((fact) {
                final parts = fact.split('|');
                return {"title": parts[0], "message": parts[1]};
              }).toList() ??
              [];
    });
  }

  Future<void> uyrloadGalleryImagesIUE() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      gycgalleryImagesHGE = prefs
              .getStringList('${widget.hotelId}_gallery_hotel') ??
          List.generate(
              6, (index) => 'assets/hotel${widget.hotelId}${index + 1}.png');
      if (gycgalleryImagesHGE.isNotEmpty) {
        selectedImagePath = gycgalleryImagesHGE[0]; // Default first image
      }
    });
  }

  Future<void> ycsaveImageToGalleryJHC(File image) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = p.join(directory.path, p.basename(image.path));
    final savedImage = await image.copy(path);
    setState(() {
      gycgalleryImagesHGE.add(savedImage.path);
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('${widget.hotelId}_gallery_hotel', gycgalleryImagesHGE);
  }

  Future<void> yrwaddGalleryImageWIUE() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      await ycsaveImageToGalleryJHC(File(pickedFile.path));
    }
  }

  Future<void> ywloadRatingWO() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userRating = prefs.getInt('${widget.hotelId}_rating_hotel') ?? 0;
    });
  }

  Future<void> stywaddCommentWUD() async {
    if (uhcrnameControllerWUDF.text.isNotEmpty &&
        ucemessageControllerWIU.text.isNotEmpty) {
      String formattedComment =
          '${uhcrnameControllerWUDF.text}: ${ucemessageControllerWIU.text}';
      setState(() {
        gcecommentsWDF.add(formattedComment);
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setStringList('${widget.hotelId}_comments_hotel', gcecommentsWDF);
      uhcrnameControllerWUDF.clear();
      ucemessageControllerWIU.clear();
    }
  }

  Future<void> sueaddFactWPO() async {
    if (bcfactTitleControllerKJD.text.isNotEmpty &&
        uyefactMessageControllerRUY.text.isNotEmpty) {
      setState(() {
        hcefactsWIU.add({
          "title": bcfactTitleControllerKJD.text,
          "message": uyefactMessageControllerRUY.text,
        });
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setStringList(
          '${widget.hotelId}_facts_hotel',
          hcefactsWIU
              .map((fact) => "${fact['title']}|${fact['message']}")
              .toList());
      bcfactTitleControllerKJD.clear();
      uyefactMessageControllerRUY.clear();
    }
  }

  Future<void> uyrsaveRatingUYRE(int rating) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userRating = rating;
    });
    prefs.setInt('${widget.hotelId}_rating_hotel', rating);
  }

  void uyeupdateMainImageEIU(String imagePath) {
    setState(() {
      selectedImagePath = imagePath;
    });
  }

  void onPageChanged(int index) {
    setState(() {
      currentPage = index;
    });
  }

  Widget buildPageView() {
    return PageView(
      controller: _pageController,
      onPageChanged: onPageChanged,
      children: [
        _buildDescriptionTab(),
        _buildGalleryTab(),
        _buildFactsTab(),
      ],
    );
  }

  Widget buildCustomTabBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
          color: Color(0xff23273B), borderRadius: BorderRadius.circular(10.r)),
      child: Row(
        children: [
          Expanded(
            child: buildTabItem(0, 'Description'),
          ),
          Expanded(
            child: buildTabItem(1, 'Gallery'),
          ),
          Expanded(
            child: buildTabItem(2, 'Facts'),
          )
        ],
      ),
    );
  }

  Widget buildTabItem(int index, String title) {
    return GestureDetector(
        onTap: () {
          _pageController.jumpToPage(index); // Navigate to the selected page
        },
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 12.w),
          decoration: BoxDecoration(
            color: currentPage == index
                ? const Color(0xFF565D85)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Text(
            title,
            style: TextStyle(
                color: currentPage == index ? Colors.white : Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 13.sp),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff050B28),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.paddingOf(context).top + 10,
                left: 16,
                right: 16,
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
                            'Details',
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
                  const SizedBox(height: 20),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: selectedImagePath.isNotEmpty
                        ? (selectedImagePath.startsWith('assets/')
                            ? Image.asset(
                                selectedImagePath,
                                width: double.infinity,
                                height: 200,
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                File(selectedImagePath),
                                width: double.infinity,
                                height: 200,
                                fit: BoxFit.cover,
                              ))
                        : const SizedBox.shrink(),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          hotelsItems.firstWhere((hotel) =>
                              hotel['id'] == widget.hotelId)['title']!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 21,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: uycetoggleFavoriteStatusEIU,
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: Colors.white,
                            size: 35,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            buildCustomTabBar(),
            SizedBox(
              height: 20.h,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height, // Adjust as needed
              child: buildPageView(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDescriptionTab() {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            hotelsItems.firstWhere(
                (hotel) => hotel['id'] == widget.hotelId)['description']!,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(height: 20),
          const Text(
            "Rate this Material?",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(
              5,
              (index) => GestureDetector(
                onTap: () {
                  uyrsaveRatingUYRE(index + 1);
                },
                child: Icon(
                  index < userRating ? Icons.star : Icons.star_border,
                  color: index < userRating ? Colors.yellow : Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Comments (${gcecommentsWDF.length})",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          ...gcecommentsWDF.map((comment) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xff23273B),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  comment,
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            );
          }).toList(),
          const SizedBox(height: 10),
          TextField(
            controller: uhcrnameControllerWUDF,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Your Name",
              hintStyle: const TextStyle(color: Colors.grey),
              filled: true,
              fillColor: const Color(0xff23273B),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: ucemessageControllerWIU,
            style: const TextStyle(color: Colors.white),
            maxLines: 3,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: "Your Message",
              hintStyle: const TextStyle(color: Colors.grey),
              filled: true,
              fillColor: const Color(0xff23273B),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: stywaddCommentWUD,
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: const Color(0xff00D085),
              ),
              child: const Text(
                'Add Comment',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30.h,
          )
        ],
      ),
    );
  }

  Widget _buildGalleryTab() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 1,
              ),
              itemCount: gycgalleryImagesHGE.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () =>
                      uyeupdateMainImageEIU(gycgalleryImagesHGE[index]),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: selectedImagePath == gycgalleryImagesHGE[index]
                              ? const Color(0xff00D085)
                              : Colors.transparent,
                          width: 3.0,
                        ),
                      ),
                      child: gycgalleryImagesHGE[index].startsWith('assets/')
                          ? Image.asset(
                              gycgalleryImagesHGE[index],
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              File(gycgalleryImagesHGE[index]),
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: yrwaddGalleryImageWIUE,
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: const Color(0xff00D085),
                ),
                child: const Text(
                  '+ Add More Photo',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30.h,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildFactsTab() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...hcefactsWIU.map((fact) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xff23273B),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fact['title']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        fact['message']!,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Facts',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 17.sp),
                ),
                Text(
                  '(${hcefactsWIU.length})',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 17.sp),
                )
              ],
            ),
            const SizedBox(height: 10),
            TextField(
              controller: bcfactTitleControllerKJD,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Fact Title",
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: const Color(0xff23273B),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: uyefactMessageControllerRUY,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Fact Message",
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: const Color(0xff23273B),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: sueaddFactWPO,
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: const Color(0xff00D085),
                ),
                child: const Text(
                  '+ Add Fact',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30.h,
            )
          ],
        ),
      ),
    );
  }
}
