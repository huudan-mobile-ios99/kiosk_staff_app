import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:vegas_point_portal/model/customer.dart';
import 'package:vegas_point_portal/service/api_service.dart';
import 'package:vegas_point_portal/widget/format.dart';
import 'package:stream_transform/stream_transform.dart';
part 'user_event.dart';
part 'user_state.dart';

const throttleDuration = Duration(milliseconds: 100);
EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class UserBloc extends Bloc<UserEvent, UserState> {
  final serviceAPIs = ServiceAPIs();
  UserBloc({required this.dio, required ServiceAPIs serviceAPIs}) : super(const UserState()) {
    on<UsersFetched>(
      _onUserFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  // final http.Client httpClient;
  final Dio dio;
  final formatter = DateFormatter();

   Future<void> _onUserFetched(
    UsersFetched event,
    Emitter<UserState> emit,
  ) async {
    debugPrint('_onUserFetched user search by name');
    emit(state.copyWith(status: UserStatus.initial)); // Show loading indicator
    try {
      final CustomerList? users = await serviceAPIs.searchCustomerName(keyword: event.searchKeyword);
      debugPrint('_onUserFetched ${users!.list.length}');
      emit(
        state.copyWith(
          status: UserStatus.success,
          users: users,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: UserStatus.failure));
    }
  }
}
