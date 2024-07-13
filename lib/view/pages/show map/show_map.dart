import 'package:doss/constants/colors.dart';
import 'package:doss/models/verification_all.dart';
import 'package:doss/utils/size_config.dart';
import 'package:doss/utils/spacing.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShowOnMapPage extends StatefulWidget {
  const ShowOnMapPage({Key? key, required this.data}) : super(key: key);
  final Verification data;

  @override
  State<ShowOnMapPage> createState() => _OfficersLocationPageState();
}

class _OfficersLocationPageState extends State<ShowOnMapPage> {
  bool isLoading = true;
  List<Marker>? _markers;
  @override
  void initState() {
    super.initState();
    _markers = <Marker>[
      Marker(
          markerId: MarkerId(widget.data.id!),
          position:
              LatLng(widget.data.address!.lat!, widget.data.address!.lng!),
          infoWindow: const InfoWindow(title: "This is the location"))
    ];
    isLoading = false;
    setState(() {});
  }

  final dateFormat = DateFormat('dd/MM/yyyy');
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        titleSpacing: -8.0,
        foregroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 14.0),
          child: BackButton(
            onPressed: () {
              Get.back();
            },
          ),
        ),
        centerTitle: true,
        title: Row(mainAxisSize: MainAxisSize.min, children: [
          CircleAvatar(
            backgroundColor: Colors.white10,
            backgroundImage: widget.data.residential!.photo == null
                ? null
                : NetworkImage(widget.data.residential!.photo!),
            child: widget.data.residential!.photo == null
                ? const Icon(
                    CupertinoIcons.person,
                    size: 18,
                    color: Colors.grey,
                  )
                : null,
          ),
          Spacing.x(2),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.data.residential?.name ?? "Unknown",
                  style: textTheme.bodySmall!
                      .copyWith(fontWeight: FontWeight.w600)),
              SizedBox(height: SizeConfig.heightMultiplier * .5),
              Text(
                dateFormat.format(widget.data!.when!),
                style: textTheme.labelMedium!.copyWith(color: Colors.white),
              ),
            ],
          )
        ]),
        actions: [
          // Center(
          //   child: Text(
          //     "Verification",
          //     style: textTheme.bodyMedium!.copyWith(
          //         fontWeight: FontWeight.w600, color: AppColors.primaryClr),
          //   ).tr(),
          // ),
          Spacing.x(2.5),
        ],
      ),
      body: isLoading
          ? CircularProgressIndicator(
              strokeWidth: 1.5,
              color: AppColors.primaryClr,
            )
          : GoogleMap(
              mapType: MapType.normal,
              markers: Set<Marker>.of(_markers!),
              myLocationEnabled: false,
              zoomControlsEnabled: false,
              onMapCreated: (GoogleMapController cont) {},
              initialCameraPosition: CameraPosition(
                  zoom: 15,
                  target: LatLng(
                      widget.data.address!.lat!, widget.data.address!.lng!))),
    );
  }
}
