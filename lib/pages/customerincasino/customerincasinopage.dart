import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vegas_point_portal/getx/my_controller.dart';
import 'package:vegas_point_portal/model/hive/user_short.dart';
import 'package:vegas_point_portal/model/status.dart';
import 'package:vegas_point_portal/service/api_service.dart';
import 'package:vegas_point_portal/service/hive_service.dart';
import 'package:vegas_point_portal/util/debouce.dart';
import 'package:vegas_point_portal/util/mycolor.dart';
import 'package:vegas_point_portal/util/screen_detect.dart';
import 'package:vegas_point_portal/util/stringFactory.dart';
import 'package:vegas_point_portal/util/stringformat.dart';
import 'package:vegas_point_portal/widget/itemListUser.dart';
import 'package:vegas_point_portal/widget/myprogress_circular.dart';
import 'package:vegas_point_portal/widget/widget.dart';
import 'dart:typed_data';

import 'model/customer.model.dart';

class CustomerInCasinoPage extends StatefulWidget {
  const CustomerInCasinoPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomerInCasinoPage> createState() => _CustomerInCasinoPageState();
}

class _CustomerInCasinoPageState extends State<CustomerInCasinoPage> {
  final format = StringFormat();
  final today = DateTime.now();
  Uint8List? _bytesImage;
  DateTime gammingDate = DateTime.now();
  String? totalCount;
  final myCtl = Get.put(MyGetXController());

  Status model = Status(
      status: false,
      data: Data(
          email: '',
          phone: '',
          tiername: '',
          title: '',
          dateofbirth: '',
          preferredName: '',
          number: 0,
          loyaltyPoints: 0,
          loyaltyPointsToday: 0,
          loyaltyPointTodaySlot: 0,
          loyaltyPointTodayRLTB: 0,
          loyaltyPointsCurrent: 0,
          loyaltyPointsWeek: 0,
          loyaltyPointsMonth: 0));
  final controller = TextEditingController();
  final service = ServiceAPIs();
  final Debounce debounce = Debounce(const Duration(milliseconds: 500));

  String? keyword = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // myCtl.backToPage();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
        decoration: const BoxDecoration(
          color: MyColor.white,
        ),
        padding: const EdgeInsets.only(
            top: StringFactory.padding16,
            left: StringFactory.padding16,
            right: StringFactory.padding16),
        width: width,
        height: height,
        child: Column(
          children: [
            Expanded(child: FutureBuilder(
              future: service.postCustomerInCasino(
                  computerName: StringFactory.COMPUTERNAME,
                  gammingDate: format.formatDate(gammingDate)),
              builder: ((context, snapshot) {
                late final listCustomer = snapshot.data as CustomerInCasino;
                if (snapshot.hasError) {
                  return Center(
                    child: textCustomNormalColorFont(
                      color: MyColor.black_text,
                      font: StringFactory.mainFont,
                      size: 14,
                      text: 'An Error Orcur',
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return myprogress_circular_icon();
                }
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: detectScreenWidth(
                        context: context,
                        width: MediaQuery.of(context).size.width),
                    childAspectRatio: StringFactory.aspectRatio,
                    crossAxisSpacing: StringFactory.padding,
                    mainAxisSpacing: StringFactory.padding,
                  ),
                  itemCount: listCustomer.customers.customerData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return itemListUser(
                        onPress: () {
                          debugPrint('click customerincasino');
                          final myCtl = Get.put(MyGetXController());
                          myCtl.moveToVoucher(listCustomer.customers.customerData[index].number);
                          myCtl.turnOnPointNumberStatus();
                          HiveController().saveUser(UserShort(
                            number:int.parse(listCustomer.customers.customerData[index].number),
                            name:'${listCustomer.customers.customerData[index].surname}${listCustomer.customers.customerData[index].middleName} ${listCustomer.customers.customerData[index].forename}',
                            createAt:format.formatTimeAndDate(DateTime.now()), 
                          ));
                        },
                        width: width,
                        moreInfor: true,
                        level: listCustomer.customers.customerData[index].playerTierName,
                        point:'pts: ${listCustomer.customers.customerData[index].loyaltyPointsAvailable}',
                        number:listCustomer.customers.customerData[index].number,
                        color:listCustomer.customers.customerData[index].gender ==
                                    "Female"
                                ? MyColor.black_text
                                : MyColor.grey_tab,
                        name:'${listCustomer.customers.customerData[index].surname}${listCustomer.customers.customerData[index].middleName} ${listCustomer.customers.customerData[index].forename}');
                  },
                );
              }),
            ))
          ],
        ));
  }

  Future selectDate({
    required BuildContext context,
  }) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: today,
        builder: (context, child) {
          return child!;
        },
        firstDate: DateTime(today.year, 1, 1),
        lastDate: DateTime(today.year, 12, 31));
    if (picked != null) {}
    return picked;
  }
}
