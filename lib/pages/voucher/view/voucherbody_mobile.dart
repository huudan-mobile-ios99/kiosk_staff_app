import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegas_point_portal/model/vouchers_list.dart';
import 'package:vegas_point_portal/pages/voucher/bloc/voucher_bloc.dart';
import 'package:vegas_point_portal/util/mycolor.dart';
import 'package:vegas_point_portal/util/stringFactory.dart';
import 'package:vegas_point_portal/util/validate_field.dart';
import 'package:vegas_point_portal/widget/image_asset.dart';
import 'package:vegas_point_portal/widget/itemvoucher.dart';
import 'package:vegas_point_portal/widget/myprogress_circular.dart';
import 'package:vegas_point_portal/widget/mysnackbar.dart';
import 'package:vegas_point_portal/widget/widget.dart';

class VoucherPageBodyMobile extends StatefulWidget {
  const VoucherPageBodyMobile({Key? key}) : super(key: key);

  @override
  State<VoucherPageBodyMobile> createState() => _VoucherPageBodyMobileState();
}

class _VoucherPageBodyMobileState extends State<VoucherPageBodyMobile> {
  final TextEditingController searchInputController = TextEditingController();

  @override
  void dispose() {
    searchInputController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  //list will be asigned
  List<Voucher> voucherList = [];
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return DefaultTabController(
        length: 4, // Number of tabs
        child: BlocListener<VoucherBloc, VoucherState>(
                  listener: (context, state) {
                    if (state.status == VoucherStatus.failure) {
                      mysnackbarWithContext(
                          message: 'Failed to fetch vouchers',
                          context: context);
                    }
                    if (state.status == VoucherStatus.success) {
                      mysnackbarWithContext(
                          message:'Customer Vouchers ${state.input} fetched successfully',
                          context: context);
                    }
                  },
                  child: BlocBuilder<VoucherBloc, VoucherState>(
                    builder: (context, state) {
                      return Scaffold(
                        appBar: AppBar(
                            iconTheme: const IconThemeData(
                              color: Colors.white, //change your color here
                            ),
                            centerTitle: true,
                            
                            title: TextField(
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Enter Number',
                                    ),
                                    controller: searchInputController,
                                    onSubmitted: (value) {
                                      if (validateFieldSearch(value, context)) {
                                        context.read<VoucherBloc>().add(VoucherFetched(value));
                                      }
                                    },
                                  )),
                        body: Container(
                          color: MyColor.white,
                          height: height,
                          width: width,
                          child: Column(
                            children: [
                              const TabBar(
                                isScrollable: true,
                                dividerColor: MyColor.grey_tab,
                                indicatorSize: TabBarIndicatorSize.tab,
                                tabAlignment: TabAlignment.start,
                                labelColor: MyColor.black_text,
                                labelStyle: TextStyle(
                                    color: MyColor.black_text,
                                    fontSize: StringFactory.padding14,
                                    fontWeight: FontWeight.w600),
                                unselectedLabelColor: MyColor.grey,
                                indicatorColor: MyColor.yellow2,
                                tabs: [
                                  Tab(text: 'All'),
                                  Tab(text: 'Available'),
                                  Tab(text: 'Redeemed'),
                                  Tab(text: 'Expried'),
                                ],
                              ),
                              SizedBox(
                                width: width,
                                height: height * .85,
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
                  ),
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
      return Center(child: myprogress_circular_icon());
    case VoucherStatus.noinput:
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          imageAsset('assets/icons/voucher.png'),
          Center(
            child: textCustomNormalColorFont(
              color: MyColor.black_text,
              font: StringFactory.mainFont,
              size: StringFactory.padding14,
              text: 'Enter customer number in app bar to view vouchers',
            ),
          )
        ],
      );
    case VoucherStatus.failure:
      return const Center(child: Text('an error orcur'));
    case VoucherStatus.success:
      if (state.vouchers.isEmpty) {
        return const Center(child: Text('no vouchers found'));
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
              padding: const EdgeInsets.symmetric(
                  vertical: StringFactory.padding16,
                  horizontal: StringFactory.padding16),
              itemCount: voucherList.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    itemVoucher(
                        index: index + 1,
                        width: width,
                        status:
                            voucherList![index].voucherStatusData.statusCode,
                        dateFrom: voucherList[index].validFrom.value,
                        dateTo: voucherList[index].validUntil.value,
                        voucherName: voucherList[index].voucherName.value,
                        voucherType: voucherList[index].redemptionType.name),
                    const SizedBox(height: StringFactory.padding)
                  ],
                );
              }));
  }
}
