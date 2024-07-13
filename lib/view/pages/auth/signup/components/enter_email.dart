import 'package:doss/constants/colors.dart';
import 'package:doss/constants/cont.dart';
import 'package:doss/utils/size_config.dart';
import 'package:doss/utils/spacing.dart';
import 'package:doss/view/widgets/auth_textfield.dart';
import 'package:doss/view/widgets/custom_button.dart';
import 'package:doss/view/widgets/txt_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../../../constants/icons.dart';
import '../../../../../controllers/sign_in.dart';
import '../../../../../controllers/sign_up.dart';
import '../../../../widgets/custom_snackbar.dart';
import '../../../terms_and_conditions/terms_and_condition.dart';

class EnterEmailPage extends StatefulWidget {
  EnterEmailPage({
       Key? key,
     this.isEdit=false,
  }) : super(key: key);
  final bool isEdit;

  @override
  State<EnterEmailPage> createState() => _EnterEmailPageState();
}

class _EnterEmailPageState extends State<EnterEmailPage> {
  final cont = Get.put(SignUpCont());
  List<String> icon = [
    AppIcons.faceBook,
    AppIcons.google,
    AppIcons.apple,
  ];

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Enter your email",
            style: textTheme.headlineMedium,
          ).tr(),
          Spacing.y(3),
          CustomCheckbox(
            title: "I agree to the",
            value: cont.termsAndPolicies.value,
            onChanged: (bool? value) {
              cont.termsAndPolicies.value = value!;
              cont.updateButtonState();
            },
            btnTitle: authCont.userLanguage.value == 'Portugese'
                ? 'Terms of Use and Privacy'
                : 'Terms of Use and Privacy Policies',
            description:
                authCont.userLanguage.value == 'Portugese' ? "Policies" : "",
            onTap: () {
              Get.to(
                () => const TermAndConditionsPage(),
                transition: Transition.downToUp,
              );
            },
          ),
          Spacing.y(2),
          CustomCheckbox(
            title: "I confirm that I am at least 12 years old",
            value: cont.age.value,
            onChanged: (bool? value) {
              cont.age.value = value!;
              cont.updateButtonState();
            },
          ),
          Spacing.y(5),
          CustomButton(
            title: "Next",
            onTap: () async {
              if (cont.isEnabled.value) {
                cont.pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              } else {
                showCustomSnackbar(true, "Agree to terms and policies");
              }
            },
            isEnabled: cont.isEnabled.value,
          ),
          Spacing.y(2),
          Spacing.y(3),
        ],
      ),
    );
  }
}

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?>? onChanged;
  final String title;
  final String? btnTitle;
  final String? description;
  final Function()? onTap;

  const CustomCheckbox(
      {Key? key,
      required this.value,
      required this.onChanged,
      required this.title,
      this.btnTitle,
      this.onTap,
      this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Colors.grey,
          height: SizeConfig.heightMultiplier * 2.4,
          width: SizeConfig.heightMultiplier * 2.4,
          child: Checkbox(
            value: value,
            side: const BorderSide(
              width: 0,
              color: Colors.grey,
            ),
            checkColor: AppColors.whiteClr,
            activeColor: AppColors.primaryClr,
            onChanged: onChanged,
          ),
        ),
        Spacing.x(3),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tr(title),
                  style: textTheme.bodySmall,
                ),
                Spacing.x(2),
                btnTitle == null
                    ? const SizedBox()
                    : GestureDetector(
                        onTap: onTap,
                        child: Text(
                          tr(btnTitle ?? ""),
                          style:
                          textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600,decoration: TextDecoration.underline,decorationThickness: 3),
                        ),
                      ),
              ],
            ),
            GestureDetector(
              onTap: onTap,
              child: Text(
                tr(description ?? ""),
                style:
                    textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600,decoration: TextDecoration.underline,decorationThickness: 3),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
