import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:vegas_point_portal/getx/my_controller.dart';
import 'package:vegas_point_portal/util/date_process.dart';
import 'package:vegas_point_portal/util/mycolor.dart';
import 'package:vegas_point_portal/util/stringFactory.dart';
import 'package:vegas_point_portal/widget/myprogress_circular.dart';

import '../../../model/hive/user_short.dart';
import '../../../service/hive_service.dart';
import '../../../util/screen_detect.dart';
import '../bloc/customer_bloc.dart';
import '../image/view/image_view.dart';
import '../model/customer.model.dart';

class CustomerTab extends StatelessWidget {
  const CustomerTab({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (_) => CustomerBloc(dio: Dio())..add(CustomerFetched()),
      child: DefaultTabController(
        length: 7, // Number of tabs
        child: Scaffold(
          body: Container(
            color:MyColor.white,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                const TabBar(
                  isScrollable: true,
                  dividerColor: MyColor.grey_tab,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabAlignment: TabAlignment.start,
                  labelColor: MyColor.black_text,
                  labelStyle: TextStyle(color: MyColor.black_text,fontSize: StringFactory.padding14,fontWeight: FontWeight.w600),
                  unselectedLabelColor: MyColor.grey,
                  indicatorColor: MyColor.yellow2,
                  tabs: [
                    Tab(text: 'All'),
                    Tab(text: '  P  '),
                    Tab(text: '  I  '),
                    Tab(text: '  V  '),
                    Tab(text: 'ONE'),
                    Tab(text: 'ONE+'),
                    Tab(text: 'Desc'),
                  ],
                ),
                SizedBox(
                  height: height*.85,
                  width: width,
                  child: const TabBarView(
                    // physics: NeverScrollableScrollPhysics(),
                    children: [
                      CustomerListTab(tabIndex: 0),
                      CustomerListTab(tabIndex: 1),
                      CustomerListTab(tabIndex: 2),
                      CustomerListTab(tabIndex: 3),
                      CustomerListTab(tabIndex: 4),
                      CustomerListTab(tabIndex: 5),
                      CustomerListTab(tabIndex: 6),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomerListTab extends StatelessWidget {
  final int tabIndex;
  const CustomerListTab({Key? key, required this.tabIndex}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<CustomerData> customerList = [];
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          physics: const BouncingScrollPhysics(),
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
            PointerDeviceKind.trackpad
          },
        ),
        child: RefreshIndicator.adaptive(
          onRefresh: () async {
            context.read<CustomerBloc>().add(CustomerRefreshed());
          },
          child: BlocBuilder<CustomerBloc, CustomerState>(
              builder: (context, state) {
            switch (state.status) {
              case CustomerStatus.initial:
                return  Center(child: myprogress_circular_icon());
              case CustomerStatus.failure:
                return const Center(child: Text('an error orcur'));
              case CustomerStatus.success:
                if (state.customers.isEmpty) {
                  return const Center(child: Text('no customers found'));
                }
                switch (tabIndex) {
                  case 0:
                    customerList = state.customersSortNumberAsc;
                    break;
                  case 1:
                    customerList = state.customersP;
                    break;
                  case 2:
                    customerList = state.customersI;
                    break;
                  case 3:
                    customerList = state.customersV;
                    break;
                  case 4:
                    customerList = state.customersONE;
                    break;
                  case 5:
                    customerList = state.customersONEPLUS;
                    break;
                  case 6:
                    customerList = state.customersSortNumberDesc;
                    break;
                }
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: detectScreenWidth(
                        context: context,
                        width: MediaQuery.of(context).size.width),
                    childAspectRatio: StringFactory.aspectRatio,
                    crossAxisSpacing: StringFactory.padding,
                    mainAxisSpacing: StringFactory.padding,
                  ),
                  itemCount: customerList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return itemListUserBloc(
                        onPress: () {
                          debugPrint('click customerincasino');
                          final myCtl = Get.put(MyGetXController());
                          myCtl.moveToVoucher(customerList[index].number);
                          myCtl.turnOnPointNumberStatus();
                          HiveController().saveUser(UserShort(
                            number:int.parse(customerList[index].number),
                            name:'${customerList[index].surname}${customerList[index].middleName} ${customerList[index].forename}',
                            createAt:format.formatTimeAndDate(DateTime.now()), 
                          ));
                        },
                        width: width,
                        moreInfor: true,
                        level: customerList[index].playerTierName,
                        point:'pts: ${customerList[index].loyaltyPointsAvailable}',
                        number:customerList[index].number,
                        color:customerList[index].gender == "Female"
                                ? MyColor.black_text
                                : MyColor.grey_tab,
                        name:'${customerList[index].surname}${customerList[index].middleName} ${customerList[index].forename}');
                  },
                )
                
                );
            }
          }),
        ));
  }
}
