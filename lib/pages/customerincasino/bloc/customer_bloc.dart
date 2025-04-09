import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'dart:async';
// import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:stream_transform/stream_transform.dart';
import 'package:vegas_point_portal/pages/customerincasino/model/customer.model.dart';
import 'package:vegas_point_portal/service/api_service.dart';
import 'package:vegas_point_portal/util/stringFactory.dart';
import 'package:vegas_point_portal/widget/format.dart';

import '../model/customer.level.dart';

part 'customer_event.dart';
part 'customer_state.dart';

const throttleDuration = Duration(milliseconds: 100);
EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  final serviceAPIs = ServiceAPIs();
  CustomerBloc({required this.dio}) : super(const CustomerState()) {
    // CustomerBloc({required this.httpClient}) : super(const CustomerState()) {
    on<CustomerFetched>(
      _onCustomerFetched,
      transformer: throttleDroppable(throttleDuration),
    );
    on<CustomerFetchedFiltered>(
      _onCustomerFetchedFiltered,
      transformer: throttleDroppable(throttleDuration),
    );
    //customer search filter
    on<CustomerSearchFiltered>(
      _onCustomerSearchFiltered,
      transformer: throttleDroppable(throttleDuration),
    );
    on<CustomerRefreshed>(_onCustomerRefreshed);

    //customer search

    on<CustomerCleared>(
      _onCustomerCleared,
    );
  }

  // final http.Client httpClient;
  final Dio dio;
  final formatter = DateFormatter();

  Future<void> _onCustomerFetched(
    CustomerFetched event,
    Emitter<CustomerState> emit,
  ) async {
    debugPrint('onCustomerFetched Cusotmer in casino');
    emit(state.copyWith(
        status: CustomerStatus.initial)); // Show loading indicator
    try {
      final List<CustomerData> customers =
          await serviceAPIs.postCustomerInCasino(
              gammingDate: formatter.formatDate(DateTime.now()),
              computerName: StringFactory.COMPUTERNAME);
      debugPrint('_onCustomerFetched ${customers.length} ');
      emit(
        state.copyWith(
          status: CustomerStatus.success,
          customers: customers,
          customersFiltered: customers,
          customersSortNumberDesc: sortByNumber(customers, descending: true),
          customersSortNumberAsc: sortByNumber(customers, descending: false),
          customersP: processFilter(customers, levelP),
          customersI: processFilter(customers, levelI),
          customersV: processFilter(customers, levelV),
          customersONE: processFilterAbsoluteMatch(customers, levelONE),
          customersONEPLUS: processFilter(customers, levelONEPLUS),
          total: customers.length.toString(),
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: CustomerStatus.failure));
    }
  }

//machine search filter
  Future<void> _onCustomerSearchFiltered(
    CustomerSearchFiltered event,
    Emitter<CustomerState> emit,
  ) async {
    try {
      // Filter the machines based on the event's filter
      final searchResults = state.customers.where((machine) {
        final searchTerm = event.filter.toLowerCase();
        final matchesPreferredNameForeName =
            machine.forename.toLowerCase().contains(searchTerm);
        final matchesPreferredNameMiddleName =
            machine.middleName.toLowerCase().contains(searchTerm);
        final matchesPreferredNameSurName =
            machine.surname.toLowerCase().contains(searchTerm);
        final matchesNumber =
            machine.number.toString().toLowerCase().contains(searchTerm);

        return matchesPreferredNameForeName ||
            matchesPreferredNameSurName ||
            matchesPreferredNameMiddleName ||
            matchesNumber;
      }).toList();
      debugPrint('_onMachineFetchedFiltered: ${searchResults.length}');
      emit(
        state.copyWith(
          status: CustomerStatus.success,
          customersSearch: searchResults,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: CustomerStatus.failure));
    }
  }

  Future<void> _onCustomerFetchedFiltered(
    CustomerFetchedFiltered event,
    Emitter<CustomerState> emit,
  ) async {
    try {
      final List<CustomerData> customers =
          await serviceAPIs.postCustomerInCasino(
              gammingDate: formatter.formatDate(DateTime.now()),
              computerName: StringFactory.COMPUTERNAME);
      debugPrint('CustomerBloc ${customers.length}');
      final List<CustomerData> filteredCustomers =
          processFilter(customers, event.filter);
      debugPrint('CustomerBloc filtered ${filteredCustomers.length}');
      emit(
        state.copyWith(
            status: CustomerStatus.success,
            customers: customers,
            customersFiltered: filteredCustomers),
      );
    } catch (_) {
      emit(state.copyWith(status: CustomerStatus.failure));
    }
  }

  Future<void> _onCustomerRefreshed(
    CustomerRefreshed event,
    Emitter<CustomerState> emit,
  ) async {
    debugPrint('_onCustomerRefreshed');
    await _onCustomerFetched(CustomerFetched(), emit);
  }

  //clear all the machine search result
  void _onCustomerCleared(
    CustomerCleared event,
    Emitter<CustomerState> emit,
  ) {
    emit(state.copyWith(
      customersSearch: [],
      status: CustomerStatus.success, // Ensure to reset status to success
    ));
  }
}

// List<CustomerData> processFilter(List<CustomerData> customers, String filter) {
//   return customers.where((customer) => customer.number.contains(filter)).toList();
// }

List<CustomerData> processFilter(List<CustomerData> customers, String filter) {
  List<CustomerData> filteredCustomers = customers
      .where((customer) => customer.playerTierName.contains(filter))
      .toList();
  filteredCustomers
      .sort((a, b) => int.parse(a.number).compareTo(int.parse(b.number)));
  // debugPrint('processFilter: ${filteredCustomers.length}');
  return filteredCustomers;
}

List<CustomerData> processFilterAbsoluteMatch(
    List<CustomerData> customers, String filter) {
  List<CustomerData> filteredCustomers =
      customers.where((customer) => customer.playerTierName == filter).toList();
  filteredCustomers
      .sort((a, b) => int.parse(a.number).compareTo(int.parse(b.number)));
  debugPrint('processFilter: ${filteredCustomers.length}');
  return filteredCustomers;
}

List<CustomerData> sortByNumber(List<CustomerData> customers,
    {bool descending = true}) {
  customers.sort((a, b) => int.parse(a.number).compareTo(int.parse(b.number)));
  return descending ? customers.reversed.toList() : customers;
}
