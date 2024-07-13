import 'dart:developer';

import 'package:doss/constants/colors.dart';
import 'package:doss/constants/cont.dart';
import 'package:doss/controllers/base_address.dart';
import 'package:doss/controllers/sign_up.dart';
import 'package:doss/utils/size_config.dart';
import 'package:doss/view/bottom%20sheets/auth_btm_sheet.dart';
import 'package:doss/view/widgets/loading.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../../../constants/icons.dart';
import '../../../../../utils/spacing.dart';
import '../../../../widgets/auth_textfield.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_drop_down.dart';
import '../../../../widgets/custom_snackbar.dart';

class BaseAddressPage extends StatefulWidget {
  const BaseAddressPage({
    Key? key,
     this.isEdit=false,
  }) : super(key: key);
  final bool isEdit;
  @override
  State<BaseAddressPage> createState() => _BaseAddressPageState();
}

class _BaseAddressPageState extends State<BaseAddressPage> {
  final cont = Get.put(BaseAddressCont());
  unFocusNodes() {}

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Form(
      key: cont.formKey,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Base address",
              style: textTheme.headlineMedium,
            ).tr(),
            Spacing.y(3),
            Stack(
              alignment: Alignment.center,
              children: [
                AuthTextField(
                  focusNode: cont.zipCodeNode,
                  formatter: [MaskTextInputFormatter(mask: "#####-###")],
                  onChange: (val) {
                    if (val?.length == 9) {
                      print(val);
                      cont.checkZipCode(val!);
                    } else {
                      cont.state.clear();
                      cont.city.clear();
                      cont.street.clear();
                      cont.complement.clear();
                      cont.country.clear();
                    }
                  },
                  onSubmit: (val) => cont.checkZipCode(val),
                  onValidate: (val) {
                    if (val == null || val.isEmpty) {
                      return tr("Please enter your Zip code");
                    }

                    // Check if the value matches the Brazilian zip code format
                  },
                  title: "Zip Code",
                  hintText: "13100-474",
                  controller: cont.zipCode,
                  keyboardType: const TextInputType.numberWithOptions(
                      signed: true, decimal: true),
                ),
                Obx(
                  () => cont.isCheckingZipCode.value
                      ? Positioned(
                          right: SizeConfig.widthMultiplier * 5,
                          top: SizeConfig.heightMultiplier *5.5,
                          child: SizedBox(
                              height: 25,
                              width: 25,
                              child: Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColors.darkGryClr,
                                ),
                              )),
                        )
                      : const SizedBox(),
                )
              ],
            ),
            AuthTextField(
              isEnable: false,
              focusNode: cont.countryNode,
              title: "Country",
              hintText: "Brazil",
              controller: cont.country,
            ),
            AuthTextField(
              isEnable: false,
              title: "State",
              hintText: "São Paulo estado",
              controller: cont.state,
            ),
            AuthTextField(
              isEnable: false,
              focusNode: cont.cityNode,
              title: "City",
              hintText: "Sao Paulo",
              controller: cont.city,
            ),
            AuthTextField(
              isEnable: false,
              focusNode: cont.streetNode,
              title: "Road",
              hintText: "xyz",
              controller: cont.street,
            ),
            AuthTextField(
              // isEnable: false,
              title: "Complement",
              hintText: "xyz",
              controller: cont.complement,
            ),
            AuthTextField(
              focusNode: cont.numberNode,
              title: "N°",
              hintText: "000000000",
              onValidate: (val) {
                if (val!.isEmpty) {
                  return tr('Please enter N°');
                }
              },
              controller: cont.number,
              keyboardType: TextInputType.number,
            ),
            CustomButton(
                title: "Next",
                onTap: () {
                  cont.zipCodeNode.unfocus();
                  cont.numberNode.unfocus();
                  cont.complementNode.unfocus();

                  if (cont.formKey.currentState!.validate() &&
                      cont.country.text.isNotEmpty &&
                      cont.city.text.isNotEmpty &&
                      cont.street.text.isNotEmpty &&
                      cont.state.text.isNotEmpty) {
                    _showBottomSheet(context);
                  } else {}
                }),
            Spacing.y(3),
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
          icon: AppIcons.locationVerified,
          onTap: () async {
            await cont.postBaseAddress();
            Get.back();
          },
          btnTitle: "ok",
          title: 'Coverage area',
          description:
              'The following data refers to your coverage area, that is, the region where you will operate, fill in carefully.',
        ); // Use the separate BottomSheet widget
      },
    );
  }
}
