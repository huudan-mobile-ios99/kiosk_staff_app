import 'package:flutter/material.dart';

Widget itemVoucherMB(
    {width,
    // long_text,
    voucherName,
    voucherType,
    // String? value,
    status,
    required index,
    String? dateFrom,
    String? dateTo}) {
  return Container(
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.shade200)),
    width: width,
    child: Padding(
      padding: const EdgeInsets.symmetric(
      horizontal: 8.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
            Text('#$index. $voucherName'),
             Text('From:${dateFrom!.replaceAll("00:00", "")}-To: ${dateTo!.replaceAll("00:00", "")}'),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  Container(
                    color: Colors.grey.shade200,
                    padding: const EdgeInsets.all(2.5),
                    child: Text('$voucherType')
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Container(
                    color: status == 'OK'
                        ? Colors.green
                        : status == "REDEEMED"
                            ? Colors.grey.shade200
                            : Colors.grey.shade200,
                    padding: const EdgeInsets.all(2.5),
                    child:Text('${status == "OK" ? "AVAILABLE" : status}',style: TextStyle(color:status == "OK" ? Colors.white:Colors.black),))
                ],
              ),
            ],
          ),
          
        ],
      ),
    ),
  );
}
