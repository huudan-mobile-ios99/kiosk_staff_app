import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:vegas_point_portal/util/detect_platform.dart';
import 'package:vegas_point_portal/util/mycolor.dart';
import 'package:vegas_point_portal/util/stringFactory.dart';
import 'package:vegas_point_portal/widget/progress_bar.dart/item_text.dart';
import 'package:vegas_point_portal/widget/widget.dart';

class ProgressPointLevelPage extends StatefulWidget {
  final int frame_point;
  const ProgressPointLevelPage({Key? key, required this.frame_point})
      : super(key: key);

  @override
  State<ProgressPointLevelPage> createState() => _ProgressPointLevelPageState();
}

class _ProgressPointLevelPageState extends State<ProgressPointLevelPage> {
  final int levelP = 0;
  final int levelI = 20000;
  final int levelIPlus = 70000;
  final int levelV = 100000;
  final int levelVPlus = 220000;
  final int levelOne = 350000;
  final int levelOnePlus = 1000000;
  final String levelPText = "P";
  final String levelIText = "I";
  final String levelIPlusText = "I+";
  final String levelVText = "V";
  final String levelVPlusText = "V+";
  final String levelOneText = "ONE";
  final String levelOnePlusText = "ONE+";

  final String plevelP = "0 pts";
  final String plevelI = "20,000 pts";
  final String plevelIPlus = "70,000 pts";
  final String plevelV = "100,000 pts";
  final String plevelVPlus = "220,000 pts";
  final String plevelOne= "350,000 pts";
  final String plevelOnePlus = "1,000,000 pts";

  final String plevelPShort = "0";
  final String plevelIShort = "20K";
  final String plevelIPlusShort = "70K";
  final String plevelVShort = "100K";
  final String plevelVPlusShort = "220K";
  final String plevelOneShort= "350K";
  final String plevelOnePlusShort = "1M";





  late final double ratioWidth = 1;
  calculateLevelRatio(double point) {
    double widthItem = 1 / 6;
    double percentFirst(max) {
      return point / max * widthItem;
    }

    double percentLeft(min, max) {
      return (point - min) / (max - min) * widthItem;
    }

    if (point >= levelP && point < levelI) {
      // print('level P');
      return percentFirst(levelI);
    } else if (point >= levelI && point < levelIPlus) {
      // print('level I');
      return widthItem + percentLeft(levelI, levelIPlus);
    } else if (point >= levelIPlus && point < levelV) {
      // print('level I+');
      return widthItem*2 + percentLeft(levelIPlus, levelV);
    } else if (point >= levelV && point < levelVPlus) {
      // print('level V');
      return widthItem*3 + percentLeft(levelV, levelVPlus);
    } else if (point >= levelVPlus && point < levelOne) {
      // print('level One');
      return widthItem*4 + percentLeft(levelVPlus, levelOne);
    } else if (point >= levelOne && point < levelOnePlus) {
      // print('level One+');
      return widthItem*5 + percentLeft(levelOne, levelOnePlus);
    } else if (point >= levelOnePlus) {
      print('level One+ MAX');
      return widthItem*6;
    }
    return 0;
  }




