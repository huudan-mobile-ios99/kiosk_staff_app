import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vegas_point_portal/getx/my_controller.dart';
import 'package:vegas_point_portal/service/api_service.dart';
import 'package:vegas_point_portal/util/mycolor.dart';
import 'package:vegas_point_portal/util/stringFactory.dart';
import 'package:vegas_point_portal/util/stringformat.dart';
import 'package:vegas_point_portal/widget/widget.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({
    Key? key,
  }) : super(key: key);
  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final controllerNumber = TextEditingController();
  final service = ServiceAPIs();
  final formatNum = NumberFormat();
  final myCtl = Get.put(MyGetXController());

  final format = StringFormat();
  final today = DateTime.now();

  bool valueCheckBoxEn = true;
  bool valueCheckBoxKR = false;
  bool valueCheckBoxCN = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final itemWidth = MediaQuery.of(context).size.width * 1.7 / 4;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white, //change your color here
          ),
          centerTitle: true,
          // actions: [
          //   IconButton(onPressed: () {}, icon: const Icon(Icons.search))
          // ],
          title: textCustomNormalColorFont(
              color: MyColor.white, size: 18, text: 'Settings'),
        ),
        body: Container(
            color: Colors.white,
            height: height,
            padding: const EdgeInsets.symmetric(
                horizontal: StringFactory.padding32,
                vertical: StringFactory.padding16),
            width: width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Language',
                  style: TextStyle(fontSize: 16,color: Colors.black),
                ),
                const SizedBox(
                  height: StringFactory.padding,
                ),
                Wrap(
                  children: [
                    CheckboxListTile(
																						visualDensity: VisualDensity.adaptivePlatformDensity,
                      value: valueCheckBoxEn,
                      onChanged: (value) {
                        setState(() {
                          valueCheckBoxEn = !valueCheckBoxEn;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      title: const Text('English',style: TextStyle(color: Colors.black)),
                    ),
                    CheckboxListTile(
                      value: valueCheckBoxKR,
																						visualDensity: VisualDensity.adaptivePlatformDensity,
                      onChanged: (value) {
                        setState(() {
                          valueCheckBoxKR = !valueCheckBoxKR;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                       title: const Text('Korean',style: TextStyle(color: Colors.black)),
                    ),
                    CheckboxListTile(
																						visualDensity: VisualDensity.adaptivePlatformDensity,
                      value: valueCheckBoxCN,
																						
                      onChanged: (value) {
                        setState(() {
                          valueCheckBoxCN = !valueCheckBoxCN;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      title: const Text('Chinese',style: TextStyle(color: Colors.black)),
                    ),
                  ],
                )
              ],
            )));
  }
}
