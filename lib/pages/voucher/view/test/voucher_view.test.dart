
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegas_point_portal/widget/myprogress_circular.dart';
import '../../bloc/voucher_bloc.dart'; // Ensure you import the necessary files


class VoucherView extends StatelessWidget {
  //  final TextEditingController controller;
  const VoucherView({Key? key}) : super(key: key);
  // const VoucherView({required this.controller});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VoucherBloc, VoucherState>(builder: (context, state) {
      switch (state.status) {
        case VoucherStatus.initial:
          return  Center(child: myprogress_circular_icon());
        case VoucherStatus.noinput:
          return  const Center(child: Text('no input'));
        case VoucherStatus.failure:
          return const Center(child: Text('An error orcur'));
        case VoucherStatus.success:
          if (state.vouchers.isEmpty) {
            return const Center(child: Text('no vouchers'));
          }
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              itemCount: state.vouchers.length,
              itemBuilder: (context, index) {
                return Text('${state.vouchers[index].voucherName.value} ${state.vouchers[index].cashValue.value} ${state.vouchers[index].redemptionType.name} ');
              },
            ),
          );
      }
    });
  }
}
