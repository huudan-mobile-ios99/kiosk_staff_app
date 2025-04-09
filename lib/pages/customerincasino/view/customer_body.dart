import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:vegas_point_portal/getx/my_controller.dart';
import 'package:vegas_point_portal/pages/machine/result_row.dart';
import 'package:vegas_point_portal/util/date_process.dart';
import 'package:vegas_point_portal/util/detect_platform.dart';
import 'package:vegas_point_portal/util/mycolor.dart';
import 'package:vegas_point_portal/util/stringFactory.dart';
import 'package:vegas_point_portal/widget/convert_number.dart';
import 'package:vegas_point_portal/widget/deboucer_textfield.dart';
import 'package:vegas_point_portal/widget/myprogress_circular.dart';
import 'package:vegas_point_portal/widget/mysnackbar.dart';
import 'package:vegas_point_portal/widget/widget.dart';

import '../../../model/hive/user_short.dart';
import '../../../service/hive_service.dart';
import '../../../util/screen_detect.dart';
import '../bloc/customer_bloc.dart';
import '../image/view/image_view.dart';
import '../model/customer.model.dart';

class CustomerBody extends StatelessWidget {
  const CustomerBody({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final TextEditingController searchController = TextEditingController();
    final debouncer = DebouncerTextField(milliseconds: 500);
    return BlocListener<CustomerBloc, CustomerState>(
        listener: (context, state) {
      if (state.status == CustomerStatus.failure) {
        mysnackbarWithContext(
            message: 'Failed to fetch customers', context: context);
      }
      if (state.status == CustomerStatus.success) {
        mysnackbarWithContext(
            message: 'Customers fetched successfully, total ${state.total}',
            context: context);
      }
    }, child:
            BlocBuilder<CustomerBloc, CustomerState>(builder: (context, state) {
      return DefaultTabController(
        length: 7, // Number of tabs
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                color: MyColor.white,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
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
                          fontSize: StringFactory.padding14,
                          fontWeight: FontWeight.w600),
                      unselectedLabelColor: MyColor.grey,
                      indicatorColor: MyColor.yellow2,
                      tabs: [
                        Tooltip(message: "All Level", child: Tab(text: 'All')),
                        Tooltip(message: "P Level", child: Tab(text: '  P  ')),
                        Tooltip(message: "I Level", child: Tab(text: '  I  ')),
                        Tooltip(message: "V Level", child: Tab(text: '  V  ')),
                        Tooltip(message: "ONE Level", child: Tab(text: 'ONE')),
                        Tooltip( message: "ONE+ Level", child: Tab(text: 'ONE+')),
                        Tooltip(
                            message: "Number Descending",
                            child: Tab(text: 'DESC')),
                      ],
                    ),
                    // detectPlatform()  ==false ? Container() : displaySearch(width: width,context:context,searchController: searchController,debouncer: debouncer,),
                    Expanded(
                      // height: height * .85,
                      // width: width,
                      child: TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          customerTab(
                              context: context, width: width, tabIndex: 0),
                          customerTab(
                              context: context, width: width, tabIndex: 1),
                          customerTab(
                              context: context, width: width, tabIndex: 2),
                          customerTab(
                              context: context, width: width, tabIndex: 3),
                          customerTab(
                              context: context, width: width, tabIndex: 4),
                          customerTab(
                              context: context, width: width, tabIndex: 5),
                          customerTab(
                              context: context, width: width, tabIndex: 6),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //search field and refresh button
              displaySearch(width: width,context:context,searchController: searchController,debouncer: debouncer,)
            ],
          ),
        ),
      );
    }));
  }

  Widget displaySearch(
      {TextEditingController? searchController,
      required double? width,
      DebouncerTextField? debouncer,
      BuildContext? context}) {
    return detectPlatform() == false
        ? Positioned(
            top: StringFactory.padding0,
            right: StringFactory.padding0,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: MyColor.grey_BG,
                        borderRadius: BorderRadius.circular(StringFactory.padding16)),
                    width:detectPlatform() == false ?  width! / 4 : width!*0.75,
                    child: Center(
                      child: TextField(
                        controller: searchController,
                        onChanged: (value) {
                          //onChanged Value
                          debouncer!.run(() {
                            if (value.isEmpty) {
                              context!
                                  .read<CustomerBloc>()
                                  .add(CustomerCleared());
                            } else {
                              context!.read<CustomerBloc>().add(
                                  CustomerSearchFiltered(
                                      searchController!.text));
                            }
                          });
                        },
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    StringFactory.padding16),
                                borderSide: const BorderSide(
                                    color: MyColor.yellow_accent)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    StringFactory.padding16),
                                borderSide:
                                    const BorderSide(color: MyColor.grey_tab)),
                            hintText: "Number/Name",
                            hintMaxLines: 1,
                            border: InputBorder.none,
                            hintStyle: const TextStyle(
                                // fontFamily: StringFactory.mainFont,
                                fontSize: StringFactory.padding14),
                            labelStyle: const TextStyle(
                                // fontFamily: StringFactory.mainFont,
                                fontSize: StringFactory.padding14),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  searchController!.clear();
                                  context!
                                      .read<CustomerBloc>()
                                      .add(CustomerCleared());
                                },
                                icon: const Icon(Icons.close),
                                color: MyColor.black_text),
                            prefixIcon: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.search_sharp),
                                color: MyColor.black_text)),
                      ),
                    )),
                const SizedBox(width: StringFactory.padding),
                ElevatedButton.icon(
                    icon: const Icon(Icons.refresh_rounded,
                        color: MyColor.black_text),
                    onPressed: () {
                      debugPrint('press refresh');
                      context!.read<CustomerBloc>().add(CustomerFetched());
                    },
                    label: textCustom( text: "Refresh", size: StringFactory.padding12)),
              ],
            ),
          )
        : Container();
  }
}

