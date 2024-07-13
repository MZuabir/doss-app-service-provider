import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doss/constants/colors.dart';
import 'package:doss/models/chat.dart';
import 'package:doss/utils/size_config.dart';
import 'package:doss/view/pages/chat/components/audio_msg.dart';
import 'package:doss/view/pages/view%20image/view_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

class SenderRowView extends StatelessWidget {
  const SenderRowView({Key? key, required this.chatData, required this.index})
      : super(key: key);

  final Chats chatData;
  final int index;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Flexible(
          flex: 35,
          fit: FlexFit.tight,
          child: SizedBox(),
        ),
        Flexible(
          flex: 72,
          fit: FlexFit.tight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Wrap(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: SizeConfig.widthMultiplier * 2.5,
                      vertical: SizeConfig.heightMultiplier * 0.35,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.widthMultiplier * 2.5,
                      vertical: SizeConfig.heightMultiplier * 0.6,
                    ),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: AppColors.primaryClr,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(10.0),
                          bottomLeft: Radius.circular(10.0),
                          topLeft: Radius.circular(10.0),
                        )),
                    child: chatData.audioUrl != ''
                        ? AudioMsgTile(index: index, data: chatData)
                        : chatData.photoUrl != ''
                            ? InkWell(
                                onTap: () => Get.to(() => ViewImagePage(
                                    imageUrl: chatData.photoUrl!)),
                                child: SizedBox(
                                  height: SizeConfig.heightMultiplier * 10,
                                  width: SizeConfig.widthMultiplier * 20,
                                  // color: Colors.grey.shade100,
                                  child: CachedNetworkImage(
                                    imageUrl: chatData.photoUrl!,
                                    placeholder: (_, sa) =>
                                        const CupertinoActivityIndicator(
                                            color: Colors.black),
                                  ),
                                ))
                            : Text(
                                chatData.message!,
                                textAlign: TextAlign.left,
                                style: textTheme.bodySmall!.copyWith(
                                    color: Colors.black,
                                    fontSize: SizeConfig.textMultiplier * 1.7,
                                    fontWeight: FontWeight.w500),
                              ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: SizeConfig.heightMultiplier * 1,
                    right: SizeConfig.widthMultiplier * 4),
                child: Text(
                  timeago.format(DateTime.parse(chatData.when!)),
                  style: textTheme.labelSmall!.copyWith(color: Colors.grey),
                ),
              )
            ],
          ),
          //
        ),
      ],
    );
  }
}
