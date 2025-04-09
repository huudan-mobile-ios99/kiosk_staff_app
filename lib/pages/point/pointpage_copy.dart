// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:vegas_point_portal/getx/my_controller.dart';
// import 'package:vegas_point_portal/model/hive/user_short.dart';
// import 'package:vegas_point_portal/pages/search/listsearchsuggest.dart';
// import 'package:vegas_point_portal/model/status.dart';
// import 'package:vegas_point_portal/model/status_range.dart';
// import 'package:vegas_point_portal/model/user.dart';
// import 'package:vegas_point_portal/pages/point/pointFrameList.dart';
// import 'package:vegas_point_portal/pages/point/pointlist.dart';
// import 'package:vegas_point_portal/pages/point/pointlistinmonth.dart';
// import 'package:vegas_point_portal/service/api_service.dart';
// import 'package:vegas_point_portal/service/hive_service.dart';
// import 'package:vegas_point_portal/util/date_process.dart';
// import 'package:vegas_point_portal/util/detect_platform.dart';
// import 'package:vegas_point_portal/util/mycolor.dart';
// import 'package:vegas_point_portal/util/screen_detect.dart';
// import 'package:vegas_point_portal/util/stringFactory.dart';
// import 'package:vegas_point_portal/util/stringformat.dart';
// import 'package:vegas_point_portal/util/validate_field.dart';
// import 'package:vegas_point_portal/pages/home/bodyPoint.dart';
// import 'package:vegas_point_portal/widget/image_asset.dart';
// import 'package:vegas_point_portal/widget/itemListViewPoint.dart';
// import 'package:vegas_point_portal/widget/loading_dialog.dart';
// import 'package:vegas_point_portal/widget/shakeText.dart';
// import '../../widget/mysnackbar.dart';
// import '../../widget/searchField.dart';

// class PointPage extends StatefulWidget {
//   const PointPage({
//     Key? key,
//   }) : super(key: key);
//   @override
//   State<PointPage> createState() => _PointPageState();
// }

// class _PointPageState extends State<PointPage> {
//   var focusNode = FocusNode();
//   final shakeKey = GlobalKey<ShakeWidgetState>();
//   final searchInputController = TextEditingController();

//   final controllerNumber = TextEditingController();
//   DateTime startDate = DateTime(2020, 01, 01);
//   DateTime endDate = DateTime(2020, 01, 01);
//   final service = ServiceAPIs();
//   final formatNum = NumberFormat();
//   String name = '';
//   String dateofbirth = '';
//   String number = '';
//   String point_current = '';
//   String dateFrame = '';
//   String point_weekly = '';
//   String point_monthly = '';
//   String point_daily = '';
//   String point_slot = '';
//   String point_rl_tb = '';
//   int point_frame = -1;
//   int point_custom = -1;

//   String tierName = '';
//   String cardtrack = '';
//   final myCtl = Get.put(MyGetXController());

//   final format = StringFormat();
//   final today = DateTime.now();
//   bool isSearch = false;
//   bool isSearchView = false;
//   final scrollController = ScrollController();
//   HiveController hiveController = HiveController();
//   String textInput = '';

//   //BOX STORAGE
//   runApi(
//       {required String? number,
//       required MyGetXController? controller,
//       required isSaveLocal}) async {
//     // showLoaderDialogIcon(context);
//     service.getCardTrackByNumber(number: number).then((value) {
//       final String mycardtrackdata = value[0]['TrackData'];
//       if ((value.length) > 0) {
//         service
//             .postPointCardTrack(
//               id: mycardtrackdata,
//               today: format.formatDate(today),
//               today2: format.formatDate(getTomorrow(today)),
//               startWeek: getDateWeek(today)[0],
//               endWeek: getDateWeek(today)[1],
//               startMonth: getDateMonth(today)[0],
//               endMonth: getDateMonth(today)[1],
//             )
//             .whenComplete(() {})
//             .onError((error, stackTrace) {})
//             .then((value) {
//           final Status model = value;
//           if (model.status == true) {
//             debugPrint('TIER NAME : $tierName');
//             ScaffoldMessenger.of(context)
//                 .showSnackBar(mysnackBar('Found Data Successfully'));
//             // Navigator.of(context,rootNavigator: true).pop();
//             setState(() {
//               name = model.data.preferredName;
//               tierName = model.data.tiername;
//               dateofbirth =
//                   format.formatDate(DateTime.parse(model.data.dateofbirth));
//               number = model.data.number.toString();
//               point_current = model.data.loyaltyPointsCurrent.toString();
//               point_daily = model.data.loyaltyPointsToday.toString();
//               point_weekly = model.data.loyaltyPointsWeek.toString();
//               point_monthly = model.data.loyaltyPointsMonth.toString();
//               point_slot = model.data.loyaltyPointTodaySlot.toString();
//               point_rl_tb = model.data.loyaltyPointTodayRLTB.toString();
//               cardtrack = mycardtrackdata;
//               point_custom = -1;
//               startDate = DateTime(2020, 01, 01);
//               endDate = DateTime(2020, 01, 01);
//             });
//             //SAVE DATA IN HIVE BOX
//             isSaveLocal == true
//                 ? HiveController().saveUser(UserShort(
//                     name: model.data.preferredName,
//                     number: model.data.number,
//                     createAt: format.formatTimeAndDate(DateTime.now())))
//                 : () {};

