import 'package:doss/controllers/customers.dart';
import 'package:doss/controllers/formatters.dart';
import 'package:doss/view/widgets/loading.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/colors.dart';
import '../../../../utils/size_config.dart';

class PlanCard extends StatelessWidget {
  PlanCard({Key? key}) : super(key: key);
  final cont = Get.find<CustomersCont>();
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
        width: SizeConfig.widthMultiplier * 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.darkGryClr,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.widthMultiplier * 5,
        ),
        child: cont.getPlans == null
            ? Center(
                child: LoadingWidget(height: SizeConfig.heightMultiplier * 20),
              )
            : ListView.builder(
                shrinkWrap: true,
                itemCount: cont.getPlans!.data!.length,
                padding: EdgeInsets.symmetric(
                    vertical: SizeConfig.heightMultiplier * 3),
                itemBuilder: (_, i) => Padding(
                  padding: EdgeInsets.only(
                      bottom: i == cont.getPlans!.data!.length - 1
                          ? 0
                          : SizeConfig.heightMultiplier * 2.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        cont.getPlans!.data![i].description!,
                        style: textTheme.bodySmall,
                      ).tr(),
                      Text(
                        "R\$ ${priceFormat.format(cont.getPlans!.data![i].price!)}",
                        style: textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ));
  }
}
