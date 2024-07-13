import 'dart:developer';

import 'package:doss/constants/colors.dart';
import 'package:doss/controllers/chat.dart';
import 'package:doss/models/chat.dart';
import 'package:doss/services/cache.dart';
import 'package:doss/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter_fadein/flutter_fadein.dart';

class AudioMsgTile extends StatefulWidget {
  const AudioMsgTile({
    Key? key,
    required this.index,
    required this.data,
  }) : super(key: key);
  final int index;
  final Chats data;
  @override
  State<AudioMsgTile> createState() => _AudioMsgTileState();
}

class _AudioMsgTileState extends State<AudioMsgTile> {
  final cont = Get.find<ChatCont>();
  late PlayerController playerCont;
  StreamSubscription<PlayerState>? playerStateSubscription;
  String? path;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      path = await CacheService.getCachePath(widget.data!.audioUrl!);
      log("PATHS ${path}");
      playerCont = PlayerController();
      cont.initializePlayer(widget.data.id!, playerCont);

      await _preparePlayer();
      playerStateSubscription = cont
          .playerConts.value![widget.data.id]!.onPlayerStateChanged
          .listen((_) {
        setState(() {});
      });
    });
  }

  Future<void> _preparePlayer() async {
    log("AAAA ${path}");
    cont.playerConts.value![widget.data.id]!.preparePlayer(
      noOfSamples: 80,
      path: path!,
      shouldExtractWaveform: true,
    );
    setState(() {});
  }

  @override
  void dispose() {
    Future.delayed(Duration.zero, () {
      cont.playerConts.value![widget.data.id]?.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Obx(
      () => FadeIn(
        duration: const Duration(milliseconds: 300),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: SizeConfig.heightMultiplier * 6,
          width: cont.playerConts.value![widget.data.id] == null
              ? size.width * 0.12
              : size.width * 0.72,
          decoration: BoxDecoration(
              color: Colors.black87, borderRadius: BorderRadius.circular(26)),
          padding: EdgeInsets.only(left: SizeConfig.widthMultiplier * 1),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //PLAY OR PAUSE BUTTON
                  SizedBox(
                    height: size.height * 0.05,
                    width: size.width * 0.1,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        InkWell(
                          onTap: () async {
                            for (int i = 0; i < cont.chats.value!.length; i++) {
                              if (cont.chats.value![i].id == widget.data.id) {
                                if (cont.chats.value![i].audioUrl != '') {
                                  cont.playerConts
                                      .value![cont.chats.value![i].id]!
                                      .pausePlayer();
                                }
                              }
                            }
                            cont.playAudio(
                                cont.playerConts.value![widget.data.id!]!, '');

                            setState(() {});
                          },
                          child: SizedBox(
                            height: SizeConfig.heightMultiplier * 6,
                            width: SizeConfig.widthMultiplier * 8,
                            child: CircleAvatar(
                              radius: SizeConfig.widthMultiplier * 4,
                              backgroundColor: Colors.grey.shade900,
                              child: Icon(
                                  cont.playerConts.value![widget.data.id] ==
                                          null
                                      ? Icons.play_arrow
                                      : cont.playerConts.value![widget.data.id]!
                                              .playerState.isPlaying
                                          ? Icons.pause
                                          : Icons.play_arrow,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        cont.playerConts.value![widget.data.id] != null
                            ? const CircularProgressIndicator(
                              
                                strokeWidth: 2, color: Colors.white)
                            : const SizedBox()
                      ],
                    ),
                  ),
                  //WAVES
                  cont.playerConts.value![widget.data.id] == null
                      ? const SizedBox()
                      : Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.widthMultiplier * 2),
                          child: AudioFileWaveforms(
                            enableSeekGesture: false,
                            size: Size(SizeConfig.widthMultiplier * 42,
                                SizeConfig.heightMultiplier * 5),
                            playerController:
                                cont.playerConts.value![widget.data.id]!,
                            waveformType: WaveformType.fitWidth,
                            playerWaveStyle: PlayerWaveStyle(
                              waveThickness: 2,
                              fixedWaveColor: Colors.grey.shade400,
                              liveWaveColor: AppColors.primaryClr,
                              spacing: 3,
                            ),
                          ),
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
