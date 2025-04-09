import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegas_point_portal/pages/customerincasino/bloc/customer_bloc.dart';
import 'package:vegas_point_portal/pages/customerincasino/view/test/customer_view.dart';

class CustomerPage extends StatelessWidget {
   const CustomerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => CustomerBloc(dio: Dio())..add(CustomerFetched()),
        // create: (_) => CustomerBloc(httpClient: http.Client())..add(CustomerFetched()),
        child: const CustomerView(),
    );
  }
}
