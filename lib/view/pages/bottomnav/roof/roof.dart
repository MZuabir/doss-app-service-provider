import 'package:doss/utils/size_config.dart';
import 'package:doss/utils/spacing.dart';
import 'package:doss/view/widgets/background.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'components/roof_card.dart';

class RoofPage extends StatefulWidget {
  const RoofPage({Key? key}) : super(key: key);

  @override
  State<RoofPage> createState() => _RoofPageState();
}

class _RoofPageState extends State<RoofPage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return  Scaffold(
      body: Background(
        child:Padding(
          padding:  EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier*2.5),
          child: Column(
            children: [
              Spacing.y(7),
              Text("Roof",
                  textAlign: TextAlign.center,
                  style: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600)
              ).tr(),
              Spacing.y(4),
              Expanded(child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                  ...List.generate(3, (index) =>const RoofCard()
                  ),
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
