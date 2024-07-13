import 'package:doss/constants/colors.dart';
import 'package:doss/constants/cont.dart';
import 'package:doss/controllers/plans_payment.dart';
import 'package:doss/services/banks.dart';
import 'package:doss/utils/size_config.dart';
import 'package:doss/view/pages/bottomnav/bottom_nav_bar.dart';
import 'package:doss/view/widgets/auth_textfield.dart';
import 'package:doss/view/widgets/custom_button.dart';
import 'package:doss/view/widgets/custom_drop_down.dart';
import 'package:doss/view/widgets/loading.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../../../../constants/icons.dart';
import '../../../../../models/bank.dart';
import '../../../../../utils/spacing.dart';
import '../../../../bottom sheets/auth_btm_sheet.dart';
import '../../../../widgets/custom_snackbar.dart';

class PlansAndPayment extends StatefulWidget {
  PlansAndPayment({
    Key? key,
    this.isEdit = false,
  }) : super(key: key);
  final bool isEdit;

  @override
  State<PlansAndPayment> createState() => _PlansAndPaymentState();
}

class _PlansAndPaymentState extends State<PlansAndPayment> {
  final cont = Get.put(PlanPaymentCont());

  @override
  void initState() {
    Future.delayed(Duration.zero,
        () async => cont.banks.value = await BanksService.getBanks());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Obx(
      () => Form(
        key: cont.formKey,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            height: SizeConfig.heightMultiplier * 80,
            child: cont.getBankDetails == null
                ? Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 1.5,
                      color: AppColors.primaryClr,
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Plans and payments",
                        style: textTheme.headlineMedium,
                      ).tr(),
                      Spacing.y(3),
                      Text(
                        "How much do you want to charge your future customers monthly?",
                        style: textTheme.bodySmall,
                      ).tr(),
                      Spacing.y(3),
                      Row(
                        children: [
                          Expanded(
                            child: AuthTextField(
                              focusNode: cont.homeNode,
                              keyboardType: TextInputType.number,
                              onValidate: (val) {
                                if (val!.isEmpty) {
                                  return tr("Please enter home plane price");
                                }
                              },
                              hintText: "RS 00.00",
                              controller: cont.homePrice,
                              title: "Home Plan",
                            ),
                          ),
                          Spacing.x(3),
                          Expanded(
                            child: AuthTextField(
                              focusNode: cont.commercialNode,
                              keyboardType: TextInputType.number,
                              onValidate: (val) {
                                if (val!.isEmpty) {
                                  return tr("Please enter commercial price");
                                }
                              },
                              hintText: "RS 00.00",
                              controller: cont.commercialPrice,
                              title: "Commercial Plan",
                            ),
                          ),
                        ],
                      ),

                      //  CustomDropdown(
                      //   selectedValue: cont.selectedPlan?.value == "" ? null : cont.selectedPlan!.value,
                      //   // items: ["xn m","ksdnck","jsn"],
                      //   items: (cont.getBankDetails?.data.banks ?? []).map((Bank? bank) {
                      //     return bank?.name ?? "";// Provide a default value if bank is null
                      //
                      //   }).toList(),
                      //   onChanged: (String? value)  {
                      //     cont.selectedPlan!.value="";
                      //     cont.selectedPlan!.value = value.toString();
                      //     print(cont.selectedPlan!.value);
                      //   },
                      //   title: "Details for receiving payment",
                      //   hint: cont.selectedPlan?.value == "" ? "Select Bank" : cont.selectedPlan!.value,
                      // ),
                      // CustomDropdown(
                      //   selectedValue: cont.selectedPlan?.value == "" ? null : cont.selectedPlan!.value,
                      //   items: (cont.getBankDetails?.data.banks ?? [])
                      //       .where((Bank? bank) => bank?.bankStatus == "Active")
                      //       .map((Bank? bank) {
                      //     return bank?.name ?? ""; // Provide a default value if bank is null
                      //   }).toList(),
                      //   onChanged: (String? value) {
                      //     cont.selectedPlan!.value = value.toString();
                      //     print(cont.selectedPlan!.value);
                      //   },
                      //   title: "Details for receiving payment",
                      //   hint: cont.selectedPlan?.value == "" ? "Select Bank" : cont.selectedPlan!.value,
                      // ),
                      CustomDropdown(
                        selectedValue: cont.selectedBank?.value == ""
                            ? null
                            : cont.selectedBank!.value,
                        items: (cont.getBankDetails?.data.banks ?? [])
                            .where((Bank? bank) => bank?.bankStatus == "Active")
                            .map((Bank? bank) {
                          return bank?.name ?? "";
                        }).toList(),
                        onChanged: (String? value) {
                          cont.selectedBank!.value = value.toString();
                          Bank? selectedBank =
                              cont.getBankDetails?.data.banks.firstWhere(
                            (bank) => bank.name == value,
                            orElse: () =>
                                Bank(id: "", name: "", bankStatus: ""),
                          );
                          cont.selectedBankId?.value = selectedBank?.id ?? "";
                        },
                        title: "Details for receiving payment",
                        hint: cont.selectedBank?.value == ""
                            ? "Select Bank"
                            : cont.selectedBank!.value,
                      ),
                      Spacing.y(2),
                      Row(
                        children: [
                          Expanded(
                            child: AuthTextField(
                              focusNode: cont.agencyNode,
                              keyboardType: TextInputType.number,
                              onValidate: (val) {
                                if (val!.isEmpty) {
                                  return tr("Please enter Agency number");
                                }
                              },
                              hintText: "Agency",
                              controller: cont.agency,
                              isTitle: false,
                            ),
                          ),
                          Spacing.x(3),
                          Expanded(
                            child: AuthTextField(
                              focusNode: cont.accountNode,
                              keyboardType: TextInputType.number,
                              onValidate: (val) {
                                if (val!.isEmpty) {
                                  return tr("Please enter Account number");
                                }
                              },
                              hintText: "Account",
                              controller: cont.account,
                              isTitle: false,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      CustomButton(
                        title: "Next",
                        onTap: () {
                          cont.homeNode.unfocus();
                          cont.commercialNode.unfocus();
                          cont.accountNode.unfocus();
                          cont.agencyNode.unfocus();
                          if (cont.formKey.currentState!.validate()) {
                            if (cont.selectedBank?.value != "") {
                              _showBottomSheet(context);
                            } else {
                              showTopSnackBar(
                                Overlay.of(context),
                                const CustomSnackBar.error(
                                    message: "Please Select Bank"),
                                displayDuration: const Duration(seconds: 1),
                              );
                            }
                          }
                        },
                      ),
                      Spacing.y(3),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return AuthBottomSheet(
          icon: AppIcons.verify,
          onTap: () async {
            await cont.postPlanPaymentData();
            Get.back();
          },
          btnTitle: 'Proceed to the app',
          title: 'Congratulations!',
          description:
              'Your registration has been completed and approved successfully!Enjoy the benefits of the app and find customers closest to you!',
        ); // Use the separate BottomSheet widget
      },
    );
  }
}
