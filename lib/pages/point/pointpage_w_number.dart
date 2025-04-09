import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vegas_point_portal/getx/my_controller.dart';
import 'package:vegas_point_portal/model/hive/user_short.dart';
import 'package:vegas_point_portal/model/machine_playing.dart';
import 'package:vegas_point_portal/model/status.dart';
import 'package:vegas_point_portal/model/status_range.dart';
import 'package:vegas_point_portal/model/user.dart';
import 'package:vegas_point_portal/pages/point/pointFrameList.dart';
import 'package:vegas_point_portal/pages/point/pointlist.dart';
import 'package:vegas_point_portal/service/api_service.dart';
import 'package:vegas_point_portal/service/hive_service.dart';
import 'package:vegas_point_portal/util/date_process.dart';
import 'package:vegas_point_portal/util/detect_platform.dart';
import 'package:vegas_point_portal/util/mycolor.dart';
import 'package:vegas_point_portal/util/stringFactory.dart';
import 'package:vegas_point_portal/util/stringformat.dart';
import 'package:vegas_point_portal/pages/home/bodyPoint.dart';
import 'package:vegas_point_portal/widget/image_asset.dart';
import 'package:vegas_point_portal/widget/shakeText.dart';
import 'package:vegas_point_portal/widget/widget.dart';
import '../../widget/mysnackbar.dart';

class PointPageWithNumber extends StatefulWidget {
  bool hasLeading = false;
  PointPageWithNumber({Key? key, required this.hasLeading}) : super(key: key);
  @override
  State<PointPageWithNumber> createState() => _PointPageWithNumberState();
}

class _PointPageWithNumberState extends State<PointPageWithNumber> {
  var focusNode = FocusNode();
  final shakeKey = GlobalKey<ShakeWidgetState>();
  final formatNum = NumberFormat();
  final searchInputController = TextEditingController();

  final controllerNumber = TextEditingController();
  DateTime startDate = DateTime(2020, 01, 01);
  DateTime endDate = DateTime(2020, 01, 01);
  final service = ServiceAPIs();
  String name = '';
  String dateofbirth = '';
  String number = '';
  String point_current = '';
  String point_weekly = '';
  String point_monthly = '';
  String point_daily = '';
  String point_slot = '';
  String point_rl_tb = '';
  int point_frame = -1;
  int point_custom = -1;

  String dateFrame = '';
  String cardtrack = '';
  String tierName = '';
  final myCtl = Get.put(MyGetXController());

  final format = StringFormat();
  final today = DateTime.now();
  bool isSearch = false;

