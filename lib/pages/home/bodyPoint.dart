import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:intl/intl.dart';
import 'package:vegas_point_portal/getx/my_controller.dart';
import 'package:vegas_point_portal/model/machine_playing.dart';
import 'package:vegas_point_portal/pages/home/historyList_hivelistener.dart';
import 'package:vegas_point_portal/pages/home/item_next_level.dart';
import 'package:vegas_point_portal/pages/machine/machine_detail.dart';
import 'package:vegas_point_portal/pages/machine/machine_item.dart';
import 'package:vegas_point_portal/util/detect_platform.dart';
import 'package:vegas_point_portal/util/mycolor.dart';
import 'package:vegas_point_portal/util/stringFactory.dart';
import 'package:vegas_point_portal/util/stringformat.dart';
import 'package:vegas_point_portal/widget/datePick.dart';
import 'package:vegas_point_portal/widget/progress_bar.dart/progressPointLevel.dart';
import 'package:vegas_point_portal/widget/rowTextImage.dart';
import 'package:vegas_point_portal/widget/widget.dart';

Widget bodyPoint(
    {shakeKey,
    onPressDialog,
    required double totalWinLoss,
    required Callback onTapListSeach,
    required List<DetailMachinePlaying> listPlaying,
    onPressDialogFrame,
    onPressDialogCustomer,
    NumberFormat? formatNum,
    context,
    tierName,
    StringFormat? format,
    dateFrame,
    width,
    height,
    itemWidth,
    date1Func,
    date2Func,
    int? point_custom,
    required int point_frame,
    name,
    number,
    dateofbirth,
    point_current,
    point_daily,
    point_rl_tb,
    point_slot,
    point_weekly,
    point_monthly,
    startDate,
    endDate}) {
  return GetBuilder<MyGetXController>(
    builder: (controller) => SizedBox(
      height: height,
      width: width,
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          //LIST HISTORY SEARCH
          HistoryPointListListenner(
            onTap: () => onTapListSeach(),
          ),
          const SizedBox(
            height: StringFactory.padding,
          ),
          rowTextImage('POINT DETAIL', 'assets/icons/point.png'),
          const SizedBox(height: StringFactory.padding8),
          rowCenter(isMobile: detectPlatform(), children: [
            buildRow2(text: 'Mr/Mrs:', value: '$name', width: itemWidth),
            buildRow2Container(
                width: itemWidth,
                children: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        textCustomGrey(text: "CN: ", size: 16),
                        textCustom(text: '$number', size: 16),
                      ],
                    ),
                    Row(
                      children: [
                        textCustomGrey(text: "BOD: ", size: 16),
                        textCustom(text: '$dateofbirth', size: 16),
                      ],
                    ),
                  ],
                )),
          ]),
          const SizedBox(height: StringFactory.padding16),
          rowCenter(isMobile: detectPlatform(), children: [
            buildRow2(
                text: 'Current Point:',
                value: formatNum!.format(int.parse(point_current)),
                width: itemWidth),
            buildRow2Container(
                width: itemWidth,
                children: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        textCustomGrey(text: "Daily: ", size: 16),
                        textCustom(
                            text: formatNum.format(int.parse(point_daily)),
                            size: 16),
                      ],
                    ),
                    Row(
                      children: [
                        textCustomGrey(text: "Slot: ", size: 16),
                        textCustom(
                            text: formatNum.format(int.parse(point_slot)),
                            size: 16),
                      ],
                    ),
                    Row(
                      children: [
                        textCustomGrey(text: "RL & TB: ", size: 16),
                        textCustom(
                            text: formatNum.format(int.parse(point_rl_tb)),
                            size: 16),
                      ],
                    )
                  ],
                )),
          ]),
          const SizedBox(height: StringFactory.padding16),
          rowCenter(isMobile: detectPlatform(), children: [
            buildRow2(
                hasIcon: true,
                onPressed: () {
                  onPressDialog();
                },
                text: 'Weekly Point:',
                value: formatNum.format(int.parse(point_weekly)),
                width: itemWidth),
            buildRow2(
                text: 'Monthly Point',
                value: formatNum.format(int.parse(point_monthly)),
                width: itemWidth),
          ]),
          //Row Win Loss
          const SizedBox(height: StringFactory.padding16),
          rowCenter(isMobile: detectPlatform(), children: [
            // buildRow2(
            //     hasIcon: true,
            //     onPressed: () {
            //       debugPrint('view detail win/loss');
            //     },
            //     text: 'Win/Loss:',
            //     value: formatNum.format(int.parse(point_weekly)),
            //     width: itemWidth),
            machineItem(
              text: "Win/Loss: ",
              tooltip: 'Win/Loss Detail',
              value:  "$totalWinLoss",
              // value: "200",
              width: itemWidth,
              shakeKey: GlobalKey(),
              number: "$number",
              name: "$name",
              hasIcon: true,
              hasShakeFunc: true,
              onPressed: () {
                // debugPrint('win/loss click');
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        elevation: 2.0,
                        scrollable: true,
                        backgroundColor: MyColor.white,
                        content: MachinePlayingDetailWithInfo(
                          context: context,
                          name: name,
                          number: number,
                          totalWinLoss:totalWinLoss,
                          listPlaying: listPlaying,
                        ),
                        actions: [
                          TextButton.icon(
                              icon: const Icon(Icons.close_outlined),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              label: const Text('CANCEL'))
                        ],
                      );
                    });
              },
            )
          ]),
          const SizedBox(height: StringFactory.padding32),
          rowTextImage('FRAME POINT', 'assets/icons/point.png'),
          const SizedBox(height: StringFactory.padding8),
          //ROW FRAME POINT
          rowCenter(isMobile: detectPlatform(), children: [
            buildRow2(
              hasIcon:
                  point_frame == '' || point_frame == 0 || point_frame == -1
                      ? false
                      : true,
              onPressed: () {
                onPressDialogFrame();
              },
              hasChildRow: dateFrame == '' ? false : true,
              width: itemWidth,
              // value: '$point_frame',
              value: point_frame == -1 || point_frame == ''
                  ? '0'
                  : formatNum.format((point_frame.abs())),
              dateFrame: '$dateFrame',
              text: 'Frame Point',
            ),
            // ProgressPoint(width: itemWidth,),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  width: itemWidth,
                  padding: const EdgeInsets.all(StringFactory.padding),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(StringFactory.padding4),
                    border: Border.all(
                      color: MyColor.grey_tab,
                      width: 1,
                    ),
                    // borderRadius: BorderRadius.circular(10),
                    color: MyColor.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              textCustomGrey(text: 'Current Level: ', size: 16),
                              textCustom(text: '$tierName', size: 16),
                            ],
                          ),
                          Row(
                            children: [
                              textCustomGrey(text: 'Frame Level: ', size: 11),
                              textCustom(
                                  text: point_frame >= 0 && point_frame < 20000
                                      ? "P"
                                      : point_frame >= 20000 &&
                                              point_frame < 70000
                                          ? 'I'
                                          : point_frame >= 70000 &&
                                                  point_frame < 100000
                                              ? 'I+'
                                              : point_frame >= 100000 &&
                                                      point_frame < 220000
                                                  ? 'V'
                                                  : point_frame >= 220000 &&
                                                          point_frame < 350000
                                                      ? 'V+'
                                                      : point_frame >= 350000 &&
                                                              point_frame <
                                                                  1000000
                                                          ? 'One'
                                                          : point_frame >
                                                                  1000000
                                                              ? 'One+'
                                                              : 'P',
                                  size: 11),
                            ],
                          ),
                          detectPlatform() == true
                              ? rowNextLevel(
                                  formatNum: formatNum,
                                  point_frame: point_frame)
                              : Container()
                        ],
                      ),
                      detectPlatform() == false
                          ? rowNextLevel(
                              formatNum: formatNum, point_frame: point_frame)
                          : Container()
                    ],
                  ),
                ),
              ],
            ),
          ]),
          const SizedBox(
            height: StringFactory.padding,
          ),
          //PROGRESS LINE
          // buildProgressLine(itemWidth: itemWidth*1.5, point_frame: point_frame),
          ProgressPointLevelPage(
            frame_point: point_frame,
          ),
          // ProgressPoint(width: width*2/3,),
          //END PROGRESS LINE
          const SizedBox(height: StringFactory.padding32),
          rowTextImage('CUSTOM CHECK', 'assets/icons/point.png'),
          const SizedBox(height: StringFactory.padding8),
          rowCenter(isMobile: detectPlatform(), children: [
            Container(
                padding: const EdgeInsets.only(left: 10),
                width: itemWidth,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(StringFactory.padding4),
                    color: MyColor.white,
                    border: Border.all(color: MyColor.grey_tab)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    textCustomNormal(
                        text: format!.formatDate(startDate) == "2020-01-01"
                            ? 'From: '
                            : 'From: ${format.formatDate(startDate)}',
                        size: 16),
                    IconButton(
                        tooltip: 'Date Start',
                        onPressed: () {
                          debugPrint('click select date 1');
                          selectDate(context: context).then((value) {
                            if (value == null) {
                              return;
                            }
                            date1Func(value);
                          });
                        },
                        icon: const Icon(Icons.calendar_month,
                            color: MyColor.black_text))
                  ],
                )),
            Container(
                padding: const EdgeInsets.only(left: 10),
                width: itemWidth,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(StringFactory.padding4),
                    color: MyColor.white,
                    border: Border.all(color: MyColor.grey_tab)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    textCustomNormal(
                        text: format.formatDate(endDate) == "2020-01-01"
                            ? 'To: '
                            : 'To: ${format.formatDate(endDate)}',
                        size: 16),
                    IconButton(
                      tooltip: 'Date End',
                      onPressed: () {
                        debugPrint('click select date 2');
                        selectDate(context: context).then((value) {
                          if (value == null) {
                            return;
                          }
                          date2Func(value);
                        });
                      },
                      icon: const Icon(Icons.calendar_month,
                          color: MyColor.black_text),
                    )
                  ],
                )),
          ]),
          const SizedBox(height: StringFactory.padding16),
          rowCenter(isMobile: detectPlatform(), children: [
            buildRow2(
                hasIcon: point_custom == -1 || point_custom == 0 ? false : true,
                hasShakeFunc: true,
                onPressed: () {
                  onPressDialogCustomer();
                },
                shakeKey: shakeKey,
                text: 'Range Point:',
                value:
                    point_custom == -1 ? "" : formatNum.format((point_custom)),
                width: itemWidth),
          ]),
        ],
      ),
    ),
  );
}
