import 'dart:io';
import 'package:doss/constants/cont.dart';
import 'package:doss/controllers/user_data.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../constants/colors.dart';
import '../../constants/icons.dart';
import '../../utils/size_config.dart';
import '../../utils/spacing.dart';

class CustomImagePicker extends StatelessWidget {
  final String? baseImage;
  final Function()? onTap;
  final bool isSmallPhoto;
  final XFile? photo; // Pass the photo as a parameter

  const CustomImagePicker(
      {Key? key,
      this.baseImage,
      this.onTap,
      this.photo,
      this.isSmallPhoto = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Upload Photo",
          style: Theme.of(context).textTheme.bodyLarge,
        ).tr(),
        Spacing.y(1),
        GestureDetector(
          onTap: onTap,
          child: Column(
            children: [
              Container(
                height: SizeConfig.heightMultiplier * 6.5,
                width: SizeConfig.widthMultiplier * 100,
                color: AppColors.fieldClr,
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.widthMultiplier * 3),
                child: Row(
                  children: [
                    Text(
                      "Select Image",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.black45,
                            fontWeight: FontWeight.w500,
                          ),
                    ).tr(),
                    const Spacer(),
                    isSmallPhoto
                        ? photo == null
                            ? const SizedBox()
                            : Image.file(
                                File(photo!.path),
                                height: SizeConfig.heightMultiplier * 20,
                              )
                        : const SizedBox(),
                    Spacing.x(2),
                    Image.asset(
                      AppIcons.upload,
                      height: SizeConfig.imageSizeMultiplier * 6,
                      width: SizeConfig.imageSizeMultiplier * 6,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (photo != null && !isSmallPhoto) ...[
          Spacing.y(3),
          Image.file(
            File(photo!.path),
            height: SizeConfig.heightMultiplier * 20,
            width: SizeConfig.widthMultiplier * 100,
          ),
        ],
      ],
    );
  }
}