  //BOX STORAGE
  runApi({String? number, MyGetXController? controller,required bool isSaveLocal}) {
    // showLoaderDialogIcon(context);
    service.getCardTrackByNumber(number: number).then((value) {
      final String mycardtrackdata = value[0]['TrackData'].toString();
      if (value.length > 0) {
        service
            .postPointCardTrack(
              id: mycardtrackdata,
              today: format.formatDate(today),
              today2: format.formatDate(getTomorrow(today)),
              startWeek: getDateWeek(today)[0],
              endWeek: getDateWeek(today)[1],
              startMonth: getDateMonth(today)[0],
              endMonth: getDateMonth(today)[1],
            )
            .whenComplete(() {})
            .onError((error, stackTrace) => debugPrint(error.toString()))
            .then((value) {
          final Status model = value;
          if (model.status == true) {
            ScaffoldMessenger.of(context).showSnackBar(mysnackBar('Found Data Successfully'));
            // Navigator.of(context,rootNavigator: true).pop();

            setState(() {
              name = model.data.preferredName;
              dateofbirth = format.formatDate(DateTime.parse(model.data.dateofbirth));
              number = model.data.number.toString();
              tierName = model.data.tiername;
              point_current = model.data.loyaltyPointsCurrent.toString();
              point_daily = model.data.loyaltyPointsToday.toString();
              point_weekly = model.data.loyaltyPointsWeek.toString();
              point_monthly = model.data.loyaltyPointsMonth.toString();
              point_slot = model.data.loyaltyPointTodaySlot.toString();
              point_rl_tb = model.data.loyaltyPointTodayRLTB.toString();
              cardtrack = mycardtrackdata;
              point_frame = -1;
              point_custom = -1;
              startDate = DateTime(2020, 01, 01);
              endDate = DateTime(2020, 01, 01);
            });
            //SAVE LOCAL DATA
            isSaveLocal == true
                ? HiveController().saveUser(UserShort(
                    name: model.data.preferredName,
                    number: model.data.number,
                    createAt: format.formatTimeAndDate(DateTime.now())))
             : () {};

            //FIND POINT FRAME
            service.findDateFrameByNumber(number).then((value) {
              if (value.list.first.frameEndDate == DateTime(2000, 01, 01) &&
                  value.list.first.frameStartDate == DateTime(2000, 01, 01)) {
                setState(() {
                  dateFrame = '';
                  point_frame = -1;
                });
              } else {
                setState(() {
                dateFrame =
                    '${format.formatDate(value.list.first.frameStartDate)} --  ${format.formatDate(value.list.first.frameEndDate)}';
              });
              }
              service
                  .postPointCardNumber(
                      number: number,
                      startDate:
                          format.formatDate(value.list.first.frameStartDate),
                      endDate:
                          format.formatDate(value.list.first.frameEndDate))
                  .then((value) {
                setState(() {
                  point_frame = value.data.loyaltyPointsFrame;
                });
              });
            
            });

            //END HERE
            controller!.saveUserDataWithNumber(User(
              name: model.data.preferredName,
              number: model.data.number,
              dateofbirth:
                  format.formatDate(DateTime.parse(model.data.dateofbirth)),
              currentPoint: model.data.loyaltyPointsCurrent,
              dailyPoint: model.data.loyaltyPointsToday,
              dailyPointRl: model.data.loyaltyPointTodayRLTB,
              dailyPointSl: model.data.loyaltyPointTodaySlot,
              weeklyPoint: model.data.loyaltyPointsWeek,
              monthlyPoint: model.data.loyaltyPointsMonth,
              cardtrack: mycardtrackdata,
														tiername: model.data.tiername,
            ));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(mysnackBar('No Data'));
          }
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(mysnackBar('No Data'));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      debugPrint('value number save : ${myCtl.userNumberSave.value}');
      debugPrint('point number stsatus : ${myCtl.hasChangePointWNumberPage.value}');
      debugPrint('has move to vouchers : ${myCtl.hasMoveToVouchers.value}');
      if (myCtl.hasChangePointWNumberPage.value == true) {
        runApi(controller: myCtl, number: myCtl.userNumberSave.value,isSaveLocal: true);
        //run when init
        runWinLossApi(myCtl.userNumberSave.value);
      }
    });
  }

  late double? totalWinLoss = 0;
  late List<DetailMachinePlaying> listPlaying = [];

  void runWinLossApi(String number) {
    // debugPrint('run winloss api');
    // //RUN WIN/LOSS APIs
    service.machineWinLossDate(date: format.formatDate(DateTime.now()), number: number).then((v) {
      double total = 0.0; // Initialize the totalWinLoss variable
      for (var i = 0; i < v.list.length; i++) {
        total += v.list[i].winLoss; // Accumulate the winLoss values
      }
      setState(() {
        totalWinLoss = total; // Update the state with the accumulated totalWinLoss
        listPlaying=v.list;
      });
      // print('Total winLoss: $totalWinLoss');
    });
  }


  @override
  void dispose() {
    controllerNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final itemWidth = MediaQuery.of(context).size.width * 1.7 / 4;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
            iconTheme: const IconThemeData(
              color: Colors.white, //change your color here
            ),
            centerTitle: true,
            leading: widget.hasLeading == true
                ? IconButton(
                    onPressed: () {
                      myCtl.backToPage();
                      myCtl.turnOffPointNumberStatus();
                    },
                    icon: const Icon(Icons.arrow_back_ios))
                : const SizedBox(
                    width: 0,
                    height: 0,
                  ),
            actions: [
              widget.hasLeading == false
                  ? IconButton(
                      onPressed: () {
                        if (myCtl.isSearchVoucherInput.value == false) {
                          myCtl.turnOnVoucherSearchInput();
                        } else {
                          myCtl.turnOffVoucherSearchInput();
                        }
                      },
                      icon: const Icon(Icons.search))
                  : const SizedBox(width: 0, height: 0)
            ],
            title: GetBuilder<MyGetXController>(
              builder: (controller) => textCustomNormalColorFont(
                  color: MyColor.white, size: 18, text: 'Points'),
            )),
        body: Container(
            color: MyColor.grey_BG_main,
            height: height,
            padding: EdgeInsets.only(
                  left: detectPlatform() == false
                      ? StringFactory.padding32
                      : StringFactory.padding4,
                  right: detectPlatform() == false
                      ? StringFactory.padding32
                      : StringFactory.padding4,
                  bottom: detectPlatform() == false
                      ? StringFactory.padding32
                      : StringFactory.padding4,
                ),
            width: width,
            child: GetBuilder<MyGetXController>(
              builder: (myCtl) => myCtl.userNameWNumber.value == ''
                  ?  Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          imageAsset('assets/icons/point.png'),
                          const Center(
                              child: Text(
                              'Enter customer number in app bar to view points',
                              style: TextStyle(color: MyColor.black_text),
                              textAlign: TextAlign.center,
                            )),
                        ],
                      )
                  : bodyPoint(
                      listPlaying: listPlaying,
                      totalWinLoss: totalWinLoss!,
                      onTapListSeach: () {
                        debugPrint('onTap listSeach2');
                        runApi(
                                controller: myCtl,
                                number: myCtl.savedNumber.value,
                                isSaveLocal: false    
                            );
                        //winloss api
                        runWinLossApi(myCtl.savedNumber.value);
                      },
                      dateFrame: dateFrame,
                      height: height,tierName: tierName == ''
                              ? myCtl.userTierWNumber.value
                              : tierName,
                      width: width,
                      formatNum: formatNum,
                      context: context,
                      dateofbirth: dateofbirth == ''
                          ? myCtl.userDateOfBirthWNumber.value
                          : dateofbirth,
                      format: format,
                      itemWidth:detectPlatform() == false? itemWidth : width  ,
                      name:
                          name == '' ? myCtl.userNameWNumber.value : name,
                      number: number == ''
                          ? '${myCtl.userNumberWNumber.value}'
                          : number,
                      point_current: point_current == ''
                          ? '${myCtl.userCurrentPWNumber.value}'
                          : point_current,
                      point_daily: point_daily == ''
                          ? '${myCtl.userDailyPWNumber.value}'
                          : point_daily,
                      point_monthly: point_monthly == ''
                          ? '${myCtl.userMonthlyPWNumber.value}'
                          : point_monthly,
                      point_rl_tb: point_rl_tb == ''
                          ? '${myCtl.userDailyPRL_TBWNumber.value}'
                          : point_rl_tb,
                      point_slot: point_slot == ''
                          ? '${myCtl.userDailyPSLWNumber.value}'
                          : point_slot,
                      point_weekly: point_weekly == ''
                          ? '${myCtl.userWeeklyPWNumber.value}'
                          : point_weekly,
                      point_custom: point_custom,
                      shakeKey: shakeKey,
                      point_frame: point_frame,
                      startDate: startDate,
                      endDate: endDate,
                      onPressDialogFrame: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  content: SizedBox(
                                    width: detectPlatform() ==false ? width * 2 / 3 : width-StringFactory.padding,
                                    height:  height * 2 / 3 ,
                                    child: PointFrameList(
                                        number: number,
                                        dates: dateFrame,
                                        point: (point_frame)),
                                  ),
                                ));
                      },
                      onPressDialog: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  content: SizedBox(
                                    width: detectPlatform() ==false ? width * 2 / 3 : width-StringFactory.padding,
                                    height:  height * 2 / 3 ,
                                    child: PointList(
                                        point: point_weekly == ''
                                            ? myCtl.userWeeklyPWNumber.value
                                            : int.parse(point_weekly)),
                                  ),
                                ));
                      },
                      date1Func: (value) {
                        debugPrint('object $value');
                        setState(() {
                          startDate = value;
                        });
                        point_frame = getFramePoint();
                        if (point_frame != -1) {
                          shakeKey.currentState?.shake();
                        }
                      },
                      date2Func: (value) {
                        debugPrint('object 2$value');
                        setState(() {
                          endDate = value;
                        });
                        point_frame = getFramePoint();
                        if (point_frame != -1) {
                          shakeKey.currentState?.shake();
                        }
                      }),
            )));
  }

  getFramePoint() {
    debugPrint('my trackdata save: ${myCtl.userCardtrack}');
    final isBefore = startDate.isBefore(endDate);
    final isEqual = startDate.isAtSameMomentAs(endDate);
    if (startDate == endDate ||
        startDate == DateTime(2020, 01, 01) ||
        endDate == DateTime(2020, 01, 01)) {
      // showToast('please select dates'.toUpperCase());
      setState(() {
        point_custom = -1;
      });
    } else {
      if (isEqual == false || isBefore == true) {
        service
            .postPointCardTrackRange(
                id: cardtrack == '' ? myCtl.userCardtrack.value : cardtrack,
                startDate: format.formatDate(startDate),
                endDate: format.formatDate(endDate))
            .then((value) {
          // print(value);
          StatusRange model = value;
          setState(() {
            point_custom = model.data.loyaltyPointsFrame;
          });
        });
      }
      if (isEqual == true || isBefore == false) {
        service
            .postPointCardTrackRange(
                // id: cardtrack,
                id: cardtrack == '' ? myCtl.userCardtrack.value : cardtrack,
                startDate: format.formatDate(startDate),
                endDate: format.formatDate(endDate))
            .then((value) {
          StatusRange model = value;
          setState(() {
            point_custom = model.data.loyaltyPointsFrame;
          });
        });
      }
      if (isEqual == false && isBefore == false) {
        debugPrint('is before <');
        setState(() {
          point_custom = -1;
        });
        // showToast('please choose date start < date end'.toUpperCase());
      }
    }
    return point_custom;
  }
}