//             //FIND POINT FRAME
//             service.findDateFrameByNumber(number).then((value) {
//               if (value.list.first.frameEndDate == DateTime(2000, 01, 01) &&
//                   value.list.first.frameStartDate == DateTime(2000, 01, 01)) {
//                 setState(() {
//                   dateFrame = '';
//                   point_frame = -1;
//                 });
//               } else {
//                 setState(() {
//                   dateFrame =
//                       '${format.formatDate(value.list.first.frameStartDate)} -- ${format.formatDate(value.list.first.frameEndDate)}';
//                 });
//               }
//               service
//                   .postPointCardNumber(
//                       number: number,
//                       startDate:
//                           format.formatDate(value.list.first.frameStartDate),
//                       endDate: format.formatDate(value.list.first.frameEndDate))
//                   .then((value) {
//                 setState(() {
//                   point_frame = value.data.loyaltyPointsFrame;
//                 });
//                 // print('post point card number $point_frame');
//                 controller!.saveUserData(User(
//                   name: model.data.preferredName,
//                   number: model.data.number,
//                   tiername: model.data.tiername,
//                   dateofbirth:format.formatDate(DateTime.parse(model.data.dateofbirth)),
//                   currentPoint: model.data.loyaltyPointsCurrent,
//                   dailyPoint: model.data.loyaltyPointsToday,
//                   dailyPointRl: model.data.loyaltyPointTodayRLTB,
//                   dailyPointSl: model.data.loyaltyPointTodaySlot,
//                   weeklyPoint: model.data.loyaltyPointsWeek,
//                   monthlyPoint: model.data.loyaltyPointsMonth,
//                   cardtrack: mycardtrackdata,
//                   dateFrame: dateFrame,
//                   framePoint: point_frame,
//                 ));
//               });

//               //SAVE MORE DATEFRAME & POINTFRAME
//               controller!.saveUserData(User(
//                 name: model.data.preferredName,
//                 number: model.data.number,
//                 tiername: model.data.tiername,
//                 dateofbirth:
//                     format.formatDate(DateTime.parse(model.data.dateofbirth)),
//                 currentPoint: model.data.loyaltyPointsCurrent,
//                 dailyPoint: model.data.loyaltyPointsToday,
//                 dailyPointRl: model.data.loyaltyPointTodayRLTB,
//                 dailyPointSl: model.data.loyaltyPointTodaySlot,
//                 weeklyPoint: model.data.loyaltyPointsWeek,
//                 monthlyPoint: model.data.loyaltyPointsMonth,
//                 cardtrack: mycardtrackdata,
//                 dateFrame: dateFrame,
//                 framePoint: point_frame,
//               ));
//             });
//           } else {
//             ScaffoldMessenger.of(context).showSnackBar(mysnackBar('No Data'));
//           }
//         });
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(mysnackBar('No Data'));
//       }
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       // debugPrint('value valueinput save : ${myCtl.valueSearchInput.value}');
//       // debugPrint('has change voucher status : ${myCtl.hasChangeVoucherStatus.value}');
//       if (myCtl.hasChangeVoucherStatus.value == true) {
//         runApi(
//             controller: myCtl,
//             number: myCtl.valueSearchInput.value,
//             isSaveLocal: true);
//       }
//     });
//   }

//   @override
//   void dispose() {
//     controllerNumber.dispose();
//     myCtl.turnOffVouchersStatus();
//     myCtl.valueSearchInput = ''.obs;
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final itemWidth = MediaQuery.of(context).size.width * 1.7 / 4;
//     final height = MediaQuery.of(context).size.height;

