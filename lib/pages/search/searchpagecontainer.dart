import 'package:flutter/material.dart';
import 'package:vegas_point_portal/pages/customerincasino/view/customer_page.dart';
import 'package:vegas_point_portal/pages/machine/machineplayingpage.dart';
import 'package:vegas_point_portal/pages/search/searchpage.dart';
import 'package:vegas_point_portal/util/detect_platform.dart';
import 'package:vegas_point_portal/util/mycolor.dart';

class SearchCustomerPageContainer extends StatefulWidget {
  const SearchCustomerPageContainer({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchCustomerPageContainer> createState() =>
      _SearchCustomerPageContainerState();
}

class _SearchCustomerPageContainerState
    extends State<SearchCustomerPageContainer>
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
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: TabBar(
          dividerColor: Colors.transparent,
          automaticIndicatorColorAdjustment: false,
          onTap: (indedx) {
            if (indedx == 0) {
            } else if (indedx == 1) {
            } else if (indedx == 2) {}
          },
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: MyColor.white,
          labelStyle: const TextStyle(fontSize: 18),
          indicatorColor: Colors.transparent,
          indicatorWeight: 1,
          indicator: null, 
          // labelPadding: EdgeInsets.only(bottom: StringFactory.padding4),
          unselectedLabelColor: Colors.white70,
          tabs: <Widget>[
            Tab(child: detectPlatform() == true
                    ? const Tooltip(
                        message: 'Machine Playing',
                        child: Icon(Icons.airplay_rounded))
                    : const Text(
                        'Machine Playing',
                        style: TextStyle(fontSize: 14),
                      )),
            Tab(child: detectPlatform() == true
                    ? const Tooltip(
                        message: 'Customer In Casino', child: Icon(Icons.group))
                    : const Text(
                        'Customer In Casino',
                        style: TextStyle(fontSize: 14),
                      )),
            
            Tab(child: detectPlatform() == true
                    ? const Tooltip(
                        message: 'Search Customer', child: Icon(Icons.search))
                    : const Text(
                        'Search Customer',
                        style: TextStyle(fontSize: 14),
                      )),
          ],
          controller: tabController,
        ),
      ),
      body: SizedBox(
        height: height,
        width: width,
        child: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: tabController,
          children: const <Widget>[
            MachinePlayingPage(),
            CustomerPageView(),
            // MachinePlayerPage(),
            SearchCustomerPage(),
          ],
        ),
      ),
    );
  }
}
