import 'dart:developer';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doss/constants/car_type.dart';
import 'package:doss/constants/cont.dart';
import 'package:doss/controllers/residential_vehicles.dart';
import 'package:doss/controllers/vehicles.dart';
import 'package:doss/models/vehicles.dart';
import 'package:doss/services/image_picker.dart';
import 'package:doss/view/pages/add%20vehicle/add_vehicle.dart';
import 'package:doss/view/widgets/auth_textfield.dart';
import 'package:doss/view/widgets/custom_button.dart';
import 'package:doss/view/widgets/custom_image_picker.dart';
import 'package:doss/view/widgets/custom_snackbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../constants/colors.dart';
import '../../../../utils/size_config.dart';
import '../../../../utils/spacing.dart';
import '../../../widgets/custom_drop_down.dart';

class VehiclesTile extends StatefulWidget {
  const VehiclesTile(
      {Key? key, required this.index, this.isResidential = false})
      : super(key: key);
  final int index;
  final bool isResidential;
  @override
  State<VehiclesTile> createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<VehiclesTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool isExpanded = false;

  late String selectedType;
  String? imgUrl;
  String? imgPath;
  TextEditingController brand = TextEditingController();
  TextEditingController color = TextEditingController();
  TextEditingController model = TextEditingController();
  TextEditingController plate = TextEditingController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    Future.delayed(Duration.zero, () => getVehicleData());
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpand() {
    setState(() {
      isExpanded = !isExpanded;
      if (isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  getVehicleData() {
    if (widget.isResidential) {
      final cont = Get.find<ResidentialVehiclesCont>();
      final data = cont.getVehicles![widget.index];
      selectedType = data.vehicleType!;
      brand.text = data.brand ?? "";
      model.text = data.model ?? "";
      color.text = data.color ?? "";
      plate.text = data.plate ?? "";
      imgUrl = data.photo ?? "";
    } else {
      final cont = Get.find<VehiclesCont>();
      final data = cont.getVehicles![widget.index];
      selectedType = data.vehicleType!;
      brand.text = data.brand ?? "";
      model.text = data.model ?? "";
      color.text = data.color ?? "";
      plate.text = data.plate ?? "";
      imgUrl = data.photo ?? "";
    }
    // log(plate.toString());
    // log(imgUrl.toString());
    setState(() {});
  }

  // final cont = Get.find<VehiclesCont>();
  @override
  Widget build(BuildContext context) {
    final data = widget.isResidential
        ? Get.find<ResidentialVehiclesCont>().getVehicles![widget.index]
        : Get.find<VehiclesCont>().getVehicles![widget.index];

    print(data.photo!);

    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: _toggleExpand,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.darkGryClr,
        ),
        margin: EdgeInsets.only(bottom: SizeConfig.heightMultiplier * 3),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        data.plate!,
                        style: textTheme.bodyMedium,
                      ),
                      Icon(
                        isExpanded ? Icons.expand_less : Icons.expand_more,
                        color: AppColors.whiteClr,
                      ),
                    ],
                  ),
                  widget.isResidential && !data.defaultVehicle!
                      ? SizedBox()
                      : Spacing.y(5),
                  Row(
                    children: [
                      widget.isResidential
                          ? const SizedBox()
                          : InkWell(
                              onTap: () => _onRemove(),
                              child: Text(
                                "Remove Vehicle",
                                style: textTheme.bodyMedium!
                                    .copyWith(color: AppColors.primaryClr),
                              ).tr(),
                            ),
                      widget.isResidential ? const SizedBox() : const Spacer(),
                      widget.isResidential
                          ? Text(
                              data.defaultVehicle! ? "Vehicle In use" : "",
                              style: textTheme.bodyMedium!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primaryClr),
                            ).tr()
                          : InkWell(
                              onTap: data.defaultVehicle!
                                  ? null
                                  : () => Get.find<VehiclesCont>()
                                      .putVehicleInUseOrNot(data.id!, true),
                              child: Text(
                                data.defaultVehicle!
                                    ? "Vehicle in use"
                                    : "Put to use",
                                style: textTheme.bodyMedium!.copyWith(
                                    fontWeight: data.defaultVehicle!
                                        ? FontWeight.w400
                                        : FontWeight.w500,
                                    color: data.defaultVehicle!
                                        ? AppColors.whiteClr
                                        : AppColors.primaryClr),
                              ).tr(),
                            ),
                    ],
                  ),
                ],
              ),
            ),
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return ClipRect(
                  child: Align(
                    alignment: Alignment.topCenter,
                    heightFactor: _animationController.value,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                        color: AppColors.tileClr,
                      ),
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.widthMultiplier * 4),
                        child: Column(
                          children: [
                            Spacing.y(3),
                            widget.isResidential
                                ? CustomDropdown(
                                  enable: ! widget.isResidential,
                                    selectedValue:
                                        Get.find<ResidentialVehiclesCont>()
                                            .vehicles
                                            .value![widget.index]
                                            .vehicleType,
                                    items: cartypesEnglish,
                                    onChanged: (val) {
                                      Get.find<ResidentialVehiclesCont>()
                                          .vehicles
                                          .value![widget.index]
                                          .vehicleType = val;
                                      Get.find<ResidentialVehiclesCont>()
                                          .vehicles
                                          .refresh();
                                    },
                                    title: 'Type',
                                    hint: 'Vehicle type')
                                : CustomDropdown(
                                    selectedValue: Get.find<VehiclesCont>()
                                        .vehicles
                                        .value![widget.index]
                                        .vehicleType,
                                    items: cartypesEnglish,
                                    onChanged: (val) {
                                      Get.find<VehiclesCont>()
                                          .vehicles
                                          .value![widget.index]
                                          .vehicleType = val;
                                      Get.find<VehiclesCont>()
                                          .vehicles
                                          .refresh();
                                    },
                                    title: 'Type',
                                    hint: 'Vehicle type'),
                            Spacing.y(3),
                            AuthTextField(
                                isTitle: true,
                                
                                isEnable: !widget.isResidential,
                                title: 'Brand',
                                onChange: (val) {
                                  if (val!.isNotEmpty) {
                                    if (widget.isResidential) {
                                      Get.find<ResidentialVehiclesCont>()
                                          .vehicles
                                          .value![widget.index]
                                          .brand = val;
                                    } else {
                                      Get.find<VehiclesCont>()
                                          .vehicles
                                          .value![widget.index]
                                          .brand = val;
                                    }
                                  }
                                },
                                hintText: 'Brand',
                                controller: brand),
                            AuthTextField(
                                isTitle: true,
                                title: 'Model',
                                isEnable: !widget.isResidential,
                                hintText: 'CG 160',
                                controller: model),
                            AuthTextField(
                              title: "Plate",
                              textCaptilization: true,
                              isEnable: !widget.isResidential,
                              hintText: "XYZ0000",
                              controller: plate,
                            ),
                            AuthTextField(
                                isTitle: true,
                                title: 'Color',
                                isEnable: !widget.isResidential,
                                hintText: 'Red',
                                controller: color),
                            widget.isResidential
                                ? const SizedBox()
                                : CustomImagePicker(
                                    photo: imgPath == null
                                        ? null
                                        : XFile(imgPath!),
                                    onTap: () async {
                                      final img = await ImagePickerService
                                          .onImgSelected(ImageSource.gallery);
                                      if (img != null) {
                                        imgPath = img.path;
                                        setState(() {});
                                      }
                                    },
                                  ),

                            //  Image.network(data.photo!),
                            imgUrl != null && imgPath == null
                                ? Padding(
                                    padding: EdgeInsets.only(
                                        top: SizeConfig.heightMultiplier * 2),
                                    child: Image.network(data.photo!,
                                        key:
                                            ValueKey(DateTime.now().toString()),
                                        height:
                                            SizeConfig.heightMultiplier * 20),
                                  )
                                : const SizedBox(),
                            Spacing.y(2),
                            widget.isResidential
                                ? const SizedBox()
                                : CustomButton(
                                    title: 'Save',
                                    onTap: () {
                                      if (_validator()) {
                                        FocusScope.of(context).unfocus();
                                        Get.find<VehiclesCont>()
                                            .updateVehiclesData(
                                                id: data.id!,
                                                brand: brand.text,
                                                model: model.text,
                                                color: color.text,
                                                plate: plate.text,
                                                photo: imgPath,
                                                type: selectedType);
                                      }
                                    }),
                            Spacing.y(3),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  bool _validator() {
    if (brand.text.isEmpty) {
      showCustomSnackbar(true, 'Brand is empty');
      return false;
    } else if (model.text.isEmpty) {
      showCustomSnackbar(true, 'Model is empty');

      return false;
    } else if (plate.text.isEmpty) {
      showCustomSnackbar(true, 'Plate is empty');

      return false;
    } else if (color.text.isEmpty) {
      showCustomSnackbar(true, 'Color is empty');

      return false;
    } else {
      return true;
    }
  }

  _onRemove() {
    Get.defaultDialog(
        onConfirm: () => Get.find<VehiclesCont>().removeVehicle(
            Get.find<VehiclesCont>().getVehicles![widget.index].id!),
        backgroundColor: AppColors.darkGryClr,
        cancel: TextButton(
            onPressed: () => Get.back(),
            child: const Text(
              'Cancel',
              style: TextStyle(fontWeight: FontWeight.w500, color: Colors.red),
            ).tr()),
        buttonColor: AppColors.primaryClr,
        textConfirm: tr('Done'),
        confirmTextColor: Colors.black,
        title: tr('Confirm Vehicle Removal'),
        middleText: tr(
            'Are you sure you want to remove your vehicle? This action is irreversible.'));
  }
}
