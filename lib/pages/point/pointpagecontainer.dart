import 'package:flutter/material.dart';
import 'package:vegas_point_portal/pages/customerincasino/view/customer_page.dart';
import 'package:vegas_point_portal/pages/machine/machineplayingpage.dart';
import 'package:vegas_point_portal/pages/search/searchpage.dart';
import 'package:vegas_point_portal/util/stringFactory.dart';
import 'package:vegas_point_portal/widget/widget.dart';

class PointPageContainer extends StatefulWidget {
  const PointPageContainer({
    Key? key,
  }) : super(key: key);

  @override
  State<PointPageContainer> createState() => _PointPageContainerState();
}

class _PointPageContainerState extends State<PointPageContainer>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: TabBar(
          onTap: (indedx) {
            if (indedx == 0) {
            } else if (indedx == 1) {
            } else if (indedx == 2) {}
          },
          indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: Colors.transparent,
          indicator:  BoxDecoration(
            border:Border.all(
              color: Colors.transparent
            ),
            color: Colors.transparent),
          indicatorWeight: 0.0,
          // labelPadding: EdgeInsets.only(bottom: StringFactory.padding4),
          unselectedLabelColor: Colors.white38,
          tabs: <Widget>[
            Tab(
              child: textCustomNormalColorFont(text: 'Customer In Casino', size: StringFactory.padding16),
            ),
            Tab(
              child:
                  textCustomNormalColorFont(text: 'Machine Playing', size: StringFactory.padding16),
            ),
            Tab(
              child: textCustomNormalColorFont(text: 'Search Customer', size: StringFactory.padding16),
            ),
          ],
          controller: tabController,
        ),
      ),
      body: SizedBox(
        height: height,
        width: width,
        child: TabBarView(
          controller: tabController,
          children: const <Widget>[
            CustomerPageView(),
            // MachinePlayerPage(),
            MachinePlayingPage(),
            SearchCustomerPage(),
          ],
        ),
      ),
    );
  }
}
