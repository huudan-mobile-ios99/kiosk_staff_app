
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vegas_point_portal/pages/voucher/view/voucherbody_mobile.dart';
import '../bloc/voucher_bloc.dart';

class VoucherPageDisplayMobile extends StatelessWidget {
  const VoucherPageDisplayMobile({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
        create: (_) => VoucherBloc(dio: Dio(), input: '1')..add(VoucherFetched('1')),
        child:   const VoucherPageBodyMobile(),
      );
  }
}
