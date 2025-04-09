import 'dart:async';
import 'package:flutter/material.dart';
import 'package:vegas_point_portal/model/hive/user_short.dart';
import 'package:vegas_point_portal/pages/home/item_list_history.dart';
import 'package:vegas_point_portal/service/hive_service.dart';
import 'package:vegas_point_portal/util/mycolor.dart';
import 'package:vegas_point_portal/widget/myprogress_circular.dart';

class HistoryPointListStream extends StatefulWidget {
  const HistoryPointListStream({Key? key}) : super(key: key);

  @override
  _HistoryPointListStreamState createState() => _HistoryPointListStreamState();
}

class _HistoryPointListStreamState extends State<HistoryPointListStream> {
  late StreamController<List<UserShort>> _userStreamController;
  late Stream<List<UserShort>> _userStream;

  @override
  void initState() {
    super.initState();
    _userStreamController = StreamController<List<UserShort>>();
    _userStream = _userStreamController.stream;
    // Initialize the stream with initial data
    _refreshUsers();
  }

  @override
  void dispose() {
    _userStreamController.close();
    super.dispose();
  }

  Future<void> _refreshUsers() async {
    try {
      final List<UserShort> users = await HiveController().getUsers();
      _userStreamController.add(users);
    } catch (e) {
      print('Error retrieving users: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: 55.0,
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(
            color: MyColor.grey_tab,
            width: .5,
          ),
        ),
      ),
      child: StreamBuilder<List<UserShort>>(
        stream: _userStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return myprogress_circular();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final List<UserShort>? userList = snapshot.data;
            if (userList == null || userList.isEmpty) {
              return const Text('No users found.');
            } else {
              return ListView.builder(
                itemCount: userList.length,
                padding: const EdgeInsets.all(0),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final user = userList[index];
                  return InkWell(
                    splashColor: MyColor.yellow_splash,
                    hoverColor: MyColor.yellow_splash,
                    onTap: () {
                      HiveController().deleteAllUsers();
                    },
                    child: itemListHistory(
                      name: user.name ?? '',
                      number: user.number.toString(),
                      datetime: user.createAt ?? '',
                    ),
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}