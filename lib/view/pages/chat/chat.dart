import 'dart:convert';
import 'dart:developer';

import 'package:doss/constants/colors.dart';
import 'package:doss/constants/cont.dart';
import 'package:doss/constants/icons.dart';
import 'package:doss/controllers/chat.dart';
import 'package:doss/controllers/recording.dart';
import 'package:doss/models/verification_all.dart';
import 'package:doss/services/image_picker.dart';
import 'package:doss/utils/size_config.dart';
import 'package:doss/utils/spacing.dart';
import 'package:doss/view/widgets/audio_wave.dart';
import 'package:doss/view/widgets/custom_image_picker.dart';
import 'package:doss/view/widgets/record_btn.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../models/message_data.dart';
import 'components/chat_list_view.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key, required this.data}) : super(key: key);
  final Verification data;
  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  final recordCont = Get.put(RecordingCont());
  final cont = Get.put(ChatCont());
  late String senderMessage, receiverMessage;
  ScrollController scrollController = ScrollController();

  Future<void> scrollAnimation() async {
    return await Future.delayed(
        const Duration(milliseconds: 100),
        () => scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.linear));
  }

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (!cont.onReachesEnd.value) {
          cont.currentPage.value += 1;
        }
      }
    });
  }

  final dateFormat = DateFormat('dd/MM/yyyy');
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          titleSpacing: -8.0,
          foregroundColor: Colors.white,
          leading: Padding(
            padding: const EdgeInsets.only(left: 14.0),
            child: BackButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
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
                Text(widget.data.residential!.name!,
                    style: textTheme.bodySmall!
                        .copyWith(fontWeight: FontWeight.w600)),
                SizedBox(height: SizeConfig.heightMultiplier * .5),
                Text(
                  dateFormat.format(widget.data.when!),
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
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  color: AppColors.darkGryClr,
                  width: SizeConfig.widthMultiplier * 100,
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.widthMultiplier * 2.5,
                    vertical: SizeConfig.heightMultiplier * 2.5,
                  ),
                  child: cont.isRequestLoading.value
                      ? const CupertinoActivityIndicator(color: Colors.white)
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: SizeConfig.widthMultiplier * 50,
                              child: Text(
                                "“Good morning, John! Could you check if I locked the gate correctly?”",
                                style: textTheme.bodySmall,
                              ).tr(),
                            ),
                            //REQUEST RESOLUTION BTN
                            InkWell(
                              onTap: () =>
                                  cont.requestResolution(widget.data.id!),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: AppColors.primaryClr),
                                padding: EdgeInsets.symmetric(
                                  horizontal: SizeConfig.widthMultiplier * 3,
                                  vertical: SizeConfig.heightMultiplier * 0.4,
                                ),
                                child: Text(
                                  "Request resolution",
                                  style: textTheme.bodyMedium!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ).tr(),
                              ),
                            )
                          ],
                        ),
                ),
                Spacing.y(1),
                Expanded(
                    child: ChatListView(scrollController: scrollController)),
                Container(
                  color: AppColors.tileClr,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.widthMultiplier * 2.5,
                        vertical: SizeConfig.heightMultiplier * 2.5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            cont.showAttachment.value =
                                !cont.showAttachment.value;
                          },
                          child: CircleAvatar(
                            radius: 23,
                            backgroundColor: AppColors.darkGryClr,
                            child: Center(
                              child: Image.asset(
                                AppIcons.clip,
                                height: SizeConfig.heightMultiplier * 3,
                                width: SizeConfig.heightMultiplier * 3,
                              ),
                            ),
                          ),
                        ),
                        Spacing.x(2),
                        Expanded(
                          child: Container(
                            height: SizeConfig.heightMultiplier * 7,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: AppColors.darkGryClr,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30.0))),
                            padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.widthMultiplier * 2),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Obx(
                                  () => recordCont.isRecording.value
                                      ? const SizedBox()
                                      : recordCont.recordedAudioPath.value != ''
                                          ? FadeIn(
                                              child: AudioWaveBubbleLocal(
                                                suffixIconColor:
                                                    Colors.redAccent,
                                                bubbleSize: Size(
                                                    SizeConfig.widthMultiplier *
                                                        40,
                                                    SizeConfig
                                                            .heightMultiplier *
                                                        6),
                                                noOfSamples: 37,
                                                suffixIcon:
                                                    CupertinoIcons.delete,
                                                suffixOnTap: () => recordCont
                                                    .recordedAudioPath
                                                    .value = '',
                                                path: recordCont
                                                    .recordedAudioPath.value,
                                              ),
                                            )
                                          : SizedBox(
                                              width:
                                                  SizeConfig.widthMultiplier *
                                                      55,
                                              child: TextFormField(
                                                controller: cont.msg,
                                                cursorColor: Colors.white,
                                                keyboardType:
                                                    TextInputType.multiline,
                                                minLines: 1,
                                                maxLines: 6,
                                                style: const TextStyle(
                                                    color: Colors.white),
                                                decoration: InputDecoration(
                                                  hintText: tr(
                                                      'Type your message...'),
                                                  hintStyle: const TextStyle(
                                                      color: Colors.grey),
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                            ),
                                ),
                                const Spacer(),
                                Obx(() =>
                                    recordCont.recordedAudioPath.value != ''
                                        ? const SizedBox()
                                        : RecordBtn(isAddPost: false)),
                                Spacing.x(3),
                                GestureDetector(
                                  onTap: authCont.isLoading.value
                                      ? null
                                      : () async {
                                          cont.showAttachment.value = false;

                                          if (recordCont.recordedAudioPath.value
                                              .isNotEmpty) {
                                            //SEND RECORDING
                                            sendRecording();
                                          } else if (cont.msg.text.isNotEmpty) {
                                            //SEND MSG
                                            cont.sendMsg(msg: cont.msg.text);
                                            cont.msg.clear();
                                          }
                                        },
                                  child: CircleAvatar(
                                    radius: 19,
                                    backgroundColor: AppColors.tileClr,
                                    child: authCont.isLoading.value
                                        ? const CupertinoActivityIndicator(
                                            color: Colors.white)
                                        : Center(
                                            child: Image.asset(
                                              AppIcons.send,
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      3,
                                              width:
                                                  SizeConfig.heightMultiplier *
                                                      3,
                                            ),
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            AnimatedPositioned(
              left: cont.showAttachment.value
                  ? SizeConfig.widthMultiplier * 3.8
                  : -50,
              bottom: SizeConfig.heightMultiplier * 12,
              duration: const Duration(milliseconds: 350),
              child: InkWell(
                onTap: () => picImage(ImageSource.camera),
                child: CircleAvatar(
                  radius: 19,
                  backgroundColor: AppColors.primaryClr,
                  child: const Center(
                    child: Icon(
                      CupertinoIcons.camera,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              left: cont.showAttachment.value
                  ? SizeConfig.widthMultiplier * 3.8
                  : -50,
              bottom: SizeConfig.heightMultiplier * 17.5,
              duration: const Duration(milliseconds: 200),
              child: InkWell(
                onTap: () => picImage(ImageSource.gallery),
                child: CircleAvatar(
                  radius: 19,
                  backgroundColor: AppColors.primaryClr,
                  child: const Center(
                    child: Icon(
                      CupertinoIcons.photo_on_rectangle,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void picImage(ImageSource source) async {
    cont.showAttachment.value = false;
    authCont.isLoading.value = true;

    final img = await ImagePickerService.onImgSelected(source);
    if (img != null) {
      final String base64Image = await ImagePickerService.xFileToBase64(img);

      await cont.sendMsg(
          img: base64Image, imgPath: img.path, msg: cont.msg.text);
      cont.msg.clear();
    }
    authCont.isLoading.value = false;
  }

  void sendRecording() async {
    authCont.isLoading.value = true;
    log(recordCont.recordedAudioPath.value);
    String base64Audio =
        base64Encode(utf8.encode(recordCont.recordedAudioPath.value));
    log(base64Audio);
    await cont.sendMsg(audio: base64Audio);
    recordCont.recordedAudioPath.value = '';
    authCont.isLoading.value = false;
  }
}