Widget customerTab(
    {required int tabIndex,
    required BuildContext context,
    required double width}) {
  return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        physics: const BouncingScrollPhysics(),
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
          PointerDeviceKind.trackpad
        },
      ),
      child: RefreshIndicator.adaptive(
        onRefresh: () async {
          context.read<CustomerBloc>().add(CustomerRefreshed());
        },
        child:
            BlocBuilder<CustomerBloc, CustomerState>(builder: (context, state) {
          switch (state.status) {
            case CustomerStatus.initial:
              return Center(child: myprogress_circular_icon());
            case CustomerStatus.failure:
              return Center(
                  child: TextButton.icon(
                label: const Text('An Error Orcur'),
                icon: const Icon(Icons.error),
                onPressed: () {},
              ));
            case CustomerStatus.success:
              if (state.customers.isEmpty) {
                return const Center(child: Text('No customers found'));
              }
              List<CustomerData>? customerList = [];
              if (state.customersSearch.isNotEmpty) {
                customerList = state.customersSearch;
              }
              // List<CustomerData>? customerList = [];
              else {
                switch (tabIndex) {
                  case 0:
                    customerList = state.customersSortNumberAsc;
                    break;
                  case 1:
                    customerList = state.customersP;
                    break;
                  case 2:
                    customerList = state.customersI;
                    break;
                  case 3:
                    customerList = state.customersV;
                    break;
                  case 4:
                    customerList = state.customersONE;
                    break;
                  case 5:
                    customerList = state.customersONEPLUS;
                    break;
                  case 6:
                    customerList = state.customersSortNumberDesc;
                    // customerList = state.customersSortNumberAsc;
                    break;
                }
              }
              return Stack(
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: detectScreenWidth(
                              context: context,
                              width: MediaQuery.of(context).size.width),
                          childAspectRatio: StringFactory.aspectRatio,
                          crossAxisSpacing: StringFactory.padding,
                          mainAxisSpacing: StringFactory.padding,
                        ),
                        itemCount: customerList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return itemListUserBloc(
                              hasShowImage: state.customersSearch.isNotEmpty
                                  ? false
                                  : true,
                              onPress: () {
                                debugPrint('click customerincasino');
                                final myCtl = Get.put(MyGetXController());
                                myCtl.moveToVoucher(customerList![index].number);
                                myCtl.turnOnPointNumberStatus();
                                HiveController().saveUser(UserShort(
                                  number: int.parse(customerList[index].number),
                                  name:'${customerList[index].surname}${customerList[index].middleName} ${customerList[index].forename}',
                                  createAt: format.formatTimeAndDate(DateTime.now()),
                                ));
                              },
                              width: width,
                              moreInfor: true,
                              level: customerList![index].playerTierName,
                              point:'${formatDouble(double.parse(customerList[index].loyaltyPointsAvailable))} pts',
                              number: customerList[index].number,
                              color: customerList[index].gender == "Female"
                                  ? MyColor.black_text
                                  : MyColor.grey_tab,
                              name:'${customerList[index].surname}${customerList[index].middleName} ${customerList[index].forename}');
                        },
                      )),
                  //show total results
                  resultRow(context: context, total: customerList.length)
                ],
              );
          }
        }),
      ));
}

