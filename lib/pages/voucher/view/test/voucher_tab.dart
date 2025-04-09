import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:vegas_point_portal/getx/my_controller.dart';
import 'package:vegas_point_portal/util/mycolor.dart';
import 'package:vegas_point_portal/util/stringFactory.dart';
import 'package:vegas_point_portal/util/validate_field.dart';
import 'package:vegas_point_portal/widget/itemvoucher.dart';
import 'package:vegas_point_portal/widget/myprogress_circular.dart';
import 'package:vegas_point_portal/widget/searchField.dart';

import '../../../../model/vouchers_list.dart';
import '../../bloc/voucher_bloc.dart';

class VoucherTab extends StatefulWidget {
  const VoucherTab({Key? key}) : super(key: key);

  @override
  State<VoucherTab> createState() => _VoucherTabState();
}

class _VoucherTabState extends State<VoucherTab> {
  String? name;
  String? number = '';
  bool isSearch = false;
  final TextEditingController searchInputController = TextEditingController();
  final myCtl = Get.put(MyGetXController());
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      debugPrint('getx input value: ${myCtl.valueSearchInput.value}');
      if (myCtl.valueSearchInput.value == '') {}
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    // Access the VoucherBloc using BlocProvider.of<VoucherBloc>(context)
    return BlocProvider(
      create: (_) =>
          VoucherBloc(dio: Dio(), input: myCtl.valueSearchInput.value)
            ..add(VoucherFetched(myCtl.valueSearchInput.value)),
      child: DefaultTabController(
          length: 4, // Number of tabs
          child: GetBuilder<MyGetXController>(
            builder: (controller) => Scaffold(
              appBar: AppBar(
                  iconTheme: const IconThemeData(
                    color: Colors.white, //change your color here
                  ),
                  centerTitle: true,
                  actions: [
                    IconButton(
                        onPressed: () {
                          if (myCtl.isSearchVoucherInput.value == false) {
                            myCtl.turnOnVoucherSearchInput();
                          } else {
                            myCtl.turnOffVoucherSearchInput();
                          }
                        },
                        icon: const Icon(Icons.search)),
                  ],
                  title: searchTextField(
                      controller: searchInputController,
                      hasInitValue: true,
                      valueInit: controller.valueSearchInput.value,
                      hint: 'All Vouchers',
                      onSubmit: (String value) {
                        print('object $value ');
                        if (validateFieldSearch(value, context)) {
                          context
                              .read<VoucherBloc>()
                              .add(VoucherFetched(value));
                          controller.saveSearchInputValue(value);
                          controller.turnOnVouchersStatus();
                          debugPrint(
                              'value save input voucherpage: ${controller.valueSearchInput.value}');
                          if (value != controller.valueSearchInput.value) {
                            controller.turnOnVouchersStatus();
                          }
                        }
                      })),
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
                      child: const TabBarView(
                        children: [
                          VoucherListTab(
                            tabIndex: 0,
                          ),
                          VoucherListTab(
                            tabIndex: 1,
                          ),
                          VoucherListTab(
                            tabIndex: 2,
                          ),
                          VoucherListTab(
                            tabIndex: 3,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

class VoucherListTab extends StatefulWidget {
  final int tabIndex;
  const VoucherListTab({Key? key, required this.tabIndex, this.onPressed}) : super(key: key);
  final VoidCallback? onPressed;

  @override
  State<VoucherListTab> createState() => _VoucherListTabState();
}

class _VoucherListTabState extends State<VoucherListTab> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.onPressed!();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    List<Voucher> voucherList = [];
    return BlocListener<VoucherBloc, VoucherState>(
      listener: (BuildContext context, VoucherState state) {
        if (state.status == VoucherStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to fetch vouchers ')),
          );
        }
      },
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              context.read<VoucherBloc>().add(VoucherFetched('1'));
            },
            child: const Text('Fetch Vouchers'),
          ),
          Expanded(
              child: ScrollConfiguration(
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
                      context.read<VoucherBloc>().add(VoucherRefreshed());
                    },
                    child: BlocBuilder<VoucherBloc, VoucherState>(
                        builder: (context, state) {
                      switch (state.status) {
                        case VoucherStatus.initial:
                          return Center(child: myprogress_circular_icon());
                        case VoucherStatus.noinput:
                          return const Center(child: Text('no input'));
                        case VoucherStatus.failure:
                          return const Center(child: Text('an error orcur'));
                        case VoucherStatus.success:
                          if (state.vouchers.isEmpty) {
                            return const Center(child: Text('no vouchers found'));
                          }
                          switch (widget.tabIndex) {
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
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: ListView.builder(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: StringFactory.padding16,
                                      horizontal: StringFactory.padding16),
                                  itemCount: voucherList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        itemVoucher(
                                            index: index + 1,
                                            width: width,
                                            status: voucherList[index].voucherStatusData.statusCode,
                                            dateFrom: voucherList[index]
                                                .validFrom
                                                .value,
                                            dateTo: voucherList[index]
                                                .validUntil
                                                .value,
                                            voucherName: voucherList[index]
                                                .voucherName
                                                .value,
                                            voucherType: voucherList[index]
                                                .redemptionType
                                                .name),
                                        const SizedBox(
                                            height: StringFactory.padding)
                                      ],
                                    );
                                  }));
                      }
                    }),
                  ))),
        ],
      ),
    );
  }
}
