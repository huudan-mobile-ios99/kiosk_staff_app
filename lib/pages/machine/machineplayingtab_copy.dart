// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:vegas_point_portal/model/machineplaying.dart';
// import 'package:vegas_point_portal/pages/machine/bloc/machine_bloc.dart';
// import 'package:vegas_point_portal/pages/machine/item_list.dart';
// import 'package:vegas_point_portal/pages/machine/machineDetail.dart';
// import 'package:vegas_point_portal/util/mycolor.dart';
// import 'package:vegas_point_portal/util/screen_detect.dart';
// import 'package:vegas_point_portal/util/stringFactory.dart';
// import 'package:vegas_point_portal/widget/convert_number.dart';
// import 'package:vegas_point_portal/widget/myprogress_circular.dart';

// class MachinePlayingTab extends StatelessWidget {
//   final int tabIndex;
//   final BuildContext context;
//   final double width;
//   const MachinePlayingTab(
//       {Key? key,
//       required this.tabIndex,
//       required this.context,
//       required this.width})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final double width = MediaQuery.of(context).size.width;
//     final double height = MediaQuery.of(context).size.height;
//     return Container(
//         color: MyColor.white,
//         width: width,
//         height: height,
//         child: ScrollConfiguration(
//             behavior: ScrollConfiguration.of(context).copyWith(
//               physics: const BouncingScrollPhysics(),
//               dragDevices: {
//                 PointerDeviceKind.touch,
//                 PointerDeviceKind.mouse,
//                 PointerDeviceKind.trackpad
//               },
//             ),
//             child: RefreshIndicator.adaptive(
//               onRefresh: () async {
//                 context.read<MachineBloc>().add(MachineFetched());
//               },
//               child: BlocBuilder<MachineBloc, MachineState>(
//                   builder: (context, state) {
//                 switch (state.status) {
//                   case MachineStatus.initial:
//                     return Center(child: myprogress_circular_icon());
//                   case MachineStatus.failure:
//                     return const Center(child: Text('an error orcur'));
//                   case MachineStatus.success:
//                     if (state.machines.isEmpty) {
//                       return const Center(
//                           child: Text('No machine playing found'));
//                     }

//                     List<MachinePlayingModel>? machineList = [];
//                     // switch (tabIndex) {
//                     //   case 0:
//                     //     machineList = state.machines;
//                     //     break;
//                     //   case 1:
//                     //     machineList = state.machinesFilterCustomerDESC;
//                     //     break;
//                     //   case 2:
//                     //     machineList = state.machinesFilterMachineASC;
//                     //     break;
//                     //   case 3:
//                     //     machineList = state.machinesFilterMachineDESC;
//                     //     break;
//                     //   case 4:
//                     //     machineList = state.machinesWin;
//                     //     break;
//                     //   case 5:
//                     //     machineList = state.machinesLoss;
//                     //     break;
//                     // }
//                     // Determine which list to use
//                     if (state.machinesSearch.isNotEmpty) {
//                       machineList = state.machinesSearch;
//                     } else {
//                       switch (tabIndex) {
//                         case 0:
//                           machineList = state.machines;
//                           break;
//                         case 1:
//                           machineList = state.machinesFilterCustomerDESC;
//                           break;
//                         case 2:
//                           machineList = state.machinesFilterMachineASC;
//                           break;
//                         case 3:
//                           machineList = state.machinesFilterMachineDESC;
//                           break;
//                         case 4:
//                           machineList = state.machinesWin;
//                           break;
//                         case 5:
//                           machineList = state.machinesLoss;
//                           break;
//                       }
//                     }
//                     return SizedBox(
//                         width: MediaQuery.of(context).size.width,
//                         height: MediaQuery.of(context).size.height,
//                         child: GridView.builder(
//                           shrinkWrap: true,
//                           gridDelegate:
//                               SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: detectScreenWidth(
//                                 context: context,
//                                 width: MediaQuery.of(context).size.width),
//                             childAspectRatio: StringFactory.aspectRatio,
//                             crossAxisSpacing: StringFactory.padding,
//                             mainAxisSpacing: StringFactory.padding,
//                           ),
//                           itemCount: machineList.length,
//                           itemBuilder: (BuildContext context, int index) {
//                             return itemListUserBlocMachine(
//                                 onPress: () {
//                                   debugPrint('click machine playing item ${index + 1}');
//                                   showDialog(
//                                       context: context,
//                                       builder: (context) {
//                                         return AlertDialog(
//                                           elevation: 2.0,
//                                           scrollable: true,
//                                           backgroundColor: MyColor.white,
//                                           content: MachinePlayingDetail(
//                                             mcPlaying: machineList![index],
//                                             context: context,
//                                           ),
//                                           actions: [
//                                             TextButton.icon(
//                                                 icon: const Icon(
//                                                     Icons.close_outlined),
//                                                 onPressed: () {
//                                                   Navigator.of(context).pop();
//                                                 },
//                                                 label: const Text('CANCEL'))
//                                           ],
//                                         );
//                                       });
//                                 },
//                                 machine: machineList![index].machineNumber,
//                                 width: width,
//                                 winlossNumber: machineList[index].winLoss,
//                                 winloss: formatDouble(machineList[index].winLoss),
//                                 // winloss: formatDouble(machineList[index].winLoss),
//                                 number: machineList[index].number.toString(),
//                                 color: MyColor.grey_tab,
//                                 name: machineList[index].preferredName);
//                           },
//                         ));
//                 }
//               }),
//             )));
//   }
// }