//     return Scaffold(
//         resizeToAvoidBottomInset: true,
//         appBar: AppBar(
//             iconTheme: const IconThemeData(
//               color: Colors.white, //change your color here
//             ),
//             centerTitle: true,
//             actions: [
//              Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     IconButton(
//                         onPressed: () {
//                           if (myCtl.isShowListSearch.value == false) {
//                             myCtl.turnonSearchList();
//                           } else {
//                             myCtl.turnoffSearchList();
//                           }
//                         },
//                         icon: GetBuilder<MyGetXController>(
//                           builder: (controller) => Icon(
//                               controller.isShowListSearch.value == false
//                                   ? Icons.filter_list
//                                   : Icons.filter_list_off),
//                         )),
//                   ],
//                 ),
//             ],
//             title: GetBuilder<MyGetXController>(
//                 builder: (controller) =>
//                     // controller.isSearchVoucherInput.value ?
//                     searchTextField(
//                         scrollController: scrollController,
//                         controller: searchInputController,
//                         hint: 'Point Check ',
//                         hasInitValue: true,
//                         valueInit: controller.valueSearchInput.value,
//                         onChange: (value) {},
//                         onTap: () {},
//                         onSubmit: (value) {
//                           // debugPrint('submit value $value ');
//                           if (validateFieldSearch(value, context)) {
//                             controller.saveSearchInputValue(value);
//                             runApi(
//                                 number: value,
//                                 controller: controller,
//                                 isSaveLocal: true);
//                           }
//                         }))),
//         body: Stack(
//           children: [
//             Container(
//                 color: MyColor.grey_BG_main,
//                 height: height,
//                 padding: EdgeInsets.only(
//                   left: detectPlatform() == false
//                       ? StringFactory.padding32
//                       : StringFactory.padding16,
//                   right: detectPlatform() == false
//                       ? StringFactory.padding32
//                       : StringFactory.padding16,
//                   bottom: detectPlatform() == false
//                       ? StringFactory.padding32
//                       : StringFactory.padding16,
//                 ),
//                 width: width,
//                 child: GetBuilder<MyGetXController>(
//                   builder: (myCtl) => 
//                       myCtl.valueSearchInput.value == ''
//                       ? Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             imageAsset('assets/icons/point.png'),
//                             const Center(
//                                 child: Text(
//                               'Enter customer number in app bar to view points',
//                               style: TextStyle(color: MyColor.black_text),
//                               textAlign: TextAlign.center,
//                             )),
//                           ],
//                         )
//                       : bodyPoint(
//                           onTapListSeach: () {
//                             // print('onTap listSeach xx ${myCtl.savedNumber.value} ${myCtl.valueSearchInput.value}');
//                             runApi(
//                                 controller: myCtl,
//                                 number: myCtl.savedNumber.value,
//                                 isSaveLocal: false);
//                           },
//                           onPressDialogCustomer: () {
//                             debugPrint('click dialog custom');
//                             // print('number: $number');
//                             showDialog(
//                                 context: context,
//                                 builder: (context) => AlertDialog(
//                                       backgroundColor: MyColor.grey_BG_main,
//                                       content: SizedBox(
//                                         width: width * 2 / 3,
//                                         height: height * 2 / 3,
//                                         child: PointInMonth(
//                                           number: number == ""
//                                               ? myCtl.userNumber.value
//                                                   .toString()
//                                               : number,
//                                           listDate: getDaysInBetween(
//                                               startDate, endDate),
//                                         ),
//                                       ),
//                                     ));
//                           },
//                           onPressDialogFrame: () {
//                             showDialog(
//                                 context: context,
//                                 builder: (context) => AlertDialog(
//                                       backgroundColor: MyColor.grey_BG_main,
//                                       content: SizedBox(
//                                         width: width * 2 / 3,
//                                         height: height * 2 / 3,
//                                         child: PointFrameList(
//                                             number: number == ""
//                                                 ? myCtl.userNumber.value
//                                                     .toString()
//                                                 : number,
//                                             dates: dateFrame == ''
//                                                 ? myCtl.userDateFrame.value
//                                                 : dateFrame,
//                                             point: point_frame == '' ||
//                                                     point_frame == 0 ||
//                                                     point_frame == -1
//                                                 ? myCtl.userFrameP.value
//                                                 : point_frame),
//                                       ),
//                                     ));
//                           },
//                           onPressDialog: () {
//                             showDialog(
//                                 context: context,
//                                 builder: (context) => AlertDialog(
//                                       backgroundColor: MyColor.grey_BG_main,
//                                       content: SizedBox(
//                                         width: width * 2 / 3,
//                                         height: height * 2 / 3,
//                                         child: PointList(
//                                             point: point_weekly == ''
//                                                 ? myCtl.userWeeklyP.value
//                                                 : int.parse(point_weekly)),
//                                       ),
//                                     ));
//                           },
//                           height: height,
//                           width: width,
//                           formatNum: formatNum,
//                           context: context,
//                           dateofbirth: dateofbirth == ''
//                               ? myCtl.userDateOfBirth.value
//                               : dateofbirth,
//                           format: format,
//                           itemWidth:
//                               detectPlatform() == false ? itemWidth : width,
//                           name: name == '' ? myCtl.userName.value : name,
//                           tierName:
//                               tierName == '' ? myCtl.userTier.value : tierName,
//                           number: number == ''
//                               ? '${myCtl.userNumber.value}'
//                               : number,
//                           point_current: point_current == ''
//                               ? '${myCtl.userCurrentP.value}'
//                               : point_current,
//                           point_daily: point_daily == ''
//                               ? '${myCtl.userDailyP.value}'
//                               : point_daily,
//                           point_monthly: point_monthly == ''
//                               ? '${myCtl.userMonthlyP.value}'
//                               : point_monthly,
//                           point_rl_tb: point_rl_tb == ''
//                               ? '${myCtl.userDailyPRL_TB.value}'
//                               : point_rl_tb,
//                           point_slot: point_slot == ''
//                               ? '${myCtl.userDailyPSL.value}'
//                               : point_slot,
//                           point_weekly: point_weekly == ''
//                               ? '${myCtl.userWeeklyP.value}'
//                               : point_weekly,
//                           point_custom: point_custom,
//                           point_frame: point_frame == -1
//                               ? myCtl.userFrameP.value
//                               : point_frame,
//                           dateFrame: dateFrame == ''
//                               ? myCtl.userDateFrame.value
//                               : dateFrame,
//                           shakeKey: shakeKey,
//                           startDate: startDate,
//                           endDate: endDate,
//                           date1Func: (value) {
//                             debugPrint('object $value');
//                             setState(() {
//                               startDate = value;
//                             });
//                             point_custom = getFramePoint();
//                             if (point_custom != -1) {
//                               shakeKey.currentState?.shake();
//                             }
//                           },
//                           date2Func: (value) {
//                             debugPrint('object 2$value');
//                             setState(() {
//                               endDate = value;
//                             });
//                             point_custom = getFramePoint();
//                             if (point_custom != -1) {
//                               shakeKey.currentState?.shake();
//                             }
//                           }),
//                 )),
//             // SEARCH VIEW
//             GetBuilder<MyGetXController>(
//               builder: (controller) => Visibility(
//                 visible: controller.isShowListSearch.value,
//                 child: Positioned(
//                   right: 0,
//                   top: 0,
//                   child: Opacity(
//                     opacity: 1,
//                     child: Container(
//                       height: height,
//                       width: detectScreenWidthRatio(
//                           context: context,
//                           width: MediaQuery.of(context).size.width),
//                       color: MyColor.grey_BG_main,
//                       child: const ListSuggestPage(),
//                     ),
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ));
//   }

