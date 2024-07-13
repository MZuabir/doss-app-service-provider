import 'dart:convert';
import 'dart:io';
import 'package:doss/constants/cont.dart';
import 'package:doss/controllers/account_detail.dart';
import 'package:doss/utils/size_config.dart';
import 'package:doss/view/widgets/auth_textfield.dart';
import 'package:doss/view/widgets/custom_button.dart';
import 'package:doss/view/widgets/custom_image_picker.dart';
import 'package:doss/view/widgets/loading.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../../../constants/colors.dart';
import '../../../../../utils/spacing.dart';

class AdUserDataWidget extends StatefulWidget {
  AdUserDataWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<AdUserDataWidget> createState() => _AdUserDataWidgetState();
}

class _AdUserDataWidgetState extends State<AdUserDataWidget>
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

  void _toggleExpand() {FocusScope.of(context).unfocus();
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

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    cont.photo?.value = image;
  }

  Future<void> convertImageToBase64(
    XFile? image,
  ) async {
    if (image != null) {
      File file = File(image.path);
      List<int> imageBytes = await file.readAsBytes();
      cont.base64Image = base64Encode(imageBytes);
    } else {
      cont.base64Image = '';
    }
  }

  unFocusNode() {
    cont.phoneNode.unfocus();
    cont.documentNode.unfocus();
    cont.nameNode.unfocus();
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
                    'User Data',
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
                      child: Obx(
                        () => Form(
                          key: cont.userDataformKey,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.widthMultiplier * 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AuthTextField(
                                  focusNode: cont.documentNode,
                                  formatter: [
                                    cont.isCpfSelected.value
                                        ? MaskTextInputFormatter(
                                            mask: "###.###.###-##")
                                        : MaskTextInputFormatter(
                                            mask: "##.###.###/####-##")
                                  ],
                                  onValidate: (val) {
                                    if (val!.isEmpty) {
                                      return tr("Please enter Document number");
                                    }
                                  },
                                  title: "CPF or CNPJ",
                                  hintText: cont.isCpfSelected.value
                                      ? "314.356.008-86"
                                      : "70.300.462/0001-00",
                                  controller: cont.document,
                                  keyboardType: TextInputType.number,
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height:
                                              SizeConfig.imageSizeMultiplier *
                                                  5,
                                          width:
                                              SizeConfig.imageSizeMultiplier *
                                                  5,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              width:
                                                  2.0, // Adjust the border width as needed
                                              color: AppColors
                                                  .whiteClr, // Set the desired border color
                                            ),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Radio(
                                            activeColor: AppColors.primaryClr,
                                            hoverColor: AppColors.darkGryClr,
                                            value: true,
                                            groupValue:
                                                cont.isCpfSelected.value,
                                            onChanged: (value) {
                                              cont.isCpfSelected.value =
                                                  value as bool;
                                              cont.isCpnjSelected.value =
                                                  !cont.isCpfSelected.value;
                                              cont.document.clear();
                                            },
                                          ),
                                        ),
                                        Spacing.x(5),
                                        Text(
                                          "CPF",
                                          style: textTheme.bodyMedium!.copyWith(
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    Spacing.x(10),
                                    Row(
                                      children: [
                                        Container(
                                          height:
                                              SizeConfig.imageSizeMultiplier *
                                                  5,
                                          width:
                                              SizeConfig.imageSizeMultiplier *
                                                  5,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              width:
                                                  2.0, // Adjust the border width as needed
                                              color: AppColors
                                                  .whiteClr, // Set the desired border color
                                            ),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Radio(
                                            activeColor: AppColors.primaryClr,
                                            hoverColor: AppColors.darkGryClr,
                                            value: true,
                                            groupValue:
                                                cont.isCpnjSelected.value,
                                            onChanged: (value) {
                                              cont.isCpnjSelected.value =
                                                  value as bool;
                                              cont.isCpfSelected.value =
                                                  !cont.isCpnjSelected.value;
                                              cont.document.clear();
                                            },
                                          ),
                                        ),
                                        Spacing.x(5),
                                        Text(
                                          "CPNJ",
                                          style: textTheme.bodyMedium!.copyWith(
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Spacing.y(3),
                                AuthTextField(
                                  focusNode: cont.nameNode,
                                  onValidate: (val) {
                                    if (val!.isEmpty) {
                                      return tr("Please enter name");
                                    }
                                  },
                                  title: "Name",
                                  hintText: "Full Name",
                                  controller: cont.name,
                                ),
                                AuthTextField(
                                  formatter: [
                                    MaskTextInputFormatter(
                                        mask: "(##) #####-####")
                                  ],
                                  focusNode: cont.phoneNode,
                                  onValidate: (val) {
                                    if (val!.isEmpty) {
                                      return tr("Please enter phone number");
                                    }
                                  },
                                  title: "Cell",
                                  hintText: "11 9999-9999",
                                  controller: cont.phone,
                                  keyboardType: TextInputType.number,
                                ),
                                CustomImagePicker(
                                  onTap: () async {
                                    unFocusNode();
                                    await _pickImage();
                                    convertImageToBase64(cont.photo.value);
                                  },
                                  photo: cont.photo.value,
                                  baseImage: cont.base64Image,
                                ),
                                cont.photo.value == null
                                    ? Image.network(cont.photoUrl.value,
                                        height:
                                            SizeConfig.heightMultiplier * 20,
                                        width: SizeConfig.widthMultiplier * 100)
                                    : const SizedBox(),
                                Spacing.y(3),
                                CustomButton(
                                  title: "Update",
                                  onTap: () {
                                    FocusScope.of(context).unfocus();
                                    if (cont.userDataformKey.currentState!
                                        .validate()) {
                                      cont.updateUserDetails();
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
                  );
                }),
          ],
        ),
      ),
    );
  }
}
