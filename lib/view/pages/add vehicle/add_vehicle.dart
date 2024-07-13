import 'dart:developer';
import 'dart:io';

import 'package:doss/constants/car_type.dart';
import 'package:doss/constants/cont.dart';
import 'package:doss/controllers/add_vehicle.dart';
import 'package:doss/controllers/vehicles.dart';
import 'package:doss/services/image_picker.dart';
import 'package:doss/utils/size_config.dart';
import 'package:doss/utils/spacing.dart';
import 'package:doss/view/widgets/auth_textfield.dart';
import 'package:doss/view/widgets/background.dart';
import 'package:doss/view/widgets/custom_appbar.dart';
import 'package:doss/view/widgets/custom_button.dart';
import 'package:doss/view/widgets/custom_image_picker.dart';
import 'package:doss/view/widgets/loading.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../constants/colors.dart';
import '../../widgets/custom_drop_down.dart';

class AddVehicleBS extends StatefulWidget {
  const AddVehicleBS({Key? key}) : super(key: key);

  @override
  State<AddVehicleBS> createState() => _UserVehiclesPageState();
}

class _UserVehiclesPageState extends State<AddVehicleBS> {
  final plateController = TextEditingController();
  final cont = Get.put(AddVehicleCont());
  final vehicleCont = Get.find<VehiclesCont>();
  ScrollController _scrollController = ScrollController();

  get curve => null;
  @override
  Widget build(BuildContext context) {
    log( Get.locale?.languageCode.toString()??"N/A");
    final textTheme = Theme.of(context).textTheme;
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        height: SizeConfig.heightMultiplier * 90,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 3),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacing.y(3),
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.tileClr),
                    child: Column(
                      children: [
                        Container(
                          width: SizeConfig.widthMultiplier * 100,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(10),
                                topLeft: Radius.circular(10),
                              ),
                              color: AppColors.darkGryClr),
                          padding: EdgeInsets.symmetric(
                            vertical: SizeConfig.heightMultiplier * .5,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: SizeConfig.heightMultiplier * 1.5,
                                horizontal: SizeConfig.widthMultiplier * 3),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Add Vehicle",
                                    style: textTheme.bodySmall,
                                  ).tr(),
                                  const Icon(Icons.keyboard_arrow_up_rounded,
                                      color: Colors.white),
                                ]),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.heightMultiplier * 78,
                          child: SingleChildScrollView(
                            controller: _scrollController,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.widthMultiplier * 3,
                                vertical: SizeConfig.heightMultiplier * 3,
                              ),
                              child: Column(
                                children: [
                                  Obx(
                                    () => CustomDropdown(
                                      title: "Type",
                                      hint: "Car",
                                      selectedValue:
                                          cont.selectedType.value == ''
                                              ? null
                                              : cont.selectedType.value,
                                      items: cartypesEnglish,
                                      onChanged: (String? value) {
                                        cont.selectedType.value =
                                            value.toString();
                                      },
                                    ),
                                  ),
                                  Spacing.y(2),
                                  AuthTextField(
                                      focusNode: cont.brandFocusNode,
                                      isTitle: true,
                                      title: 'Brand',
                                      hintText: 'Honda',
                                      controller: cont.brandCont),
                                  AuthTextField(
                                      focusNode: cont.modelFocusNode,
                                      isTitle: true,
                                      title: 'Model',
                                      hintText: 'CG 160',
                                      controller: cont.modelCont),
                                  AuthTextField(
                                    focusNode: cont.plateFocusNode,
                                    title: "Plate",
                                    hintText: "XYZ0000",
                                    controller: cont.plateCont,
                                  ),
                                  AuthTextField(
                                      focusNode: cont.colorFocusNode,
                                      isTitle: true,
                                      title: 'Color',
                                      hintText: 'Red',
                                      controller: cont.colorCont),
                                  Obx(
                                    () => CustomImagePicker(
                                      photo: cont.selectedImgPath.value == ''
                                          ? null
                                          : XFile(cont.selectedImgPath.value),
                                      onTap: () async {
                                        final img = await ImagePickerService
                                            .onImgSelected(ImageSource.gallery);
                                        if (img != null) {
                                          cont.selectedImgPath.value = img.path;
                                        }
                                      },
                                    ),
                                  ),
                                  Spacing.y(2),
                                  Obx(
                                    () => CustomButton(
                                        isLoading: authCont.isLoading.value,
                                        title: 'Save',
                                        onTap: () {
                                          FocusScope.of(context).unfocus();
                                          cont.addVehicle();
                                        }),
                                  ),
                                  Obx(() => Spacing.y(
                                      cont.isKeyboardOpen.value ? 20 : 0))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

 
}
