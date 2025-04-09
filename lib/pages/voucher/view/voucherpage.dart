
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:vegas_point_portal/getx/my_controller.dart';
import 'package:vegas_point_portal/pages/voucher/view/voucherbody.dart';
import '../bloc/voucher_bloc.dart';

class VoucherPageDisplay extends StatefulWidget {
  
  const VoucherPageDisplay({Key? key}) : super(key: key);

  @override
  State<VoucherPageDisplay> createState() => _VoucherPageDisplayState();
}

class _VoucherPageDisplayState extends State<VoucherPageDisplay> {

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      debugPrint('addPostFrameCallback');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyGetXController>(builder: (controller) {
      return
        BlocProvider(
        create: (_) => VoucherBloc(dio: Dio(), input: controller.searchInputValue)..add(VoucherFetched(controller.searchInputValue)),
        child:   const VoucherPageBody(),
        // child:  controller.searchInputValue == '' ?  const VoucherPageBody() : const VoucherPageBody(),
      );
    });
  }
}
