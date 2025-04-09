import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegas_point_portal/pages/machine/bloc/machine_bloc.dart';
import 'package:vegas_point_portal/pages/machine/machineplayingtab.dart';
import 'package:vegas_point_portal/util/detect_platform.dart';
import 'package:vegas_point_portal/util/mycolor.dart';
import 'package:vegas_point_portal/util/stringFactory.dart';
import 'package:vegas_point_portal/widget/deboucer_textfield.dart';
import 'package:vegas_point_portal/widget/widget.dart';

class MachinePlayingBody extends StatelessWidget {
  const MachinePlayingBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final TextEditingController searchController = TextEditingController();
    final debouncer = DebouncerTextField(milliseconds: 500);

    return DefaultTabController(
      length: 6,
      child: Scaffold(
        backgroundColor: MyColor.white,
        body: Stack(
          children: [
            Container(
              color: MyColor.white,
              width: width,
              height: height,
              child: Column(
                children: [
                  const TabBar(
                    isScrollable: true,
                    dividerColor: MyColor.grey_tab,
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabAlignment: TabAlignment.start,
                    labelColor: MyColor.black_text,
                    labelStyle: TextStyle(
                        color: MyColor.black_text,
                        fontSize: StringFactory.padding12,
                        fontWeight: FontWeight.w600),
                    unselectedLabelColor: MyColor.grey,
                    indicatorColor: MyColor.yellow2,
                    tabs: [
                      Tooltip(
                        message: "Number Ascending",
                        child: Tab(
                          text: "ASC",
                        ),
                      ),
                      Tooltip(
                          message: "Number Descending",
                          child: Tab(
                            text: "DESC",
                          )),
                      Tooltip(
                          message: "Machine Ascending",
                          child: Tab(
                            text: "MC ASC",
                          )),
                      Tooltip(
                          message: "Machine Descending",
                          child: Tab(
                            text: "MC DESC",
                          )),
                      Tooltip(
                          message: "Win Ascending",
                          child: Tab(
                            text: "WIN",
                          )),
                      Tooltip(
                          message: "Loss Ascending",
                          child: Tab(
                            text: "LOSS",
                          )),
                      // Tooltip(
                      //     message: "Search Result",
                      //     child: Tab(
                      //       text: "SEARCH",
                      //     )),
                    ],
                  ),
                  // SizedBox(
                  //   height: height * .85,
                  //   width: width,
                  //   child: TabBarView(
                  //     physics: const NeverScrollableScrollPhysics(),
                  //     children: [
                  //       MachinePlayingTab(context: context, width: width, tabIndex: 0),
                  //       MachinePlayingTab(context: context, width: width, tabIndex: 1),
                  //       MachinePlayingTab(context: context, width: width, tabIndex: 2),
                  //       MachinePlayingTab(context: context, width: width, tabIndex: 3),
                  //       MachinePlayingTab(context: context, width: width, tabIndex: 4),
                  //       MachinePlayingTab(context: context, width: width, tabIndex: 5),
                  //       MachinePlayingTab(context: context, width: width, tabIndex: 6),
                  //     ],
                  //   ),
                  // ),
                  // Expanded(
                  //   child: TabBarView(
                  //     physics: const NeverScrollableScrollPhysics(),
                  //     children: List.generate(
                  //       6,
                  //       (index) => MachinePlayingTab(context: context, width: width, tabIndex: index),
                  //     ),
                  //   ),
                  // ),
                  // detectPlatform() == false ? Container() :   displaySearch(width: width,context: context,searchController: searchController,debouncer: debouncer),
                  Expanded(
                          child: TabBarView(
                            physics: const NeverScrollableScrollPhysics(),
                            children: List.generate(
                              6,
                              (index) => MachinePlayingTab(
                                context: context,
                                width: width,
                                tabIndex: index,
                                key: UniqueKey(), // Add a unique key to force rebuild
                              ),
                            ),
                          ),
                        )
                ],
              ),
            ),
            displaySearch(width: width,context: context,searchController: searchController,debouncer: debouncer)
          ],
        ),
      ),
    );
  }

  Widget displaySearch({bool? isWeb, TextEditingController? searchController,required double? width, DebouncerTextField? debouncer,BuildContext? context}){
    return   detectPlatform() == false ?  Positioned(
              top: StringFactory.padding0,
              right: StringFactory.padding0,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color:MyColor.grey_BG,
                        borderRadius: BorderRadius.circular(StringFactory.padding16)
                      ),
                      width: width! / 4,
                      child:
                      Center(
                        child: TextField(
                          controller: searchController,
                          onChanged: (value){
                            //onChanged Value
                            debouncer!.run(() {
                              if(value.isEmpty){
                                context!.read<MachineBloc>().add(MachineSearchCleared());
                              }else
                              {
                                context!.read<MachineBloc>().add(MachineFetchedFiltered(searchController!.text));
                              }
                            });
                          },
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(StringFactory.padding16),
                             borderSide: const BorderSide(
                              color: MyColor.yellow_accent
                             )
                            ),
                            enabledBorder: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(StringFactory.padding16),
                             borderSide: const BorderSide(
                              color: MyColor.grey_tab
                             )
                            ),
                            hintText: "Number/Name/Machine",
                            hintMaxLines: 1,
                            border: InputBorder.none,
                            hintStyle:  TextStyle(
                              // fontFamily: StringFactory.mainFont,
                              fontSize:detectPlatform() == false ? StringFactory.padding14 : StringFactory.padding12
                            ),
                            labelStyle:  TextStyle(
                              // fontFamily: StringFactory.mainFont,
                              fontSize:detectPlatform() == false ? StringFactory.padding14 : StringFactory.padding12
                            ),
                            suffixIcon:  IconButton(onPressed: (){
                              searchController!.clear();
                              context!.read<MachineBloc>().add(MachineSearchCleared());
                            },icon: const Icon(Icons.close),color:MyColor.black_text),
                            prefixIcon:  IconButton(onPressed: (){}, icon:const Icon(Icons.search_outlined),color:MyColor.black_text)
                          ),
                        ),
                      )
                      ),
                  const SizedBox(width: StringFactory.padding),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.refresh_rounded,color:MyColor.black_text),
                    onPressed: (){
                      debugPrint('press refresh');
                      context!.read<MachineBloc>().add(MachineFetched());
                    }, label: textCustom(text: "Refresh",size: StringFactory.padding12)),
                ],
              ),
            ) : Container();
  }
}
