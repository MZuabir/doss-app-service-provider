import 'dart:convert';
import 'dart:io';

import 'package:doss/constants/cont.dart';
import 'package:doss/controllers/patrol_vehicle.dart';
import 'package:doss/view/widgets/auth_textfield.dart';
import 'package:doss/view/widgets/custom_button.dart';
import 'package:doss/view/widgets/custom_drop_down.dart';
import 'package:doss/view/widgets/custom_image_picker.dart';
import 'package:doss/view/widgets/loading.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../constants/colors.dart';
import '../../../../../controllers/sign_up.dart';
import '../../../../../utils/size_config.dart';
import '../../../../../utils/spacing.dart';


class PatrolVehicle extends StatefulWidget {
  const PatrolVehicle({    Key? key,
     this.isEdit=false,
  }) : super(key: key);
  final bool isEdit;

  @override
  State<PatrolVehicle> createState() => _PatrolVehicleState();
}

class _PatrolVehicleState extends State<PatrolVehicle> {
  final cont=Get.put(PatrolVehicleCont());

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
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Obx(
      ()=> ShowLoading(
        inAsyncCall: authCont.isLoading.value,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Patrol Vehicle",
                style: textTheme.headlineMedium,
              ).tr(),
              Spacing.y(3),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.darkGryClr
                ),
                padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier*3,
                  vertical: SizeConfig.heightMultiplier*3,
                ),
                child: Center(
                  child: Text("After registration, you will be able to add other vehicles if you have them.",
                    style: textTheme.bodySmall,
                  ).tr(),
                ),
              ),
              Spacing.y(3),
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.tileClr
                  ),
        
                  child: Column(
                    children: [
                      Container(
                        width: SizeConfig.widthMultiplier*100,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(10),
                              topLeft: Radius.circular(10),
                            ),
                            color: AppColors.darkGryClr
                        ), padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier*3,
                        vertical: SizeConfig.heightMultiplier*3,),
                        child: Text("Vehicle",
                          style: textTheme.bodySmall,
                        ).tr(),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier*3,
                          vertical: SizeConfig.heightMultiplier*3,),
                        child: Column(
                          children: [
                            CustomDropdown(
                              title: "Type",
                              hint:  "Car",
                              selectedValue:cont.selectedType.value,
                              items: cont.type,
                              onChanged: (String? value) {
                                  cont.selectedType.value = value.toString();
                              },),
                            Spacing.y(3),
                            AuthTextField(
                                  
                                    isTitle: true,
                                    title: 'Brand',
                                    hintText: 'Honda',
                                    controller: cont.brandCont),
                                AuthTextField(
                                   
                                    isTitle: true,
                                    title: 'Model',
                                    hintText: 'CG 160',
                                    controller: cont.modelCont),
                                AuthTextField(
                                 
                                  title: "Plate",
                                  hintText: "XYZ0000",
                                  controller: cont.plateCont,
                                ),
                                AuthTextField(
                                  
                                    isTitle: true,
                                    title: 'Color',
                                    hintText: 'Red',
                                    controller: cont.colorCont),
                            CustomImagePicker(
                              onTap: () async{
                                cont.numberNode.unfocus();
                               await _pickImage();
                                convertImageToBase64(cont.photo.value);
                              },
                              photo: cont.photo.value,
        
                            ),
                            Spacing.y(3),
                            CustomButton(
                              onTap: () {
                                 cont.postPatrolVehicle();
                              },
                              title: "Next",
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
