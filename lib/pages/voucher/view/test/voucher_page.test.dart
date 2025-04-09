

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/voucher_bloc.dart';
import 'voucher_view.test.dart';

class VoucherPage extends StatelessWidget {
  const VoucherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => VoucherBloc(dio: Dio(), input: '1')..add(VoucherFetched('1')),
        child:  const VoucherView(),
    );
  }
}
