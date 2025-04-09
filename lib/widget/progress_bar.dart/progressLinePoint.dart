// import 'package:flutter/material.dart';
// import 'package:vegas_point_portal/util/mycolor.dart';
// import 'package:vegas_point_portal/util/stringFactory.dart';
// import 'package:vegas_point_portal/widget/widget.dart';

// buildProgressLine({itemWidth, point_frame}) {
//   return Column(
//     mainAxisAlignment: MainAxisAlignment.start,
//     crossAxisAlignment: CrossAxisAlignment.start,
//     mainAxisSize: MainAxisSize.min,
//     children: [
//       textCustomGrey(text: "YOUR PROGRESS ROAD MAP",size: 16),
//       // textCustomGrey(text: "YOUR PROGRESS ROAD MAP",size: 16),
//       Container(
//         width: itemWidth,
//         padding: const EdgeInsets.symmetric(vertical: StringFactory.padding4),
//         child: Stack(
//           children: [
//             Container(
//               color: MyColor.green,
//               padding: const EdgeInsets.all(StringFactory.padding2),
//               child: textCustomNormalColor(text: '11.00 PTS',color:MyColor.white,size: 11,fontWeight: FontWeight.bold),
//             )
//           ],
//         ),
//       ),
//       Container(
//           width: itemWidth,
//           height: StringFactory.padding32,
//           decoration: BoxDecoration(
//             color: MyColor.white,
//             borderRadius: BorderRadius.circular(StringFactory.padding4
// 										),
//           ),
//           child: Row(
//             children: [
//               buildItemProgress(color: MyColor.grey_BG,itemWidth: itemWidth,maxValue: 20000,minValue: 0,point_frame: point_frame,),
//               buildItemProgress(color: MyColor.grey_BG,itemWidth: itemWidth,maxValue: 70000,minValue: 20000,point_frame: point_frame,),
//               buildItemProgress(color: MyColor.bedge,itemWidth: itemWidth,maxValue: 100000,minValue: 70000,point_frame: point_frame,),
//               buildItemProgress(color: MyColor.bedge,itemWidth: itemWidth,maxValue: 220000,minValue: 100000,point_frame: point_frame,),
//               buildItemProgress(color: MyColor.red_bg_opacity,itemWidth: itemWidth,maxValue: 350000,minValue: 220000,point_frame: point_frame,),
//               buildItemProgress(color: MyColor.red_bg_opacity,itemWidth: itemWidth,maxValue: 1000000,minValue: 350000,point_frame: point_frame,),
//             ],
//           )),
//       Container(
//         width: itemWidth,
//         height: StringFactory.padding32, //32
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(StringFactory.padding4),
//         ),
//         child: Row(
//           children: [
//             buildTextCol(itemWidth: itemWidth, level: 'P', point: '0 pts',color:MyColor.black_text),
//             buildTextCol(itemWidth: itemWidth, level: 'I', point: '20,000 pts',color:MyColor.black_text),
//             buildTextCol(itemWidth: itemWidth, level: 'I+', point: '70,000 pts',color:MyColor.black_text),
//             buildTextCol(itemWidth: itemWidth, level: 'V', point: '100,000 pts',color:MyColor.orange),
//             buildTextCol(itemWidth: itemWidth, level: 'V+', point: '220,000 pts',color:MyColor.orange),
//             SizedBox(
//                 width: itemWidth / 6,
//                 child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           textCustomNormalColor(
//                             size: 13,
//                             color:MyColor.red_accent,
//                             fontWeight: FontWeight.bold,
//                             text: 'One',
//                           ),
//                           textCustom(
//                             size: 8.5,
//                             text: '350,000 pts',
//                           ),
//                         ],
//                       ),
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           textCustomNormalColor(
//                             size: 13,
//                             fontWeight: FontWeight.bold,
//                             color:MyColor.red_accent,
//                             text: 'One+',
//                           ),
//                           textCustom(
//                             size: 8.5,
//                             text: '1,000,000 pts',
//                           ),
//                         ],
//                       ),
//                     ])),
//           ],
//         ),
//       )
//     ],
//   );
// }

// Widget buildItemProgress(
//     {point_frame, itemWidth, int? minValue, int? maxValue,color}) {
//   return Container(
// 				decoration: BoxDecoration(
//           color: color,
//           border: const Border(
//               left: BorderSide(width: 1.5, color: MyColor.orange),
//             ),
//         ),
// 				width: (itemWidth)/6 ,
//     child: Stack(
//       children: [
//         Container(
//           width: point_frame >= minValue && point_frame < maxValue
//               ? itemWidth / 6 * (point_frame / maxValue)
//               : itemWidth / 6,
//           color: point_frame >= minValue && point_frame < maxValue
//               ? MyColor.green
//               : point_frame > maxValue
//                   ? MyColor.green
//                   : Colors.transparent,
//         ),
//       ],
//     ),
//   );
// }

// Widget buildTextCol({itemWidth, level, point,color}) {
//   return SizedBox(
//     width: itemWidth / 6,
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         textCustomNormalColor(
//           color:color,
//           size: 13,
//           fontWeight: FontWeight.bold,
//           text: '$level',
//         ),
//         textCustom(
//           size: 8.5,
//           text: '$point',
//         ),
//       ],
//     ),
//   );
// }


//  // static final Color grey_tab = Color(0xFFE0E0E0);
//  // static final Color grey_BG = Color(0xFFeeeeee);