// class CustomerListTab extends StatelessWidget {
//   final int tabIndex;

//   const CustomerListTab({Key? key, required this.tabIndex}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     List<CustomerData> customerList = [];
//     final double height = MediaQuery.of(context).size.height;
//     final double width = MediaQuery.of(context).size.width;
//     return ScrollConfiguration(
//         behavior: ScrollConfiguration.of(context).copyWith(
//           physics: const BouncingScrollPhysics(),
//           dragDevices: {
//             PointerDeviceKind.touch,
//             PointerDeviceKind.mouse,
//             PointerDeviceKind.trackpad
//           },
//         ),
//         child: RefreshIndicator.adaptive(
//           onRefresh: () async {
//             context.read<CustomerBloc>().add(CustomerRefreshed());
//           },
//           child: BlocBuilder<CustomerBloc, CustomerState>(
//               builder: (context, state) {
//             switch (state.status) {
//               case CustomerStatus.initial:
//                 return Center(child: myprogress_circular_icon());
//               case CustomerStatus.failure:
//                 return const Center(child: Text('an error orcur'));
//               case CustomerStatus.success:
//                 if (state.customers.isEmpty) {
//                   return const Center(child: Text('no customers found'));
//                 }
//                 switch (tabIndex) {
//                   case 0:
//                     customerList = state.customersSortNumberAsc;
//                     break;
//                   case 1:
//                     customerList = state.customersP;
//                     break;
//                   case 2:
//                     customerList = state.customersI;
//                     break;
//                   case 3:
//                     customerList = state.customersV;
//                     break;
//                   case 4:
//                     customerList = state.customersONE;
//                     break;
//                   case 5:
//                     customerList = state.customersONEPLUS;
//                     break;
//                   case 6:
//                     customerList = state.customersSortNumberDesc;
//                     break;
//                 }
//                 return SizedBox(
//                     width: MediaQuery.of(context).size.width,
//                     height: MediaQuery.of(context).size.height,
//                     child: GridView.builder(
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: detectScreenWidth(
//                             context: context,
//                             width: MediaQuery.of(context).size.width),
//                         childAspectRatio: StringFactory.aspectRatio,
//                         crossAxisSpacing: StringFactory.padding,
//                         mainAxisSpacing: StringFactory.padding,
//                       ),
//                       itemCount: customerList.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         return itemListUserBloc(
//                             onPress: () {
//                               debugPrint('click customerincasino');
//                               final myCtl = Get.put(MyGetXController());
//                               myCtl.moveToVoucher(customerList[index].number);
//                               myCtl.turnOnPointNumberStatus();
//                               HiveController().saveUser(UserShort(
//                                 number: int.parse(customerList[index].number),
//                                 name:
//                                     '${customerList[index].surname}${customerList[index].middleName} ${customerList[index].forename}',
//                                 createAt:
//                                     format.formatTimeAndDate(DateTime.now()),
//                               ));
//                             },
//                             width: width,
//                             moreInfor: true,
//                             level: customerList[index].playerTierName,
//                             point:
//                                 'pts: ${customerList[index].loyaltyPointsAvailable}',
//                             number: customerList[index].number,
//                             color: customerList[index].gender == "Female"
//                                 ? MyColor.black_text
//                                 : MyColor.grey_tab,
//                             name:
//                                 '${customerList[index].surname}${customerList[index].middleName} ${customerList[index].forename}');
//                       },
//                     ));
//             }
//           }),
//         ));
//   }
// }