  final NumberFormat? formatNum = NumberFormat();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      debugPrint('INIT ProgressPointLevelPage: ${widget.frame_point}');
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final itemList = detectPlatform() == false ? (width * 2 / 3) / 6 : width*.95 / 6;
    final itemWidth = detectPlatform() == false ? width * 2 / 3 : width*.95;
    final height = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        textCustomGrey(text: "YOUR PROGRESS ROAD MAP", size: 16),
        Stack(
          children: [
            Container(
              width: itemWidth,
              color: MyColor.grey_tab2,
              padding: const EdgeInsets.symmetric(vertical: StringFactory.padding4),
              child:itemTextBlank()),
            Positioned(
                left: calculateLevelRatio(widget.frame_point.toDouble()) >= 0.9 ? null : calculateLevelRatio(widget.frame_point.toDouble())*itemWidth ,
                right: calculateLevelRatio(widget.frame_point.toDouble()) >= 0.9 ? 0: null,
                child: itemText(widget.frame_point, formatNum!.format(widget.frame_point.abs())))
          ],
        ),
        Stack(
          children: [
            Container(
                width: itemWidth,
                height: StringFactory.padding32,
                decoration: BoxDecoration(
                  color: MyColor.white,
                  borderRadius: BorderRadius.circular(StringFactory.padding4),
                ),
                child: Row(
                  children: [
                    buildItemProgress(
                      color: MyColor.grey_BG,
                      itemWidth: itemWidth,
                      maxValue: levelI,
                      minValue: levelP,
                    ),
                    buildItemProgress(
                      color: MyColor.grey_BG,
                      itemWidth: itemWidth,
                      maxValue: levelIPlus,
                      minValue: levelI,
                    ),
                    buildItemProgress(
                      color: MyColor.bedge,
                      itemWidth: itemWidth,
                      maxValue: levelV,
                      minValue: levelIPlus,
                    ),
                    buildItemProgress(
                      color: MyColor.bedge,
                      itemWidth: itemWidth,
                      maxValue: levelVPlus,
                      minValue: levelV,
                    ),
                    buildItemProgress(
                      color: MyColor.red_bg_opacity,
                      itemWidth: itemWidth,
                      maxValue: levelOne,
                      minValue: levelVPlus,
                    ),
                    buildItemProgress(
                      color: MyColor.red_bg_opacity,
                      itemWidth: itemWidth,
                      maxValue: levelOnePlus,
                      minValue: levelOne,
                    ),
                  ],
                )),
            //animated container
            LinearPercentIndicator(
              // width: 297.77777777777777,
              width: itemWidth,
              backgroundColor: Colors.transparent,
              padding: const EdgeInsets.all(0),
              animation: true,
              lineHeight: StringFactory.padding32,
              curve: Curves.linear,
              restartAnimation: false,
              addAutomaticKeepAlive: false,
              animationDuration: 1000,
              // widgetIndicator: textCustom( text: '${widget.frame_point}', size: 12.5),
              alignment: MainAxisAlignment.start,
              percent: widget.frame_point == 0 ||
                      widget.frame_point.isBlank! ||
                      widget.frame_point == -1
                  ? 0
                  : calculateLevelRatio(widget.frame_point.toDouble()),
              // percent:0.1666666 + ( 0.1666666 * (33000/70000)),
              progressColor: MyColor.green2.withOpacity(.925),
            ),
          ],
        ),
        Container(
          width: itemWidth,
          height: StringFactory.padding32, //32
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(StringFactory.padding4),
          ),
          child: Row(
            children: [
              buildTextCol(
                  itemWidth: itemWidth,
                  level: levelPText,
                  point:detectPlatform()==false?  plevelP : plevelPShort,
                  color: MyColor.black_text),
              buildTextCol(
                  itemWidth: itemWidth,
                  level: levelIText,
                  point:detectPlatform()==false? plevelI :plevelIShort,
                  color: MyColor.black_text),
              buildTextCol(
                  itemWidth: itemWidth,
                  level: levelIPlusText,
                  point: detectPlatform()==false?plevelIPlus:plevelIPlusShort,
                  color: MyColor.black_text),
              buildTextCol(
                  itemWidth: itemWidth,
                  level:levelVText,
                  point: detectPlatform()==false?plevelV:plevelVShort,
                  color: MyColor.orange),
              buildTextCol(
                  itemWidth: itemWidth,
                  level: levelVPlusText,
                  point: detectPlatform()==false?plevelVPlus :plevelVPlusShort,
                  color: MyColor.orange),
              SizedBox(
                  width: itemWidth / 6,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textCustomNormalColor(
                              size: 13,
                              color: MyColor.red_accent,
                              fontWeight: FontWeight.bold,
                              text: levelOneText,
                            ),
                            textCustom(
                              size: 8.5,
                              text: detectPlatform()==false?plevelOne : plevelOneShort,
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            textCustomNormalColor(
                              size: 13,
                              fontWeight: FontWeight.bold,
                              color: MyColor.red_accent,
                              text: levelOnePlusText,
                            ),
                            textCustom(
                              size: 8.5,
                              text:detectPlatform()==false? plevelOnePlus : plevelOnePlusShort,
                            ),
                          ],
                        ),
                      ])),
            ],
          ),
        )
      ],
    );
  }
}

Widget buildItemProgress(
    {point_frame, itemWidth, int? minValue, int? maxValue, color}) {
  return Container(
    decoration: BoxDecoration(
      color: color,
      border: const Border(
        left: BorderSide(width: 1.5, color: MyColor.orange),
      ),
    ),
    width: (itemWidth) / 6,
  );
}

Widget buildTextCol({itemWidth, level, point, color}) {
  return SizedBox(
    width: itemWidth / 6,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        textCustomNormalColor(
          color: color,
          size: 13.5,
          fontWeight: FontWeight.bold,
          text: '$level',
        ),
        textCustom(
          size: detectPlatform()==false ?  8.5: 7.5,
          text: '$point',
        ),
      ],
    ),
  );
}
