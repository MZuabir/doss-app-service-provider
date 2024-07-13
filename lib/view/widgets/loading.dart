import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../utils/size_config.dart';

class ShowLoading extends StatelessWidget {
  final Widget child;
  final bool inAsyncCall;
  final double opacity;
  final Color color;
  final Animation<Color>? valueColor;

  const ShowLoading({
    Key? key,
    required this.child,
    required this.inAsyncCall,
    this.opacity = 0.3,
    this.color = Colors.black,
    this.valueColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = <Widget>[];
    widgetList.add(child);
    if (inAsyncCall) {
      final modal = Stack(
        alignment: Alignment.center,
        children: [
          Opacity(
            opacity: opacity,
            child: ModalBarrier(dismissible: false, color: color),
          ),
          // ignore: prefer_const_constructors
          Container(
              height: SizeConfig.heightMultiplier * 10,
              width:SizeConfig.widthMultiplier * 20,
              decoration: BoxDecoration(
                  color: AppColors.darkGryClr, borderRadius: BorderRadius.circular(12)),
              child: LoadingWidget(height: SizeConfig.heightMultiplier * 100))
        ],
      );
      widgetList.add(modal);
    }
    return Stack(
      children: widgetList,
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
    required this.height,
    this.width,
  }) : super(key: key);
  final double height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    final spinKit = Center(
      child: CircularProgressIndicator(
          strokeWidth: 2, color: AppColors.primaryClr),
    );
    return SizedBox(
      height: height,
      width: width??SizeConfig.widthMultiplier * 100,
      child: Center(
          child: SizedBox(
              height:SizeConfig.heightMultiplier * 8, child: spinKit)),
    );
  }
}
