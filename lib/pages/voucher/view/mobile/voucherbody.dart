import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegas_point_portal/model/vouchers_list.dart';
import 'package:vegas_point_portal/pages/voucher/bloc/voucher_bloc.dart';
import 'package:vegas_point_portal/util/mycolor.dart';

class VcBodyMobile extends StatelessWidget {
  //list will be asigned
  TextEditingController searchInputController = TextEditingController();
  List<Voucher> voucherList = [];

  VcBodyMobile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return DefaultTabController(
        length: 4, // Number of tabs
        child: BlocBuilder<VoucherBloc, VoucherState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                  iconTheme: const IconThemeData(
                    color: Colors.blue, //change your color here
                  ),
                  title: TextField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter Number',
                    ),
                    controller: searchInputController,
                    onSubmitted: (value) {
                      context.read<VoucherBloc>().add(VoucherFetched(value));
                    },
                  )),
              body: Container(
                color: Colors.white,
                height: height,
                width: width,
                child: Column(
                  children: [
                    const TabBar(
                      isScrollable: true,
                      dividerColor: Colors.grey,
                      indicatorSize: TabBarIndicatorSize.tab,
                      tabAlignment: TabAlignment.start,
                      labelColor: Colors.black,
                      labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600),
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: MyColor.yellow_accent,
                      tabs: [
                        Tab(text: 'All'),
                        Tab(text: 'Available'),
                        Tab(text: 'Redeemed'),
                        Tab(text: 'Expried'),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          voucherRefreshWidget(
                            height: height,
                            width: width,
                            state: state,
                            context: context,
                            tabIndex: 0,
                          ),
                          voucherRefreshWidget(
                            height: height,
                            width: width,
                            state: state,
                            context: context,
                            tabIndex: 1,
                          ),
                          voucherRefreshWidget(
                            height: height,
                            width: width,
                            state: state,
                            context: context,
                            tabIndex: 2,
                          ),
                          voucherRefreshWidget(
                            height: height,
                            width: width,
                            state: state,
                            context: context,
                            tabIndex: 3,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}

Widget voucherRefreshWidget(
    {required VoucherState? state,
    required BuildContext? context,
    required int? tabIndex,
    required double? width,
    required double? height}) {
  return ScrollConfiguration(
    behavior: ScrollConfiguration.of(context!).copyWith(
      physics: const BouncingScrollPhysics(),
      dragDevices: {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad
      },
    ),
    child: RefreshIndicator.adaptive(
      onRefresh: () async {
        context.read<VoucherBloc>().add(VoucherRefreshed());
      },
      child: voucherTabBar(
          height: height,
          width: width,
          state: state,
          context: context,
          tabIndex: tabIndex),
    ),
  );
}

Widget voucherTabBar(
    {required VoucherState? state,
    required BuildContext? context,
    required int? tabIndex,
    required double? width,
    required double? height}) {
  switch (state!.status) {
    case VoucherStatus.initial:
      return const Center(child: CircularProgressIndicator());
    case VoucherStatus.noinput:
      return const Center(
          child: Text('Enter customer number in app bar to view vouchers'));
    case VoucherStatus.failure:
      return const Center(child: Text('An error orcur'));
    case VoucherStatus.success:
      if (state.vouchers.isEmpty) {
        return const Center(child: Text('No vouchers found'));
      }
      List<Voucher>? voucherList = [];
      switch (tabIndex) {
        case 0:
          voucherList = state.vouchers;
          break;
        case 1:
          voucherList = state.vouchersAvailable;
          break;
        case 2:
          voucherList = state.vouchersRedeemed;
          break;
        case 3:
          voucherList = state.vouchersExpired;
          break;
      }
      return SizedBox(
          width: width,
          height: height,
          child: ListView.builder(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              itemCount: voucherList.length,
              itemBuilder: (BuildContext context, int index) {
                return const ListTile(
                  title: Text('voucherList[index].voucherName.value'),
                );
              }));
  }
}
