import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';
import '../../../../utils/size_config.dart';

class ReceiverRowView extends StatelessWidget {
  const ReceiverRowView({Key? key, required this.receiverMessage}) : super(key: key);

  final String receiverMessage;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding:  EdgeInsets.only(bottom: SizeConfig.heightMultiplier*1,left:SizeConfig.widthMultiplier*2.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Flexible(
            flex: 10,
            fit: FlexFit.tight,
            child: CircleAvatar(
              radius: 15,
              backgroundColor: AppColors.darkGryClr,
              backgroundImage: const NetworkImage("https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
            ),
          ),
           Flexible(
            flex: 72,
            fit: FlexFit.tight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                          left: 0.0, right: 8.0, bottom: 2.0),
                      padding:  EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier*2.5,
                        vertical: SizeConfig.heightMultiplier*0.6,),
                      decoration:  BoxDecoration(
                          shape: BoxShape.rectangle,
                          color:AppColors.tileClr,
                          borderRadius: const BorderRadius.only(
                            topRight:Radius.circular(10.0),
                            bottomLeft:Radius.circular(10.0),
                            bottomRight:Radius.circular(10.0),
                          )),
                      child:  Text(
                        receiverMessage,
                        textAlign: TextAlign.left,
                        style: textTheme.bodySmall!.copyWith(fontSize: SizeConfig.textMultiplier*1.7,fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),

              ],
            ),
            //
          ),
           Flexible(
            flex: 30,
            fit: FlexFit.tight,
            child: Container(
              width: 50.0,
            ),
          ),
        ],
      ),
    );
  }
}
