import 'package:flutter/material.dart';
import 'package:vegas_point_portal/model/machine_playing.dart';
import 'package:vegas_point_portal/pages/machine/item_list.dart';
import 'package:vegas_point_portal/util/detect_platform.dart';
import 'package:vegas_point_portal/util/mycolor.dart';
import 'package:vegas_point_portal/util/stringFactory.dart';
import 'package:vegas_point_portal/widget/convert_number.dart';
import 'package:vegas_point_portal/widget/format.dart';
import 'package:vegas_point_portal/widget/widget.dart';

class MachinePlayingDetail extends StatelessWidget {
  final MachinePlayingModel mcPlaying;
  final BuildContext context;

  const MachinePlayingDetail({
    Key? key,
    required this.mcPlaying,
    required this.context,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatDate = DateFormatter();
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Container(
        color: MyColor.white,
        width: detectPlatform() == false ? width / 3 : width * 0.75,
        height: detectPlatform() == false ? width / 3 : height * 0.75,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  itemListUserBlocMachineDetail(
                    onPress: () {
                      debugPrint('click detail playing');
                    },
                    machine: mcPlaying.machineNumber.join(', '),
                    width: width,
                    winlossNumber: (mcPlaying.winLoss),
                    winloss: formatDouble(mcPlaying.winLoss),
                    number: mcPlaying.number.toString(),
                    color: MyColor.grey_tab,
                    totalRecord: mcPlaying.detail.length,
                    name: mcPlaying.preferredName,
                  ),
                  const SizedBox(
                    height: StringFactory.padding,
                  ),
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1.5, color: MyColor.grey_tab),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            textCustomNormal(
                              text:
                                  '#${index + 1} | ${mcPlaying.detail[index].machineNumber}',
                              size: StringFactory.padding14,
                            ),
                            textCustomNormal(
                              text:
                                  '\$${formatDouble(mcPlaying.detail[index].winLoss)}',
                              size: StringFactory.padding14,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            textCustomNormal(
                              text: formatDate.FormatTime(
                                  mcPlaying.detail[index].sessionStartDateTime),
                              size: StringFactory.padding10,
                            ),
                            textCustomNormal(text: ' - '),
                            textCustomNormal(
                              text: formatDate.FormatTime(
                                  mcPlaying.detail[index].sessionEndDateTime),
                              size: StringFactory.padding10,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                childCount: mcPlaying.detail.length,
              ),
            ),
          ],
        ));
  }
}

class MachinePlayingDetailWithInfo extends StatelessWidget {
  final BuildContext context;
  final double totalWinLoss;
  final String name;
  final String number;
  final List<DetailMachinePlaying> listPlaying;

  const MachinePlayingDetailWithInfo({
    Key? key,
    required this.totalWinLoss,
    required this.context,
    required this.name,
    required this.number,
    required this.listPlaying,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatDate = DateFormatter();
    // final double width =   MediaQuery.of(context).size.width / 4;
    // final double height = MediaQuery.of(context).size.height / 2;
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Container(
        color: MyColor.white,
        width: detectPlatform() == false ? width / 3 : width * 0.75,
        height: detectPlatform() == false ? height / 2 : height * 0.75,
        child: SingleChildScrollView(
          child: Column(
            children: [
              itemListUserBlocMachineDetail(
                  onPress: () {
                    debugPrint('click detail playing ');
                  },
                  machine: '',
                  width: width,
                  winlossNumber: (totalWinLoss),
                  winloss: formatDouble(totalWinLoss),
                  number: number.toString(),
                  color: MyColor.grey_tab,
                  totalRecord: listPlaying.length,
                  name: name),
              const SizedBox(
                height: StringFactory.padding,
              ),
              SizedBox(
                width: width,
                height: height,
                child: ListView.builder(
                  itemCount: listPlaying.length,
                  itemBuilder: (context, index) => Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1.5, color: MyColor.grey_tab),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            textCustomNormal(
                              text:
                                  '#${index + 1} | ${listPlaying[index].machineNumber}',
                              size: StringFactory.padding14,
                            ),
                            textCustomNormal(
                              text:
                                  '\$${formatDouble(listPlaying[index].winLoss)}',
                              size: StringFactory.padding14,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            textCustomNormal(
                              text: formatDate.FormatTime(
                                  listPlaying[index].sessionStartDateTime),
                              size: StringFactory.padding10,
                            ),
                            textCustomNormal(text: ' - '),
                            textCustomNormal(
                              text: formatDate.FormatTime(
                                  listPlaying[index].sessionEndDateTime),
                              size: StringFactory.padding10,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
