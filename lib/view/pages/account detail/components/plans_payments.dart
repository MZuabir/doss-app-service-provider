import 'package:doss/constants/colors.dart';
import 'package:doss/constants/cont.dart';
import 'package:doss/controllers/account_detail.dart';
import 'package:doss/controllers/plans_payment.dart';
import 'package:doss/services/banks.dart';
import 'package:doss/utils/size_config.dart';
import 'package:doss/view/bottom%20sheets/auth_btm_sheet.dart';
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

class AdPlansAndPaymentWidget extends StatefulWidget {
  AdPlansAndPaymentWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<AdPlansAndPaymentWidget> createState() =>
      _AdPlansAndPaymentWidgetState();
}

class _AdPlansAndPaymentWidgetState extends State<AdPlansAndPaymentWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool isExpanded = false;
  final cont = Get.find<AccountDetailCont>();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  void _toggleExpand() {
    FocusScope.of(context).unfocus();
    setState(() {
      isExpanded = !isExpanded;
      if (isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: _toggleExpand,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.darkGryClr,
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.widthMultiplier * 5,
                  vertical: SizeConfig.heightMultiplier * 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Plans and payments',
                    style: textTheme.bodyLarge,
                  ).tr(),
                  CircleAvatar(
                    radius: SizeConfig.widthMultiplier * 3,
                    backgroundColor: Colors.white12,
                    child: Icon(
                      isExpanded
                          ? Icons.arrow_drop_up_sharp
                          : Icons.arrow_drop_down,
                      color: isExpanded ? AppColors.primaryClr : Colors.grey,
                    ),
                  )
                ],
              ),
            ),
            AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return ClipRRect(
                    child: Align(
                      alignment: Alignment.topCenter,
                      heightFactor: _animationController.value,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.widthMultiplier * 5),
                        child: Obx(
                          () => Form(
                            key: cont.plansAndPaymentsFormKey,
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Container(
                                height: SizeConfig.heightMultiplier * 55,
                                child: cont.getBankDetails == null
                                    ? Center(
                                        child: CircularProgressIndicator(
                                          strokeWidth: 1.5,
                                          color: AppColors.primaryClr,
                                        ),
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
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
                                                  keyboardType:
                                                      TextInputType.number,
                                                  onChange: (val) {
                                                    if (val != null) {
                                                      if (val.contains('.')) {
                                                        cont.commercialPrice
                                                                .text =
                                                            val.replaceAll(
                                                                ".", ",");
                                                      }
                                                    }
                                                  },
                                                  onValidate: (val) {
                                                    if (val!.isEmpty) {
                                                      return tr(
                                                          "Please enter home plane price");
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
                                                  focusNode:
                                                      cont.commercialNode,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  onChange: (val) {
                                                    if (val != null) {
                                                      if (val.contains('.')) {
                                                        cont.commercialPrice
                                                                .text =
                                                            val.replaceAll(
                                                                ".", ",");
                                                      }
                                                    }
                                                  },
                                                  onValidate: (val) {
                                                    if (val!.isEmpty) {
                                                      return tr(
                                                          "Please enter commercial price");
                                                    }
                                                  },
                                                  hintText: "RS 00.00",
                                                  controller:
                                                      cont.commercialPrice,
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
                                            selectedValue:
                                                cont.selectedBank?.value == ""
                                                    ? null
                                                    : cont.selectedBank!.value,
                                            items: (cont.getBankDetails?.data
                                                        .banks ??
                                                    [])
                                                .where((Bank? bank) =>
                                                    bank?.bankStatus ==
                                                    "Active")
                                                .map((Bank? bank) {
                                              return bank?.name ?? "";
                                            }).toList(),
                                            onChanged: (String? value) {
                                              cont.selectedBank!.value =
                                                  value.toString();
                                              Bank? selectedBank = cont
                                                  .getBankDetails?.data.banks
                                                  .firstWhere(
                                                (bank) => bank.name == value,
                                                orElse: () => Bank(
                                                    id: "",
                                                    name: "",
                                                    bankStatus: ""),
                                              );
                                              cont.selectedBankId?.value =
                                                  selectedBank?.id ?? "";
                                            },
                                            title:
                                                "Details for receiving payment",
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
                                                  keyboardType:
                                                      TextInputType.number,
                                                  onValidate: (val) {
                                                    if (val!.isEmpty) {
                                                      return tr(
                                                          "Please enter Agency number");
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
                                                  keyboardType:
                                                      TextInputType.number,
                                                  onValidate: (val) {
                                                    if (val!.isEmpty) {
                                                      return tr(
                                                          "Please enter Account number");
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
                                            title: "Update",
                                            onTap: () {
                                              cont.homeNode.unfocus();
                                              cont.commercialNode.unfocus();
                                              cont.accountNode.unfocus();
                                              cont.agencyNode.unfocus();
                                              if (cont.plansAndPaymentsFormKey
                                                  .currentState!
                                                  .validate()) {
                                                if (cont.selectedBank?.value !=
                                                    "") {
                                                  cont.updateUserDetails();
                                                } else {
                                                  showTopSnackBar(
                                                    Overlay.of(context),
                                                    const CustomSnackBar.error(
                                                        message:
                                                            "Please Select Bank"),
                                                    displayDuration:
                                                        const Duration(
                                                            seconds: 1),
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
                        ),
                      ),
                    ),
                  );
                }),
          ],
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
            // await cont.postPlanPaymentData();
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