//   getFramePoint() {
//     debugPrint('my trackdata save: ${myCtl.userCardtrack}');
//     final isBefore = startDate.isBefore(endDate);
//     final isEqual = startDate.isAtSameMomentAs(endDate);
//     if (startDate == endDate ||
//         startDate == DateTime(2020, 01, 01) ||
//         endDate == DateTime(2020, 01, 01)) {
//       // showToast('please select dates'.toUpperCase());
//       setState(() {
//         point_custom = -1;
//       });
//     } else {
//       if (isEqual == false || isBefore == true) {
//         service
//             .postPointCardTrackRange(
//                 id: cardtrack == '' ? myCtl.userCardtrack.value : cardtrack,
//                 startDate: format.formatDate(startDate),
//                 endDate: format.formatDate(endDate))
//             .then((value) {
//           StatusRange model = value;
//           setState(() {
//             point_custom = model.data.loyaltyPointsFrame;
//           });
//         });
//       }
//       if (isEqual == true || isBefore == false) {
//         service
//             .postPointCardTrackRange(
//                 // id: cardtrack,
//                 id: cardtrack == '' ? myCtl.userCardtrack.value : cardtrack,
//                 startDate: format.formatDate(startDate),
//                 endDate: format.formatDate(endDate))
//             .then((value) {
//           StatusRange model = value;
//           setState(() {
//             point_custom = model.data.loyaltyPointsFrame;
//           });
//         });
//       }
//       if (isEqual == false && isBefore == false) {
//         setState(() {
//           point_custom = -1;
//         });
//         // showToast('please choose date start < date end'.toUpperCase());
//       }
//     }
//     return point_custom;
//   }
// }
