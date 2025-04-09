part of 'machine_bloc.dart';

 class MachineEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

 class MachineFetched extends MachineEvent {}
class MachineRefreshed extends MachineEvent {}

//clear all the search result
class MachineSearchCleared extends MachineEvent {}


// New event for fetching and filtering customers
class MachineFetchedFiltered extends MachineEvent {
  final String filter;
  MachineFetchedFiltered(this.filter);
  @override
  List<Object> get props => [filter];
}