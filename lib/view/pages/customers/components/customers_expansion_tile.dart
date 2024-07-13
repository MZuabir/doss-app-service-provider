import 'dart:developer';

import 'package:doss/controllers/customers.dart';
import 'package:doss/models/customers.dart';
import 'package:doss/models/residential_detail.dart';
import 'package:doss/models/verification_all.dart';
import 'package:doss/view/pages/add%20vehicle/add_vehicle.dart';
import 'package:doss/view/pages/residential%20vehicles/residential_vehicles.dart';
import 'package:doss/view/widgets/loading.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../constants/colors.dart';
import '../../../../utils/size_config.dart';
import '../../../../utils/spacing.dart';

class CustomersExpansionTile extends StatefulWidget {
  const CustomersExpansionTile({
    Key? key,
    this.data,  this.isExpanded,  this.onToggle,
  }) : super(key: key);
  final Residentials? data;
  final bool? isExpanded;
  final VoidCallback? onToggle;
  @override
  State<CustomersExpansionTile> createState() => _CustomersExpansionTileState();
}

class _CustomersExpansionTileState extends State<CustomersExpansionTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  
bool isExpanded=false;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }



  void _toggleExpand() {
    setState(() {
      isExpanded = !isExpanded;
      if (isExpanded) {
        log(widget.data!.id!);
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Color color = widget.data!.status == 'Pendente'
        ? Colors.yellow
        : widget.data!.status == 'Cancelado'
            ? Colors.red
            : widget.data!.status == 'Em dia'
                ? Colors.green
                : Colors.green;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.darkGryClr,
      ),
      margin: EdgeInsets.only(bottom: SizeConfig.heightMultiplier * 3),
      child: Column(
        children: [
          InkWell(
            onTap: _toggleExpand,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColors.darkGryClr,
                    backgroundImage: NetworkImage(widget.data!.photo!),
                  ),
                  Spacing.x(3),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.data!.name!,
                            style: textTheme.bodyMedium!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                          Spacing.x(2),
                          Text(
                            widget.data!.plan!,
                            style: textTheme.bodySmall,
                          ).tr(),
                        ],
                      ),
                      Spacing.y(1),
                      Row(
                        children: [
                          Text(
                            "Payment status:",
                            style: textTheme.bodySmall,
                          ).tr(),
                          Spacing.x(2),
                          Text(
                            widget.data!.status!,
                            style: textTheme.bodyMedium!
                                .copyWith(fontWeight: FontWeight.w600),
                          ).tr(),
                          Spacing.x(2),
                          Container(
                            height: 5,
                            width: 5,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: color,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: AppColors.whiteClr,
                  ),
                ],
              ),
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
                    child: FutureBuilder<ResidentialDetailModel?>(
                        future: Get.find<CustomersCont>()
                            .getResidentialDetai(widget.data!.id!),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.waiting ||
                              snapshot.data == null) {
                            return LoadingWidget(
                                height: SizeConfig.heightMultiplier * 10);
                          }
                          final address = snapshot.data!.data!.address!;
                          return Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        SizeConfig.widthMultiplier * 4),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Address",
                                          style: textTheme.bodyMedium!
                                              .copyWith(
                                                  fontWeight:
                                                      FontWeight.w600),
                                        ).tr(),
                                        TextButton(
                                          onPressed: () => _launchMaps(
                                              address.latitude!,
                                              address.longitude!),
                                          child: Text(
                                            "View on map",
                                            style: textTheme.bodyMedium!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.w600,
                                                    color:
                                                        AppColors.primaryClr),
                                          ).tr(),
                                        ),
                                      ],
                                    ),
                                    Spacing.y(3),
                                    Text(
                                      "${address.street}, ${address.number} - ${address.city} - ${address.country} - CEP: ${address.zipCode}",
                                      style: textTheme.bodyMedium,
                                    ),
                                    Spacing.y(1),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Vehicles",
                                          style: textTheme.bodyMedium!
                                              .copyWith(
                                                  fontWeight:
                                                      FontWeight.w600),
                                        ).tr(),
                                        TextButton(
                                          onPressed: () => Get.to(
                                              () =>
                                                   ResidentialVehiclesPage(id: widget.data!.id!,),
                                              transition:
                                                  Transition.rightToLeft),
                                          child: Text(
                                            "See All",
                                            style: textTheme.bodyMedium!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.w600,
                                                    color:
                                                        AppColors.primaryClr),
                                          ).tr(),
                                        ),
                                      ],
                                    ),
                                    Spacing.y(3),
                                    Text(
                                      "Yamaha Ténéré 250 - Azul - XZT0000",
                                      style: textTheme.bodyMedium,
                                    ),
                                    Spacing.y(1.5),
                                    Text(
                                      "1 ${tr("Vehicle")}",
                                      style: textTheme.bodyMedium,
                                    ),
                                    Spacing.y(2),
                                  ],
                                ),
                              ),
                              Container(
                                height: SizeConfig.heightMultiplier * 20,
                                width: SizeConfig.widthMultiplier * 100,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10))),
                                child: Image.network(
                                    snapshot.data!.data!.vehicle!.photoUrl!),
                              )
                            ],
                          );
                        }),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  _launchMaps(double lat, double lng) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    log(googleUrl);
    if (await canLaunchUrl(Uri.parse(googleUrl))) {
      print('launching com googleUrl');
      await launchUrl(Uri.parse(googleUrl));
    } else {
      throw 'Could not launch url';
    }
  }
}
