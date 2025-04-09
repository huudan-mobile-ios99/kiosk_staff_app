
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegas_point_portal/pages/voucher/bloc/voucher_bloc.dart';
import 'package:vegas_point_portal/pages/voucher/view/mobile/voucherbody.dart';



class VCDisplayMobile extends StatelessWidget {
  const VCDisplayMobile({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
        create: (_) => VoucherBloc(dio: Dio(), input: '')..add(VoucherFetched('')),
        child:   VcBodyMobile(),
      );
  }
}
