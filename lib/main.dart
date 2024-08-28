import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:niagara/jcesplash_screenMZA.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


late AppsflyerSdk nrasAppsflyerSdk;
Future<void> _nrasFirebaseInit() async {
  await Firebase.initializeApp();
}

Future<void> _nrasHatOneSignalInitNet() async {
  await OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  await OneSignal.Location.setShared(false);
  OneSignal.initialize('809907f9-5d58-49ba-b8ae-25e5e71bb94b');
  await Future.delayed(const Duration(seconds: 1));
  OneSignal.Notifications.requestPermission(false);
}


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  await _nrasFirebaseInit();
  await _nrasHatOneSignalInitNet();
  runApp( MultiProvider(
    providers: [
      Provider<SharedPreferences>(
        create: ((context) => sharedPreferences),
      ),
    ],
    child: const MyApp(),
  ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff050B28)),
          useMaterial3: true,
        ),
        home: gxwSplashScreenXW(),
      ),
    );
  }
}
