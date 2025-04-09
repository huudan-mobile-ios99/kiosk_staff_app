import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/customer_bloc.dart';

class CustomerView extends StatelessWidget {
  const CustomerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerBloc, CustomerState>(builder: (context, state) {
      switch (state.status) {
        case CustomerStatus.initial:
          return const Center(child: CircularProgressIndicator());
        case CustomerStatus.failure:
          return const Center(child: Text('An error orcur'));
        case CustomerStatus.success:
          if (state.customers.isEmpty) {
            return const Center(child: Text('no customers'));
          }
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              itemCount: state.customersSortNumberAsc.length,
              itemBuilder: (context, index) {
                return Text('${state.customersSortNumberAsc[index].number} ${state.customersSortNumberAsc[index].forename} ${state.customersSortNumberAsc[index].middleName} ${state.customersSortNumberAsc[index].surname} ${state.customersSortNumberAsc[index].playerTierName}');
              },
            ),
          );
      }
    });
  }
}
