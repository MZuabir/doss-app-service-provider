import 'dart:convert';
import 'dart:io';

import 'package:doss/constants/cont.dart';
import 'package:doss/controllers/sign_up.dart';
import 'package:doss/utils/size_config.dart';
import 'package:doss/view/pages/auth/signup/signup_onboarding.dart';
import 'package:doss/view/widgets/auth_textfield.dart';
import 'package:doss/view/widgets/custom_button.dart';
import 'package:doss/view/widgets/loading.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../../../constants/colors.dart';
import '../../../../../controllers/user_data.dart';
import '../../../../../utils/spacing.dart';
import '../../../../widgets/custom_image_picker.dart';


class UserData extends StatefulWidget {
  UserData({    Key? key,
     this.isEdit=false,
  }) : super(key: key);
  final bool isEdit;

  @override
  State<UserData> createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  final cont=Get.put(UserDataCont());

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    cont.photo?.value = image;
  }

  Future<void> convertImageToBase64(XFile? image,) async {
    if (image != null) {
      File file = File(image.path);
      List<int> imageBytes = await file.readAsBytes();
      cont.base64Image = base64Encode(imageBytes);
    } else {
      cont.base64Image = '';
    }
  }
  unFocusNode(){
    cont.phoneNode.unfocus();
    cont.documentNode.unfocus();
    cont.nameNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Obx(
          ()=> ShowLoading(
        inAsyncCall: authCont.isLoading.value,
        child: Form(
          key: cont.formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("User Data",
                  style: textTheme.headlineMedium,
                ).tr(),
                Spacing.y(3),
                AuthTextField(
                  focusNode: cont.documentNode,
                  formatter: [cont.isCpfSelected.value?MaskTextInputFormatter(mask: "###.###.###-##"):MaskTextInputFormatter(mask: "##.###.###/####-##")],
                  onValidate: (val) {
                    if (val!.isEmpty) {
                      return tr("Please enter Document number");
                    }
                  },
                  title: "CPF or CNPJ",
                  hintText: cont.isCpfSelected.value?"314.356.008-86":"70.300.462/0001-00",
                  controller: cont.document,
                  keyboardType: TextInputType.number,
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: SizeConfig.imageSizeMultiplier*5,
                          width: SizeConfig.imageSizeMultiplier*5,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2.0, // Adjust the border width as needed
                              color: AppColors.whiteClr, // Set the desired border color
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Radio(
                            activeColor: AppColors.primaryClr,
                            hoverColor: AppColors.darkGryClr,
                            value: true,
                            groupValue: cont.isCpfSelected.value,
                            onChanged: (value) {
                              cont.isCpfSelected.value = value as bool;
                              cont.isCpnjSelected.value = !cont.isCpfSelected.value;
                              cont.document.clear();
                            },
                          ),
                        ),
                        Spacing.x(5),
                        Text("CPF",style: textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),),
                      ],
                    ),
                    Spacing.x(10),
                    Row(
                      children: [
                        Container(
                          height: SizeConfig.imageSizeMultiplier*5,
                          width: SizeConfig.imageSizeMultiplier*5,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2.0, // Adjust the border width as needed
                              color: AppColors.whiteClr, // Set the desired border color
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Radio(
                            activeColor: AppColors.primaryClr,
                            hoverColor: AppColors.darkGryClr,
                            value: true,
                            groupValue: cont.isCpnjSelected.value,
                            onChanged: (value) {
                              cont.isCpnjSelected.value = value as bool;
                              cont.isCpfSelected.value = !cont.isCpnjSelected.value;
                              cont.document.clear();
                            },
                          ),
                        ),
                        Spacing.x(5),
                        Text("CPNJ",style: textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),),
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
                  formatter: [MaskTextInputFormatter(mask: "(##) #####-####")],
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
                  onTap: ()async{
                    unFocusNode();
                    await _pickImage();
                    convertImageToBase64(cont.photo.value);
                  },
                  photo: cont.photo.value,
                  baseImage: cont.base64Image,
                ),
                Spacing.y(3),
                CustomButton(title: "Next", onTap: () {
                  unFocusNode();
                  cont.postUserData();
                },),
                Spacing.y(3),

              ],
            ),
          ),
        ),
      ),
    );
  }
}




