import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegas_point_portal/pages/customerincasino/bloc/customer_bloc.dart';
import 'package:vegas_point_portal/pages/customerincasino/view/customer_body.dart';


class CustomerPageView extends StatelessWidget {
  const CustomerPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (_) => CustomerBloc(dio: Dio())..add(CustomerFetched()),
      child: const CustomerBody()
    );
  }
}
