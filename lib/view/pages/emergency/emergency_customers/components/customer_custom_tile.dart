import 'package:doss/models/residential_contacts.dart';
import 'package:flutter/material.dart';

import '../../../../../constants/colors.dart';
import '../../../../../utils/size_config.dart';
import '../../../../../utils/spacing.dart';
import '../../components/emergency_custom_button.dart';

class EmergencyCustomersCustomTile extends StatelessWidget {
  const EmergencyCustomersCustomTile({Key? key, required this.contact})
      : super(key: key);
  final ResidentialContacts contact;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      height: SizeConfig.heightMultiplier * 12,
      width: SizeConfig.widthMultiplier * 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.tileClr,
      ),
      margin: EdgeInsets.only(bottom: SizeConfig.heightMultiplier * 2.5),
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 17,
            child: CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.darkGryClr,
              backgroundImage:  NetworkImage(
                 contact.photo!),
            ),
          ),
          Spacing.x(3),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: SizeConfig.widthMultiplier*40,
                child: Text(
                  contact.name!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.headlineSmall,
                ),
              ),
              Spacing.y(1),
              Text(
                contact.number!,
                style: textTheme.bodyMedium,
              ),
            ],
          ),
          const Spacer(),
           EmergencyCustomButton(phoneNumber: contact.number!,),
        ],
      ),
    );
  }
}
