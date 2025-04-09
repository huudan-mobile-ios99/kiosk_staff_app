part of 'machine_bloc.dart';

enum MachineStatus { initial, success, failure }

class MachineState extends Equatable {
  final MachineStatus status;
  final List<MachinePlayingModel> machines;
  final List<MachinePlayingModel> machinesFilterCustomerDESC;
  final List<MachinePlayingModel> machinesFilterMachineASC;
  final List<MachinePlayingModel> machinesFilterMachineDESC;
  final List<MachinePlayingModel> machinesWin;
  final List<MachinePlayingModel> machinesLoss;
  final List<MachinePlayingModel> machinesSearch;
 
  const MachineState({
    this.status = MachineStatus.initial,
    this.machines = const <MachinePlayingModel>[],
    this.machinesFilterCustomerDESC = const <MachinePlayingModel>[],
    this.machinesFilterMachineASC = const <MachinePlayingModel>[],
    this.machinesFilterMachineDESC = const <MachinePlayingModel>[],
    this.machinesWin = const <MachinePlayingModel>[],
    this.machinesLoss = const <MachinePlayingModel>[],
    this.machinesSearch = const <MachinePlayingModel>[],
    
  });

  MachineState copyWith({
    MachineStatus? status,
    List<MachinePlayingModel>? machines,
    List<MachinePlayingModel>? machinesFilterCustomerDESC,
    List<MachinePlayingModel>? machinesFilterMachineASC,
    List<MachinePlayingModel>? machinesFilterMachineDESC,
    List<MachinePlayingModel>? machinesWin,
    List<MachinePlayingModel>? machinesLoss,
    List<MachinePlayingModel>? machinesSearch,
    String? total,
  }) {
    return MachineState(
      status: status ?? this.status,
      machines: machines ?? this.machines,
      machinesFilterCustomerDESC: machinesFilterCustomerDESC ?? this.machinesFilterCustomerDESC,
      machinesFilterMachineASC: machinesFilterMachineASC ?? this.machinesFilterMachineASC,
      machinesFilterMachineDESC: machinesFilterMachineDESC ?? this.machinesFilterMachineDESC,
      machinesWin: machinesWin ?? this.machinesWin,
      machinesLoss: machinesLoss ?? this.machinesLoss,
      machinesSearch: machinesSearch ?? this.machinesSearch,
    );
  }

  //toString
  @override
  String toString() {
    return 'MachineState {status: $status, machines: ${machines.length}';
  }

  //props
  @override
  List<Object> get props => [
        status,
        machines,
        machinesFilterCustomerDESC,
        machinesFilterMachineASC,
        machinesFilterMachineDESC,
        machinesWin,
        machinesLoss,
        machinesSearch,
  ];
}
