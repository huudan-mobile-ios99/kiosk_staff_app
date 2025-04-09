import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegas_point_portal/service/api_service.dart';
import 'package:vegas_point_portal/util/mycolor.dart';
import 'package:vegas_point_portal/util/stringFactory.dart';
import 'package:vegas_point_portal/widget/myprogress_circular.dart';
import 'package:vegas_point_portal/widget/widget.dart';

import '../bloc/image_bloc.dart';

Widget itemListUserBloc(
    {width,
    name,
    String? number,
    onPress,
    color,
    String? level,
    isMCPlayer = false,
    datetime = '',
    point = '',
    bool? hasShowImage = false,
    moreInfor = false,
    activeState = false}) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(StringFactory.padding16),
        border: Border.all(  color: activeState == true ? Colors.green : Colors.transparent)),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(StringFactory.padding16),
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
                child:hasShowImage==false ? Center(child: textCustomNormalColor(text:"View",color:MyColor.blue_fb)) : BlocProvider(
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
              isMCPlayer
                  ? Text(datetime,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      style: const TextStyle(
                          fontFamily: StringFactory.mainFont,
                          color: MyColor.black_text,
                          fontSize: 11,
                          fontWeight: FontWeight.normal))
                  : moreInfor = true
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(level!,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                maxLines: 3,
                                style: TextStyle(
                                    fontFamily: StringFactory.mainFont,
                                    color: level == StringFactory.level_oneplus
                                        ? MyColor.red_accent
                                        : level == StringFactory.levelone
                                            ? MyColor.red
                                            : level == StringFactory.levelv
                                                ? MyColor.yellow3
                                                : level == StringFactory.leveli
                                                    ? MyColor.black_text
                                                    : MyColor.grey,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold)),
                            Text(point,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                maxLines: 3,
                                style: const TextStyle(
                                    fontFamily: StringFactory.mainFont,
                                    color: MyColor.black_text,
                                    fontSize: 11,
                                    fontWeight: FontWeight.normal)),
                          ],
                        )
                      : const SizedBox()
            ],
          ),
        ),
      ),
    ),
  );
}
