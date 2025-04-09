import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegas_point_portal/pages/customerincasino/image/bloc/image_bloc.dart';
import 'package:vegas_point_portal/service/api_service.dart';
import 'package:vegas_point_portal/util/mycolor.dart';
import 'package:vegas_point_portal/util/stringFactory.dart';
import 'package:vegas_point_portal/widget/myprogress_circular.dart';
import 'package:vegas_point_portal/widget/widget.dart';

Widget itemListUserBlocMachine(
    {width,
    name,
    required Key key,
    String? number,
    onPress,
    color,
    // String? level,
    String? machine,
    datetime = '',
    String? winloss,
    bool? hasShowImage = false,
    double? winlossNumber,
    activeState = false}) {
  return Container(
    decoration: BoxDecoration(border: Border.all(color: activeState == true ? Colors.green : Colors.transparent)),
    child: Material(
      color: MyColor.grey_tab2,
      child: InkWell(
        splashColor: MyColor.grey_tab,
        hoverColor: MyColor.grey_tab,
        onTap: () {
          onPress();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 85.0,
              height: 85.0,
              child: hasShowImage==false ? Center(child: textCustomNormalColor(text:"View",color:MyColor.blue_fb)) :  BlocProvider(
                create: (context) => ImageBloc(service: ServiceAPIs())
                ..add(ImageFetched(number!)),
                child: BlocBuilder<ImageBloc, ImageState>(
                  key: key, // Add the key here
                  builder: (context, state) {
                    if (state is ImageLoading) {
                      return myprogress_circular();
                    } else if (state is ImageLoaded) {
                      return 
                      ClipRRect(
                        borderRadius: BorderRadius.circular(StringFactory.padding4),
                        child:
                        Image.memory(
                          state.image,
                          fit: BoxFit.cover,
                        ),

                      );
                    } else {
                      return const Center(
                        child: Icon(Icons.person, color: MyColor.grey),
                      );
                    }
                  },
                ),
              ),
            ),
            Text(number!,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: const TextStyle(
                    fontFamily: StringFactory.mainFont,
                    color: MyColor.black_text,
                    fontSize: 13,
                    fontWeight: FontWeight.bold)),
            Text(name,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: const TextStyle(
                    fontFamily: StringFactory.mainFont,
                    color: MyColor.black_text,
                    fontSize: 11,
                    fontWeight: FontWeight.normal)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: StringFactory.padding,
                  height: StringFactory.padding,
                  color: winlossNumber! <0 ? MyColor.red  : MyColor.green  ,
                ),
                const SizedBox(width: StringFactory.padding4,),
                Text('\$$winloss',
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: const TextStyle(
                            fontFamily: StringFactory.mainFont,
                            color: MyColor.black_text,
                            fontSize: 12,
                            fontWeight: FontWeight.w600)),
              ],
            ),
            const Divider(color:MyColor.grey_tab),
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                // Icon(Icons.monitor),
                // const SizedBox(width: StringFactory.padding4,),
                machine == "" ? Container() : Text('🖥 $machine',
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    maxLines: 4,
                    style: const TextStyle(
                        fontFamily: StringFactory.mainFont,
                        color: MyColor.black_text,
                        fontSize: 11,
                        fontWeight: FontWeight.w600)),
               ],
             ),
                
          ],
        ),
      ),
    ),
  );
}




Widget itemListUserBlocMachineDetail(
    {width,
    name,
    String? number,
    onPress,
    color,
    // String? level,
    String? machine,
    datetime = '',
    int? totalRecord,
    
    String? winloss,
    double? winlossNumber,
    activeState = false}) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(StringFactory.padding16),
        border: Border.all(color: activeState == true ? Colors.green : Colors.transparent)),
    child: Material(
      color: MyColor.grey_tab2,
      child: InkWell(
        splashColor: MyColor.grey_tab,
        hoverColor: MyColor.grey_tab,
        onTap: () {
          onPress();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 100.0,
              height: 100.0,
              child: BlocProvider(
                create: (context) => ImageBloc(service: ServiceAPIs())
                  ..add(ImageFetched(number!)),
                child: BlocBuilder<ImageBloc, ImageState>(
                  builder: (context, state) {
                    if (state is ImageLoading) {
                      return myprogress_circular();
                    } else if (state is ImageLoaded) {
                      return 
                      ClipRRect(
                        borderRadius: BorderRadius.circular(StringFactory.padding4),
                        child:
                        Image.memory(
                          state.image,
                          fit: BoxFit.cover,
                        ),

                      );
                    } else {
                      return const Center(
                        child: Icon(Icons.person, color: MyColor.grey),
                      );
                    }
                  },
                ),
              ),
            ),
            Text(number!,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: const TextStyle(
                    fontFamily: StringFactory.mainFont,
                    color: MyColor.black_text,
                    fontSize: StringFactory.padding16,
                    fontWeight: FontWeight.bold)),
            Text(name,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: const TextStyle(
                    fontFamily: StringFactory.mainFont,
                    color: MyColor.black_text,
                    fontSize: StringFactory.padding14,
                    fontWeight: FontWeight.normal)),
            const SizedBox(height: StringFactory.padding,),
            Column(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
               crossAxisAlignment: CrossAxisAlignment.center,
               mainAxisSize: MainAxisSize.max,
               children: [
              Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: StringFactory.padding,
                  height: StringFactory.padding,
                  color: (winlossNumber!) <0 ? MyColor.red  : MyColor.green ,
                ),
                const SizedBox(width: StringFactory.padding4,),
               Text('\$$winloss ($totalRecord)' ,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: const TextStyle(
                            fontFamily: StringFactory.mainFont,
                            color: MyColor.black_text,
                            fontSize: StringFactory.padding14,
                            fontWeight: FontWeight.w600)),
              ],
            ),
                machine == '' ? const Text('') :  Wrap(
                  children: [
                    Text('🖥 #$machine',
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: const TextStyle(
                          fontFamily: StringFactory.mainFont,
                          color: MyColor.black_text,
                          fontSize: StringFactory.padding14,
                          fontWeight: FontWeight.w600)),
                  ]
                ),
               ],
             ),
            const SizedBox(height: StringFactory.padding,),
            
          ],
        ),
      ),
    ),
  );
}
