import 'package:flutter/material.dart';
import 'package:vegas_point_portal/model/hive/user_short.dart';
import 'package:vegas_point_portal/pages/home/item_list_history.dart';
import 'package:vegas_point_portal/service/hive_service.dart';
import 'package:vegas_point_portal/util/mycolor.dart';
import 'package:vegas_point_portal/widget/myprogress_circular.dart';
import 'package:vegas_point_portal/widget/widget.dart';

class HistoryPointList extends StatelessWidget {
  const HistoryPointList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
        width: width,
        height: 55.0,
        decoration: const BoxDecoration(
          border: Border(
            left: BorderSide(
              //                   <--- left side
              color: MyColor.grey_tab,
              width: .5,
            ),
          ),
        ),
        child: FutureBuilder(
          future: HiveController().getUsers(),
          builder: (context,AsyncSnapshot<List<UserShort>> snapshot) {
            late   List<UserShort>? model = snapshot.data ;
            if (snapshot.hasError) {
              return textCustomGrey(text: 'can not retrive history search');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return myprogress_circular();
            }
            return ListView.builder(
                itemCount: snapshot.data!.length,
                padding: const EdgeInsets.all(0),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => InkWell(
                      splashColor: MyColor.yellow_splash,
                      hoverColor: MyColor.yellow_splash,
                      onTap: () {
                        HiveController().deleteAllUsers();
                      },
                      child: itemListHistory(
                          name: '${snapshot.data![index].name}',
                          number: '${snapshot.data![index].number}',
                          datetime: '${snapshot.data![index].createAt}'),
                    ));
          },
        ));
  }
}
