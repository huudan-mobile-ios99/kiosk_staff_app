import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vegas_point_portal/getx/my_controller.dart';
import 'package:vegas_point_portal/model/vouchers_list.dart';
import 'package:vegas_point_portal/service/api_service.dart';
import 'package:vegas_point_portal/util/mycolor.dart';
import 'package:vegas_point_portal/util/stringFactory.dart';
import 'package:vegas_point_portal/util/validate_field.dart';
import 'package:vegas_point_portal/widget/image_asset.dart';
import 'package:vegas_point_portal/widget/itemvoucher.dart';
import 'package:vegas_point_portal/widget/myprogress_circular.dart';
import 'package:vegas_point_portal/widget/searchField.dart';
import 'package:vegas_point_portal/widget/widget.dart';

class VouchersPage extends StatefulWidget {
  const VouchersPage({Key? key}) : super(key: key);

  @override
  State<VouchersPage> createState() => _VouchersPageState();
}

class _VouchersPageState extends State<VouchersPage> {
  final service_api = ServiceAPIs();
  String? name;
  String? number = '';
  bool isSearch = false;
  final searchInputController = TextEditingController();
  final myCtl = Get.put(MyGetXController());

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (myCtl.valueSearchInput.value == '') {}
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
       
        appBar: AppBar(
            iconTheme: const IconThemeData(
              color: Colors.white, //change your color here
            ),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    if (myCtl.isSearchVoucherInput.value == false) {
                      myCtl.turnOnVoucherSearchInput();
                    } else {
                      myCtl.turnOffVoucherSearchInput();
                    }
                  },
                  icon: const Icon(Icons.search)),
              // IconButton(
              //     onPressed: () {
              //       showDialog(
              //           context: context,
              //           builder: (context) {
              //             return AlertDialog();
              //           });
              //     },
              //     icon: const Icon(Icons.filter_alt))
            ],
            title: GetBuilder<MyGetXController>(
                builder: (controller) =>
                    // controller.isSearchVoucherInput.value?
                    searchTextField(
                        controller: searchInputController,
                        hasInitValue: true,
                        valueInit: controller.valueSearchInput.value,
                        hint: 'All Vouchers',
                        onSubmit: (String value) {
                          if (validateFieldSearch(value, context)) {
                            controller.saveSearchInputValue(value);
                            controller.turnOnVouchersStatus();
                            debugPrint(
                                'value save input voucherpage: ${controller.valueSearchInput.value}');
                            if (value != controller.valueSearchInput.value) {
                              controller.turnOnVouchersStatus();
                            }
                          }
                        })
                // : textCustomNormalColorFont(
                //     color: MyColor.white,
                //     size: 18,
                //     text: 'Available Vouchers'),
                )),
        body: GetBuilder<MyGetXController>(
            builder: (controller) => Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: MyColor.white,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: StringFactory.padding16,
                  ),
                  width: width,
                  height: height,
                  child: myCtl.valueSearchInput.value == ''
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            imageAsset('assets/icons/voucher.png'),
                            Center(
                              child: textCustomNormalColorFont(
                                color: MyColor.black_text,
                                font: StringFactory.mainFont,
                                size: StringFactory.padding14,
                                text:
                                    'Enter customer number in app bar to view vouchers',
                              ),
                            )
                          ],
                        )
                      : FutureBuilder(
                          future: service_api.getAllVouchers(
                            customerNumber: controller.valueSearchInput.value,
                          ),
                          builder: ((context, snapshot) {
                            print('Building with snapshot = $snapshot');
                            late final VouchersListModel model =
                                snapshot.data as VouchersListModel;

                            if (snapshot.connectionState == ConnectionState.done) {
                             
                              if (snapshot.hasError) {
                                return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  imageAsset('assets/icons/voucher.png'),
                                  Center(
                                    child: textCustomNormalColorFont(
                                      color: MyColor.black_text,
                                      font: StringFactory.mainFont,
                                      size: StringFactory.padding14,
                                      text: 'No vouchers found',
                                    ),
                                  )
                                ],
                              );
                              }
                              // return data widget
                              return  ListView.builder(
                                padding: const EdgeInsets.symmetric(vertical: StringFactory.padding16),
                                itemCount: model.vouchers.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return 
                                  Column(
                                    children: [
                                      itemVoucher(
                                          index:index+1,
                                          width: width,
                                          status: model.vouchers[index].voucherStatusData.statusCode,
                                          dateFrom: model.vouchers[index].validFrom.value,
                                          dateTo: model.vouchers[index].validUntil.value,
                                          voucherName: model.vouchers[index].voucherName.value,
                                          voucherType: model.vouchers[index].redemptionType.name
                                          ),
                                      const SizedBox(height: StringFactory.padding)
                                    ],
                                  );
                                });

                              // return loading widget while connection state is active
                            } else {
                              return myprogress_circular_icon();
                            }

                            
                          }),
                        ),
                )));
  }
}
