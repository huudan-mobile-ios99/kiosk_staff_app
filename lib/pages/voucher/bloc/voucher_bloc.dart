import 'package:equatable/equatable.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
// import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:stream_transform/stream_transform.dart';
import 'package:vegas_point_portal/model/vouchers_list.dart';
import 'package:vegas_point_portal/service/api_service.dart';

part 'voucher_state.dart';
part 'voucher_event.dart';

const throttleDuration = Duration(milliseconds: 100);
EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class VoucherBloc extends Bloc<VoucherEvent, VoucherState> {
  final service_api = ServiceAPIs();

  VoucherBloc({
    required this.dio,
    required this.input,
  }) : super(const VoucherState()) {
    on<VoucherFetched>(
      _onVoucherFetched,
      transformer: throttleDroppable(throttleDuration),
    );
    on<VoucherRefreshed>((event, emit) => _onVoucherRefreshed(event, emit));
  }

  // final http.Client httpClient;
  final Dio dio;
  final String input;

  Future<void> _onVoucherFetched(
    VoucherFetched event,
    Emitter<VoucherState> emit,
  ) async {
    emit(state.copyWith(
        status: VoucherStatus.initial)); // Show loading indicator
    if (event.input.isEmpty || event.input == '') {
      emit(state.copyWith(status: VoucherStatus.noinput));
      return;
    }
    try {
      final List<Voucher> vouchers =   await service_api.getVoucherList(event.input);
      // debugPrint('_onVoucherFetched ${vouchers.length} $input');
      emit(
        state.copyWith(
          status: VoucherStatus.success,
          vouchers: vouchers,
          vouchersAvailable: processVoucherFilter(vouchers, VOUCHER_AVAILABLE),
          vouchersRedeemed: processVoucherFilter(vouchers, VOUCHER_REDEEMED),
          vouchersExpired: processVoucherFilter(vouchers, VOUCHER_EXPIRED),
          input: event.input,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: VoucherStatus.failure));
    }
  }

  Future<void> _onVoucherRefreshed(
    VoucherRefreshed event,
    Emitter<VoucherState> emit,
  ) async {
    debugPrint('_onVoucherRefreshed $input');
    await _onVoucherFetched(VoucherFetched(input), emit);
  }
}

const String VOUCHER_AVAILABLE = 'OK';
const String VOUCHER_REDEEMED = 'REDEEMED';
const String VOUCHER_EXPIRED = 'EXPIRED';

List<Voucher> processVoucherFilter(List<Voucher> vouchers, String filter) {
  List<Voucher> filteredVouchers = vouchers
      .where((v) => v.voucherStatusData.statusCode.contains(filter))
      .toList();

  return filteredVouchers;
}
