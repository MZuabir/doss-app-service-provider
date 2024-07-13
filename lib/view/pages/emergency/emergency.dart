import 'package:doss/constants/cont.dart';
import 'package:doss/controllers/emergency_tab.dart';
import 'package:doss/utils/size_config.dart';
import 'package:doss/utils/spacing.dart';
import 'package:doss/view/pages/customers/customers.dart';
import 'package:doss/view/pages/emergency/emergency_customers/emergency_customers.dart';
import 'package:doss/view/pages/emergency/usefull_contacts/usefull_contacts.dart';
import 'package:doss/view/widgets/background.dart';
import 'package:doss/view/widgets/custom_appbar.dart';
import 'package:doss/view/widgets/loading.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/colors.dart';

class EmergencyTabBarPage extends StatefulWidget {
  const EmergencyTabBarPage({super.key});

  @override
  State<EmergencyTabBarPage> createState() => _EmergencyTabBarPageState();
}

class _EmergencyTabBarPageState extends State<EmergencyTabBarPage>
    with SingleTickerProviderStateMixin {
  final cont = Get.put(EmergencyTabCont());
  static List<Tab> myTabs = <Tab>[
    Tab(
      text: tr('Useful contacts'),
    ),
    Tab(text: tr('Customers')),
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Obx(
      ()=> ShowLoading(
        inAsyncCall: authCont.isLoading.value,
        child: Scaffold(
          body: Background(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.widthMultiplier * 2.5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Spacing.y(7),
                      const CustomAppbar(title: "Emergency"),
                      Spacing.y(4),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.widthMultiplier * 2),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.darkGryClr,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 0,
                              horizontal: SizeConfig.widthMultiplier * 2),
                          child: TabBar(
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicatorPadding: EdgeInsets.symmetric(
                                vertical: SizeConfig.heightMultiplier * 0.8),
                            indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: AppColors.primaryClr),
                            indicatorColor: AppColors.primaryClr,
                            controller: _tabController,
                            labelColor: Colors.black,
                            dividerColor: Colors.transparent,
                            unselectedLabelColor: Colors.white,
                            labelStyle: textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: SizeConfig.textMultiplier * 1.6),
                            tabs: myTabs,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 3),
                    child: TabBarView(
                      controller: _tabController,
                      physics: const BouncingScrollPhysics(),
                      children: [UseFullContactsTab(), EmergencyCustomersPage()],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
