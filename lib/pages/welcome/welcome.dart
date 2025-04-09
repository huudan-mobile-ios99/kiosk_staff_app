import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vegas_point_portal/getx/my_controller.dart';
import 'package:vegas_point_portal/model/status.dart';
import 'package:vegas_point_portal/pages/point/pointpage.dart';
import 'package:vegas_point_portal/pages/point/pointpage_w_number.dart';
import 'package:vegas_point_portal/pages/search/searchpagecontainer.dart';
import 'package:vegas_point_portal/pages/voucher/view/mobile/voucherpage.dart';
import 'package:vegas_point_portal/pages/voucher/view/voucherpage.dart';
import 'package:vegas_point_portal/service/api_service.dart';
import 'package:vegas_point_portal/util/detect_platform.dart';
import 'package:vegas_point_portal/util/mycolor.dart';
import 'package:vegas_point_portal/util/stringFactory.dart';
import 'package:vegas_point_portal/util/stringformat.dart';
import 'package:flutter/foundation.dart';
import 'package:vegas_point_portal/widget/image_asset.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);
  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  var focusNode = FocusNode();
  bool enable = false;
  final myCtl = Get.put(MyGetXController());
  // PageController pageController = PageController();
  String? startDateText, endDateText;
  final service = ServiceAPIs();
  String? number;
  String? idPass;
  final format = StringFormat();
  final today = DateTime.now();
  int _selectedIndex = 0;
  bool? isWebMobile;

  Status model = Status(
      status: false,
      data: Data(
          email: '',
          phone: '',
          tiername: '',
          title: '',
          preferredName: '',
          dateofbirth: '',
          number: 0,
          loyaltyPoints: 0,
          loyaltyPointsToday: 0,
          loyaltyPointTodaySlot: 0,
          loyaltyPointTodayRLTB: 0,
          loyaltyPointsCurrent: 0,
          loyaltyPointsWeek: 0,
          loyaltyPointsMonth: 0));

  NavigationRailLabelType labelType = NavigationRailLabelType.all;
  final controllerInput = TextEditingController();
  double groupAligment = -1.0;
  bool isShowDarkMode = false;
  @override
  void initState() {
    isWebMobile = kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.iOS ||
            defaultTargetPlatform == TargetPlatform.android);
    if (DateTime.now().hour > 19 && DateTime.now().hour < 3) {
      setState(() {
        isShowDarkMode = true;
      });
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
    super.initState();
  }

  @override
  void dispose() {
    controllerInput.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> mainContents = [
      GetBuilder<MyGetXController>(
        builder: (controller) => controller.hasMoveToPointNumber.value == false
            ? const PointPage()
            : PointPageWithNumber(
                hasLeading: true,
              ),
      ),
      GetBuilder<MyGetXController>(
        builder: (controller) => controller.hasMoveToVouchers.value == false
            ? const SearchCustomerPageContainer()
            : PointPageWithNumber(
                hasLeading: true,
              ),
      ),
      detectPlatform() == false ? const VoucherPageDisplay() : const VCDisplayMobile()
    ];
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData(
          primaryColor: MyColor.yellow_accent,
          primarySwatch: Colors.yellow,
          primaryColorLight: MyColor.grey_tab,
          primaryColorDark: MyColor.yellow_accent,
          indicatorColor: MyColor.green,
          unselectedWidgetColor: Colors.grey,
          appBarTheme: AppBarTheme(
              centerTitle: true,
              backgroundColor: isShowDarkMode == false
                  ? MyColor.yellow_accent
                  : MyColor.blacklight),
          useMaterial3: true,
          brightness:
              isShowDarkMode == false ? Brightness.light : Brightness.dark),
      home: Scaffold(
          bottomNavigationBar: detectPlatform() == false
              ? const SizedBox(height: 0, width: 0)
              : BottomNavigationBar(
                  mouseCursor: SystemMouseCursors.grab,
                  selectedFontSize: 12,
                  selectedIconTheme: const IconThemeData(
                    color: MyColor.yellow_accent,
                  ),
                  selectedItemColor: MyColor.yellow_accent,
                  backgroundColor: Colors.white,
                  elevation: 0,
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Points',tooltip: 'View Points'),
                    BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search',tooltip: 'Search MC Playing & Customer'),
                    BottomNavigationBarItem(icon: Icon(Icons.auto_awesome), label: 'Vouchers',tooltip: 'View Vouchers')
                  ],
                  currentIndex: _selectedIndex,
                  onTap: (int index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                ),
          body: PopScope(
            canPop: false,
            onPopInvoked: (didPop) async {
              if (didPop) {
                return;
              }
            },
            child: SafeArea(
              child: Row(
                children: <Widget>[
                  GetBuilder<MyGetXController>(
                    builder: (controller) => detectPlatform() == false
                        ? NavigationRail(
                            backgroundColor: isShowDarkMode == false
                                ? MyColor.white
                                : MyColor.blacklight,
                            indicatorColor: MyColor.yellow3,
                            trailing: Column(
                              children: [
                                const SizedBox(
                                  height: StringFactory.padding48,
                                ),
                                IconButton(
                                    tooltip: isShowDarkMode == false
                                        ? 'switch to dark'
                                        : 'switch to light',
                                    onPressed: () {
                                      setState(() {
                                        isShowDarkMode = !isShowDarkMode;
                                      });
                                    },
                                    icon: Icon(isShowDarkMode == false
                                        ? Icons.dark_mode_outlined
                                        : Icons.light_mode_outlined),
                                    color: MyColor.grey),
                                const SizedBox(
                                  height: StringFactory.padding,
                                ),
                                const SizedBox(
                                  height: StringFactory.padding16,
                                ),
                              ],
                            ),
                            groupAlignment: groupAligment,
                            leading: imageAsset('assets/icons/diamond.png'),
                            selectedIndex: _selectedIndex,
                            onDestinationSelected: (int index) {
                              setState(() {
                                _selectedIndex = index;
                              });
                            },
                            labelType: labelType,
                            destinations: const <NavigationRailDestination>[
                              NavigationRailDestination(
                                icon: Icon(Icons.favorite_border),
                                selectedIcon: Icon(Icons.favorite_border),
                                label: Tooltip(message: "View Points",child: Text('Points',),),
                              ),
                              NavigationRailDestination(
                                icon: Icon(Icons.search),
                                selectedIcon: Icon(Icons.search_outlined),
                                label: Tooltip(message: 'Search MC Playing & Customer',child: Text('Search'),),
                              ),
                              NavigationRailDestination(
                                icon: Icon(Icons.auto_awesome),
                                selectedIcon: Icon(Icons.auto_awesome),
                                label: Tooltip(message: 'View Vouchers',child: Text('Vouchers'),),
                              ),
                            ],
                          )
                        : const SizedBox(height: 0, width: 0),
                  ),
                  const VerticalDivider(thickness: 1, width: 1, color: MyColor.grey_tab),
                  // This is the main content.
                  Expanded(
                    child: GetBuilder<MyGetXController>(
                    builder: (controller) => mainContents[_selectedIndex],
                  )),
                ],
              ),
            ),
          )),
    );
  }
}
