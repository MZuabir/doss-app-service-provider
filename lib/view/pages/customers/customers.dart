import 'dart:developer';
import 'package:doss/constants/cont.dart';
import 'package:doss/controllers/customers.dart';
import 'package:doss/utils/size_config.dart';
import 'package:doss/utils/spacing.dart';
import 'package:doss/view/pages/customers/pending/pending.dart';
import 'package:doss/view/widgets/background.dart';
import 'package:doss/view/widgets/custom_appbar.dart';
import 'package:doss/view/widgets/loading.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/colors.dart';
import 'canceled/canceled.dart';
import 'components/active_customer_card.dart';
import 'components/earning_card.dart';
import 'components/plan_card.dart';
import 'customers_all/customer_all.dart';
import 'active/active.dart';

class Customers extends StatefulWidget {
  const Customers({super.key});

  @override
  State<Customers> createState() => _CustomersState();
}

class _CustomersState extends State<Customers>
    with SingleTickerProviderStateMixin {
  final cont = Get.put(CustomersCont());
  static List<Tab> myTabs = <Tab>[
    Tab(
      text:tr('All'),
    ),
    Tab(text: tr('Active')),
    Tab(text: tr('Pending')),
    Tab(text: tr('Cancelled')),
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
  
    log(authCont.accessToken.value);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Background(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacing.y(7),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.widthMultiplier * 2.5),
              child: const CustomAppbar(title: "Customers"),
            ),
            Spacing.y(4),
            Obx(
              ()=> cont.isLoading.value
                  ? Center(
                      child:
                          LoadingWidget(height: SizeConfig.heightMultiplier * 80),
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.widthMultiplier * 2.5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Obx(
                                  () => ActiveCustomerCard(
                                    value: cont.activeCustomers.value,
                                  ),
                                ),
                              ),
                              Spacing.x(4),
                              Expanded(
                                child: Obx(
                                  () => Column(
                                    children: [
                                      EarningCard(
                                        title: 'Total Earning',
                                        value: cont.totalProfitEarns.value,
                                      ),
                                      Spacing.y(2),
                                      EarningCard(
                                        value: cont.totalProfitEarnsByMonth.value,
                                        title: 'Earnings in the month',
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          Spacing.y(2),
                           PlanCard(),
                          Spacing.y(2),
                          Divider(
                            thickness: 2,
                            color: AppColors.darkGryClr,
                          ),
                          Spacing.y(2),
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.darkGryClr,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 0,
                                horizontal: SizeConfig.widthMultiplier * 2),
                            child: TabBar(
                              labelPadding: EdgeInsets.zero,
                              dividerColor: Colors.transparent,
                              indicatorSize: TabBarIndicatorSize.tab,
                              
                              indicatorPadding: EdgeInsets.symmetric(
                                  vertical: SizeConfig.heightMultiplier * 0.8),
                              indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: AppColors.primaryClr),
                              indicatorColor: AppColors.primaryClr,
                              controller: _tabController,
                              labelColor: Colors.black,
                              unselectedLabelColor: Colors.white,
                              labelStyle: textTheme.bodyMedium!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: SizeConfig.textMultiplier * 1.5),
                              tabs: myTabs,
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 3),
                child: TabBarView(
                  controller: _tabController,
                  physics: const BouncingScrollPhysics(),
                  children:  [
                    AllCustomersTab(),
                    ActiveCustomersTab(),
                    PendingCustomersTab(),
                    CanceledCustomersTab(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



// Customers

