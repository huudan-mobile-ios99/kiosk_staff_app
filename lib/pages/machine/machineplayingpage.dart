import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegas_point_portal/pages/machine/bloc/machine_bloc.dart';
import 'package:vegas_point_portal/pages/machine/machineplayingbody.dart';

class MachinePlayingPage extends StatelessWidget {
  const MachinePlayingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
    BlocProvider(
      create: (_) => MachineBloc(dio: Dio())..add(MachineFetched()),
      child: 
      
      const MachinePlayingBody()
    );
    
  }
}


