import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vegas_point_portal/getx/my_controller.dart';
import 'package:vegas_point_portal/model/hive/user_short.dart';
import 'package:vegas_point_portal/pages/home/item_list_history.dart';
import 'package:vegas_point_portal/service/hive_service.dart';
import 'package:vegas_point_portal/util/mycolor.dart';
import 'package:vegas_point_portal/util/stringFactory.dart';
import 'package:vegas_point_portal/widget/image_asset.dart';
import 'package:vegas_point_portal/widget/myprogress_circular.dart';
import 'package:vegas_point_portal/widget/widget.dart';

class HistoryPointListListenner extends StatefulWidget {
  Callback? onTap;
  HistoryPointListListenner({Key? key, required this.onTap}) : super(key: key);

  @override
  _HistoryPointListListennerState createState() =>
      _HistoryPointListListennerState();
}

class _HistoryPointListListennerState extends State<HistoryPointListListenner> {
  late List<UserShort> _userList = [];
  final myCtl = Get.put(MyGetXController());

  @override
  void initState() {
    super.initState();
    _loadUserList();
    HiveController().userBox.listenable().addListener(_onBoxChange);
  }

  @override
  void dispose() {
    HiveController().userBox.listenable().removeListener(_onBoxChange);
    super.dispose();
  }

  void _onBoxChange() async {
    final userList = await HiveController().getUsers();
    setState(() {
      _userList = userList;
    });
  }

  Future<void> _loadUserList() async {
    final userList = await HiveController().getUsers();
    setState(() {
      _userList = userList;
    });
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
      child: _userList == null
          ? myprogress_circular()
          : _userList.isEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    imageAssetSmall('assets/icons/user.png'),
                    const SizedBox(
                      width: StringFactory.padding,
                    ),
                    Center(
                      child: textCustomNormalColorFont(
                        color: MyColor.black_text,
                        font: StringFactory.mainFont,
                        size: 12,
                        text: 'No search history found',
                      ),
                    )
                  ],
                )
              : ListView.builder(
                  itemCount: _userList.length,
                  padding: const EdgeInsets.all(0),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final user = _userList[index];
                    return Tooltip(
                      message: 'View ${user.number}',
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: MyColor.grey_tab,
                          hoverColor: MyColor.grey_tab,
                          onTap: () {
                            myCtl.saveNumberSearchHistory(user.number.toString());
                            widget.onTap!();
                          },
                          child: itemListHistory(
                            name: user.name ?? '',
                            number: user.number.toString(),
                            datetime: user.createAt ?? '',
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
