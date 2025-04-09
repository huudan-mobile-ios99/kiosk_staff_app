import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:vegas_point_portal/getx/my_controller.dart';
import 'package:vegas_point_portal/model/status.dart';
import 'package:vegas_point_portal/service/api_service.dart';
import 'package:vegas_point_portal/util/debouce.dart';
import 'package:vegas_point_portal/util/detect_platform.dart';
import 'package:vegas_point_portal/util/mycolor.dart';
import 'package:vegas_point_portal/util/screen_detect.dart';
import 'package:vegas_point_portal/util/stringFactory.dart';
import 'package:vegas_point_portal/util/stringformat.dart';
import 'package:vegas_point_portal/widget/image_asset.dart';
import 'package:vegas_point_portal/widget/itemListUser.dart';
import 'package:vegas_point_portal/widget/widget.dart';

import 'bloc/user_bloc.dart';

class SearchCustomerPage extends StatefulWidget {
  const SearchCustomerPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchCustomerPage> createState() => _SearchCustomerPageState();
}

class _SearchCustomerPageState extends State<SearchCustomerPage> {
  final format = StringFormat();
  final today = DateTime.now();
  Status model = Status(
      status: false,
      data: Data(
          email: '',
          phone: '',
          tiername: '',
          dateofbirth: '',
          title: '',
          preferredName: '',
          number: 0,
          loyaltyPoints: 0,
          loyaltyPointsToday: 0,
          loyaltyPointTodaySlot: 0,
          loyaltyPointTodayRLTB: 0,
          loyaltyPointsCurrent: 0,
          loyaltyPointsWeek: 0,
          loyaltyPointsMonth: 0));
  final controller = TextEditingController();
  final service = ServiceAPIs();
  final Debounce debounce = Debounce(const Duration(milliseconds: 500));
  final UserBloc userBloc = UserBloc(dio: Dio(), serviceAPIs: ServiceAPIs());

  String? keyword = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
        decoration: const BoxDecoration(
          color: MyColor.white,
        ),
        padding: const EdgeInsets.only(
            left: StringFactory.padding16,
            top: StringFactory.padding,
            right: StringFactory.padding16),
        width: width,
        height: height,
        child: Column(
          children: [
            textinputCustom(
                hasborder: false,
                textAlign: TextAlign.left,
                hintValue: 'Enter Customer Name Key',
                W: detectPlatform() == false ? width / 2 : width,
                controller: controller,
                enable: true,
                fontSize: StringFactory.padding16,
                hasCloseIcon: true,
                onchange: (String value) {
                  debounce(() {
                    setState(() {
                      keyword = value;
                      userBloc.add(UsersFetched(keyword ?? ''));
                    });
                  });
                },
                onSubmitFunc: (value) {
                  setState(() {
                    keyword = value;
                    userBloc.add(UsersFetched(keyword ?? ''));
                  });
                }),
            const SizedBox(
              height: StringFactory.padding,
            ),
            Expanded(
              child: BlocBuilder<UserBloc, UserState>(
                bloc: userBloc,
                builder: (context, state) {
                  if (state.status == UserStatus.initial) {
                    return hasErrorWidget();
                  } else if (state.status == UserStatus.failure) {
                    return hasErrorWidget();
                  } else if (state.status == UserStatus.success) {
                    final listCustomer = state.users;
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: detectScreenWidth(context: context, width: width),
                        childAspectRatio: StringFactory.aspectRatio,
                        crossAxisSpacing: StringFactory.padding,
                        mainAxisSpacing: StringFactory.padding,
                      ),
                      itemCount: listCustomer.list.length,
                      itemBuilder: (BuildContext context, int index) {
                        return itemListUser(
                          isMCPlayer: false,
                          level: '',
                          point: '',
                          moreInfor: false,
                          onPress: () {
                            debugPrint('click search');
                            final myCtl = Get.put(MyGetXController());
                            myCtl.moveToVoucher(listCustomer.list[index].number.toString());
                            myCtl.turnOnPointNumberStatus();
                          },
                          width: width / 2,
                          number: '${listCustomer.list[index].number}',
                          color: listCustomer.list[index].gender == 2
                              ? MyColor.grey
                              : MyColor.grey_tab,
                          name: listCustomer.list[index].preferredName,
                        );
                      },
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            )
          ],
        ));
  }
}

Widget hasErrorWidget() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      imageAsset('assets/icons/user2.png'),
      Center(
        child: textCustomNormalColorFont(
          color: MyColor.black_text,
          font: StringFactory.mainFont,
          size: StringFactory.padding14,
          text: 'Enter customer name keyword in search view\nClick to view points',
        ),
      )
    ],
  );
}

Widget customerProgressCircular() {
  return const Center(
      child: CircularProgressIndicator(
    color: MyColor.yellow,
    strokeWidth: 1.5,
    backgroundColor: Colors.grey,
  ));
}
