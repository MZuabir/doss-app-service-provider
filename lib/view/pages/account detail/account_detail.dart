import 'package:doss/constants/cont.dart';
import 'package:doss/controllers/account_detail.dart';
import 'package:doss/utils/size_config.dart';
import 'package:doss/utils/spacing.dart';
import 'package:doss/view/pages/account%20detail/components/base_area.dart';
import 'package:doss/view/pages/account%20detail/components/plans_payments.dart';
import 'package:doss/view/pages/account%20detail/components/user_data.dart';
import 'package:doss/view/pages/auth/signup/components/base_address.dart';
import 'package:doss/view/widgets/loading.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/base_address.dart';

class AccountDetailPage extends StatelessWidget {
  AccountDetailPage({super.key});
  final cont = Get.put(AccountDetailCont());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ShowLoading(
        inAsyncCall: authCont.isLoading.value,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            title: Text('Account Detail').tr(),
          ),
          body: cont.getAccDetail == null
              ? Center(
                  child:
                      LoadingWidget(height: SizeConfig.heightMultiplier * 80),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.widthMultiplier * 3,
                        vertical: SizeConfig.heightMultiplier * 2),
                    child: Column(
                      children: [
                        AdUserDataWidget(),
                        Spacing.y(2),
                        AdBaseAddressWidget(),
                        Spacing.y(2),
                        AdBaseAreaWidget(),
                        Spacing.y(2),
                        AdPlansAndPaymentWidget()
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
