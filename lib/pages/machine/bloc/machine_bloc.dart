import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'dart:async';
// import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:stream_transform/stream_transform.dart';
import 'package:vegas_point_portal/model/machine_playing.dart';
import 'package:vegas_point_portal/service/api_service.dart';
import 'package:vegas_point_portal/widget/format.dart';

part 'machine_event.dart';
part 'machine_state.dart';

const throttleDuration = Duration(milliseconds: 100);
EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class MachineBloc extends Bloc<MachineEvent, MachineState> {
  final serviceAPIs = ServiceAPIs();
  MachineBloc({required this.dio}) : super(const MachineState()) {
    on<MachineFetched>(
      _onMachineFetch,
      transformer: throttleDroppable(throttleDuration),
    );
    //search machine
    on<MachineFetchedFiltered>(
      _onMachineFetchedFiltered,
      transformer: throttleDroppable(throttleDuration),
    );
    on<MachineSearchCleared>(
      _onMachineSearchCleared,
    );
  }

  final Dio dio;

  Future<void> _onMachineFetch(
    MachineFetched event,
    Emitter<MachineState> emit,
  ) async {
    emit(state.copyWith(
        status: MachineStatus.initial)); // Show loading indicator
    try {
      // debugPrint('_onMachineFetch');
      final formatString = DateFormatter();
      final currentDateLocal = DateTime.now().toLocal();
      // debugPrint('_onMachineFetch current date local: ${currentDateLocal} ');
      final MachinePlaingListModel machines = await serviceAPIs.machinePlayingWinLoss(
        date: formatString.formatDate(currentDateLocal),
        sortOrder: "ASC",
      );
      // Apply filters
      final machinesFilterCustomerDESC =
          List<MachinePlayingModel>.from(machines.list)
            ..sort((a, b) => b.number.compareTo(a.number));

      // final machinesFilterMachineASC = List<MachinePlayingModel>.from(machines.list)
      // ..sort((a, b) =>  int.parse(a.machineNumber.last).compareTo(int.parse(b.machineNumber.last)));
      // final machinesFilterMachineDESC = List<MachinePlayingModel>.from(machines.list)
      // ..sort((a, b) => int.parse(b.machineNumber.last).compareTo(int.parse(a.machineNumber.last)));

      final machinesFilterMachineASC =
          List<MachinePlayingModel>.from(machines.list)
            ..sort((a, b) {
              final aLastNumber = _parseLastMachineNumber(a.machineNumber);
              final bLastNumber = _parseLastMachineNumber(b.machineNumber);
              return aLastNumber.compareTo(bLastNumber);
            });

      final machinesFilterMachineDESC =
          List<MachinePlayingModel>.from(machines.list)
            ..sort((a, b) {
              final aLastNumber = _parseLastMachineNumber(a.machineNumber);
              final bLastNumber = _parseLastMachineNumber(b.machineNumber);
              return bLastNumber.compareTo(aLastNumber);
            });

      final machinesWin = machines.list
          .where((machine) => machine.winLoss >= 0)
          .toList()
        ..sort((a, b) => a.winLoss.compareTo(b.winLoss));

      final machinesLoss = machines.list
          .where((machine) => machine.winLoss < 0)
          .toList()
        ..sort((a, b) => b.winLoss.compareTo(a.winLoss)); // Ascending order
      emit(
        state.copyWith(
          status: MachineStatus.success,
          machines: machines.list,
          machinesFilterCustomerDESC: machinesFilterCustomerDESC,
          // machinesFilterMachineASC: [],
          // machinesFilterMachineDESC: [],
          machinesFilterMachineASC: machinesFilterMachineASC,
          machinesFilterMachineDESC: machinesFilterMachineDESC,
          machinesWin: machinesWin,
          machinesLoss: machinesLoss,
          total: machines.list.length.toString(),
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: MachineStatus.failure));
    }
  }

  //machine search filter
  Future<void> _onMachineFetchedFiltered(
    MachineFetchedFiltered event,
    Emitter<MachineState> emit,
  ) async {
    try {
      // Filter the machines based on the event's filter
      final searchResults = state.machines.where((machine) {
        final searchTerm = event.filter.toLowerCase();
        final matchesPreferredName =
            machine.preferredName.toLowerCase().contains(searchTerm);
        final matchesNumber =
            machine.number.toString().toLowerCase().contains(searchTerm);
        // final matchesMachineNumber = machine.machineNumber.first.toLowerCase().contains(searchTerm);
        bool matchesMachineNumber = false;
        if (machine.machineNumber.isNotEmpty) {
          final machineNumberString =
              machine.machineNumber.join(',').toLowerCase();
          matchesMachineNumber = machineNumberString.contains(searchTerm);
        }
        return matchesPreferredName || matchesNumber || matchesMachineNumber;
      }).toList();
      debugPrint('_onMachineFetchedFiltered: ${searchResults.length}');
      emit(
        state.copyWith(
          status: MachineStatus.success,
          machinesSearch: searchResults,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: MachineStatus.failure));
    }
  }

  //clear all the machine search result
  void _onMachineSearchCleared(
    MachineSearchCleared event,
    Emitter<MachineState> emit,
  ) {
    emit(state.copyWith(
      machinesSearch: [],
      status: MachineStatus.success, // Ensure to reset status to success
    ));
  }

  //parse machine number
  int _parseLastMachineNumber(List<String> machineNumbers) {
    if (machineNumbers.isEmpty) {
      return 0; // or handle this case appropriately
    }
    final lastNumber = machineNumbers.last;
    return int.tryParse(lastNumber) ?? 0; // handle parsing error
  }
}
