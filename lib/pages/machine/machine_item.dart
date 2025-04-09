import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vegas_point_portal/util/mycolor.dart';
import 'package:vegas_point_portal/util/stringFactory.dart';
import 'package:vegas_point_portal/widget/convert_number.dart';
import 'package:vegas_point_portal/widget/shakeText.dart';
import 'package:vegas_point_portal/widget/widget.dart';

// class MachineItem extends StatefulWidget {
//   final String text;
//   final String value;
//   final double width;
//   final bool hasIcon;
//   final GlobalKey shakeKey;
//   final String number;
//   final String name;
//   final VoidCallback? onPressed;
//   final bool hasShakeFunc;

//   const MachineItem({
//     Key? key,
//     required this.text,
//     required this.value,
//     required this.width,
//     this.hasIcon = false,
//     required this.shakeKey,
//     required this.number,
//     required this.name,
//     this.onPressed,
//     this.hasShakeFunc = false,
//   }) : super(key: key);

//   @override
//   State<MachineItem> createState() => _MachineItemState();
// }

// class _MachineItemState extends State<MachineItem> {
//   final ServiceAPIs serviceAPIs = ServiceAPIs();
//   final DateFormatter format = DateFormatter();
//   double totalWinLoss = 0;
//   @override
//   void initState() {
//     debugPrint('initsate machine item: ${widget.name} ${widget.number}');
//     serviceAPIs.machineWinLossDate(date: format.formatDate(DateTime.now()), number: widget.number).then((v){
//       for (MachineWinLoss element in v.list) {
//         setState(() {
//           totalWinLoss += element.winLoss;
//         });
//       }
//     });
//     super.initState();
//   }

//   @override
//   void dispose() {
//     debugPrint('dispose machine item');
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: widget.width,
//       padding: const EdgeInsets.all(StringFactory.padding),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(StringFactory.padding4),
//         border: Border.all(
//           color: MyColor.grey_tab,
//           width: 1,
//         ),
//         color: MyColor.white,
//       ),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               textCustomGrey(text: '${widget.text}', size: 16),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   widget.hasShakeFunc == true
//                       ? ShakeWidget(
//                           key: widget.shakeKey,
//                           shakeCount: 3,
//                           shakeOffset: 10,
//                           shakeDuration: const Duration(milliseconds: 550),
//                           child: textCustom(text: '${totalWinLoss}', size: 16),
//                         )
//                       : textCustom(text: '\$ ${totalWinLoss}', size: 16),
//                       // : textCustom(text: '\$ ${widget.value}', size: 16),
//                   const SizedBox(
//                     width: 15,
//                   ),
//                   widget.hasIcon == true
//                       ? InkWell(
//                           onTap: widget.onPressed,
//                           child: Container(
//                             padding:
//                                 const EdgeInsets.all(StringFactory.padding4),
//                             decoration: BoxDecoration(
//                               color: MyColor.yellow,
//                               borderRadius:
//                                   BorderRadius.circular(StringFactory.padding4),
//                             ),
//                             child: const Icon(
//                               Icons.arrow_forward_ios_rounded,
//                               color: MyColor.black_text,
//                               size: 16,
//                             ),
//                           ),
//                         )
//                       : Container(),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }




Widget machineItem(
    {text,
    required String value,
    width,
    bool? hasIcon = false,
    shakeKey,
    required String number,
    required String name,
    required String? tooltip,
    onPressed,
    bool hasShakeFunc = false}) {
  return Container(
    width: width,
    padding:  EdgeInsets.all(StringFactory.padding),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(StringFactory.padding4),
      border: Border.all(
        color: MyColor.grey_tab,
        width: 1,
      ),
      color: MyColor.white,
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            textCustomGrey(text: '$text', size: StringFactory.padding16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(width: StringFactory.padding24,height: StringFactory.padding24,
                decoration: BoxDecoration(
                  color:double.parse(value) >= 0?  MyColor.green : MyColor.red,
                  borderRadius: BorderRadius.circular(StringFactory.padding4)),
                ),
                const SizedBox(width: StringFactory.padding,),
                hasShakeFunc == true
                    ? ShakeWidget(
                        key: shakeKey,
                        shakeCount: 3,
                        shakeOffset: 10,
                        shakeDuration: const Duration(milliseconds: 550),
                        child: textCustom(text: '\$ ${formatDouble(double.parse(value))} ', size: StringFactory.padding16),
                      )
                    : textCustom(text: '\$ ${formatDouble(double.parse(value))} ', size: StringFactory.padding16),
                const SizedBox(
                  width: StringFactory.padding16,
                ),
                hasIcon == true
                    ? InkWell(
                        onTap: onPressed,
                        child: Tooltip(
                          message: tooltip,
                          child: Container(
                              padding: const EdgeInsets.all(StringFactory.padding4),
                              decoration: BoxDecoration(
                                color: MyColor.yellow,
                                borderRadius:
                                    BorderRadius.circular(StringFactory.padding4),
                              ),
                              child: const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: MyColor.black_text,
                                size: StringFactory.padding16,
                              )),
                        ),
                      )
                    : Container(),
              ],
            ),
          ],
        ),

      ],
    ),
  );
}
