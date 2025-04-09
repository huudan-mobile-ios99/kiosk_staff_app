import 'package:flutter/material.dart';
import 'package:vegas_point_portal/pages/home/home.dart';
import 'package:vegas_point_portal/pages/membership/membership.dart';
import 'package:vegas_point_portal/service/hive_service.dart';
import 'package:vegas_point_portal/util/mycolor.dart';
import 'package:vegas_point_portal/pages/voucher/voucherspage.dart';
import 'package:vegas_point_portal/pages/welcome/welcome.dart';
import 'package:vegas_point_portal/widget/app_behaviour.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Hive.initFlutter();
  // Hive.registerAdapter(UserShortAdapter());
  // await Hive.openBox<UserShort>('user_box');

 
  // Call your HiveController to initialize
  await HiveController().initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        scrollBehavior: AppScrollBehavior(),
        title: 'STAFF KIOSK V3',
        // supportedLocales: [
        //   Locale("en", "US"),
        //   Locale("zh", "CN"),
        //   Locale("zh", "HK"),
        // ],
        // localizationsDelegates: [
        //   DemoLocalization.delegate,
        //   GlobalMaterialLocalizations.delegate,
        //   GlobalWidgetsLocalizations.delegate,
        //   GlobalCupertinoLocalizations.delegate,
        // ],
        // localeResolutionCallback: (locale, supportedLocales) {
        //   if (locale == null) {
        //     debugPrint("*language locale is null!!!");
        //     debugPrint("*${supportedLocales.first}");
        //     return supportedLocales.first;
        //   }
        //   for (Locale supportedLocale in supportedLocales) {
        //     // if (supportedLocale.languageCode == locale.languageCode ||
        //     //     supportedLocale.countryCode == locale.countryCode) {
        //     //   debugPrint("*language ok $supportedLocale");
        //     //   return supportedLocale;
        //     // }
        //     if (supportedLocale.languageCode == locale.languageCode &&
        //         supportedLocale.countryCode == locale.countryCode) {
        //       debugPrint("*language support $supportedLocale");
        //       return supportedLocale;
        //     }
        //   }
        //   debugPrint("*language to fallback ${supportedLocales.first}");
        //   debugPrint("*${supportedLocales.first}");
        //   return supportedLocales.first;
        // },
        theme: ThemeData(
          platform: TargetPlatform.windows,
          // fontFamily: 'Quicksand',
          useMaterial3: false,
          focusColor: MyColor.yellow3,
          hoverColor: MyColor.yellow3,
          splashColor: MyColor.yellow3,
          disabledColor: MyColor.grey_tab,
          // brightness: Brightness.light,
          primaryColor: MyColor.colorPrimary,
          cardColor: MyColor.yellow3,
          cardTheme: const CardTheme(color: MyColor.yellow_accent),
          buttonTheme: const ButtonThemeData(
              colorScheme: ColorScheme(
                  brightness: Brightness.light,
                  primary: MyColor.yellow_accent,
                  onPrimary: MyColor.yellow,
                  secondary: MyColor.grey_tab,
                  onSecondary: MyColor.black_text,
                  error: MyColor.grey,
                  onError: MyColor.grey,
                  surface: MyColor.grey,
                  onSurface: MyColor.grey)),
          colorScheme: ThemeData().colorScheme.copyWith(
                secondary: MyColor.yellow_accent,
                primary: MyColor.yellow_accent,
              ),
          textTheme: const TextTheme(),
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
        ),
        debugShowMaterialGrid: false,
        // home: const CustomerPageBloc(),
        home: const WelcomePage(),
        routes: <String, WidgetBuilder>{
          '/welcome': (BuildContext context) => const WelcomePage(),
          '/homepage': (BuildContext context) => const MyHomePage(),
          '/membership': (BuildContext context) => MemberShipPage(),
          '/point': (BuildContext context) => MemberShipPage(),
          '/map': (BuildContext context) => MemberShipPage(),
          '/vouchers': (BuildContext context) => const VouchersPage(),
        });
  }
}
