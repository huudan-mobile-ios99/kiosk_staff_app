import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vegas_point_portal/service/api_service.dart';
import 'package:vegas_point_portal/util/mycolor.dart';
import 'package:vegas_point_portal/util/stringFactory.dart';
import 'package:vegas_point_portal/util/stringformat.dart';
import 'package:vegas_point_portal/widget/itemListViewPoint.dart';
import 'package:vegas_point_portal/widget/widget.dart';

// ignore: must_be_immutable
class PointInMonth extends StatefulWidget {
  List<DateTime> listDate;
  String number;
  PointInMonth({Key? key, required this.listDate, required this.number})
      : super(key: key);

  @override
  State<PointInMonth> createState() => _PointInMonthState();
}

class _PointInMonthState extends State<PointInMonth> {
  @override
  void initState() {
    super.initState();
    // print(widget.listDate);
  }

  final format = StringFormat();
  final formatNum = NumberFormat();
  final service_api = ServiceAPIs();

  @override
  Widget build(BuildContext context) {
    final fullW = MediaQuery.of(context).size.width;
    final fullH = MediaQuery.of(context).size.height;
    return Container(
						padding: const EdgeInsets.all(StringFactory.padding),
						decoration: BoxDecoration(
							color: MyColor.grey_BG_main,
							borderRadius: BorderRadius.circular(StringFactory.padding)
						),
      width: fullW,
      height: fullH,
      
      child: ListView(
        shrinkWrap: true,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textCustom(
                    size: StringFactory.padding16,
                    text: 'POINTS DETAIL',
                  ),
                  textCustomNormal(
                    size: StringFactory.padding12,
                    text:'${format.formatDate(widget.listDate.first)} -> ${format.formatDate(widget.listDate.last)}',
                  ),
                ],
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(Icons.close, color: MyColor.red, size: StringFactory.padding24)),
            ],
          ),
          const SizedBox(height: StringFactory.padding),
          SizedBox(
            height: fullH,
            width: fullW,
            child: ListView.builder(
              padding: const EdgeInsets.all(StringFactory.padding0),
              reverse: false,
              itemCount: widget.listDate.length,
              itemBuilder: (BuildContext context, int index) {
                return itemListInMonth(
																	number:widget.number,
																				formatNum: formatNum,
																				service_api: service_api,
                    dateStart: format.formatDate(widget.listDate[index]),
                    // dateEnd: widget.listDate.last != index ?  format.formatDate(widget.listDate[index + 1])  : format.formatDate(widget.listDate.last),
                    dateDisplay:format.formatDateOnlyDayDDDateFullB(widget.listDate[index]));
              },
            ),
          ),
        ],
      ),
    );
  }

  

  getEndDateFromDateStart(DateTime startDate) {
    final DateTime endDate =
        DateTime(startDate.year, startDate.month, startDate.day + 1);
    // DateTime.now().subtract(Duration(days: 1));
    debugPrint('date end: $endDate');
    return format.formatDate(endDate);
  }
}
