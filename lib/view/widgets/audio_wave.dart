import 'dart:async';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:doss/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';

class AudioWaveBubbleLocal extends StatefulWidget {
  final String path;
  final int noOfSamples;
  final IconData suffixIcon;
  final Size bubbleSize;
  final Color? backgroundColor;
  final Color suffixIconColor;
  final VoidCallback? suffixOnTap;
  const AudioWaveBubbleLocal({
    Key? key,
    required this.path,
    required this.noOfSamples,
    required this.suffixIcon,
    required this.bubbleSize,
    this.suffixOnTap,
    this.backgroundColor,
    required this.suffixIconColor,
  }) : super(key: key);

  @override
  State<AudioWaveBubbleLocal> createState() => _AudioWaveBubbleLocalState();
}

class _AudioWaveBubbleLocalState extends State<AudioWaveBubbleLocal> {
  late PlayerController playerCont;
  late StreamSubscription<PlayerState> playerStateSubscription;

  @override
  void initState() {
    super.initState();
    playerCont = PlayerController();
    _preparePlayer();
    playerStateSubscription = playerCont.onPlayerStateChanged.listen((_) {
      setState(() {});
    });
  }

  void _preparePlayer() async {
    playerCont.preparePlayer(
      noOfSamples: widget.noOfSamples,
      path: widget.path,
      shouldExtractWaveform: true,
    );
  }

  void _onPlay() async {
    if (playerCont.playerState.isPlaying) {
      await playerCont.pausePlayer();
    } else {
      await playerCont.startPlayer(
        finishMode: FinishMode.pause,
      );
    }
  }

  @override
  void dispose() {
    playerStateSubscription.cancel();
    playerCont.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: FadeIn(
        duration: const Duration(milliseconds: 300),
        child: Container(
          height: SizeConfig.heightMultiplier * 5,
          decoration: BoxDecoration(boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 6)
          ], color: Colors.black, borderRadius: BorderRadius.circular(46)),
          padding:
              EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //PLAY OR PAUSE BUTTON
              if (!playerCont.playerState.isStopped)
                InkWell(
                  onTap: () => _onPlay(),
                  child: SizedBox(
                    height: SizeConfig.heightMultiplier * 6,
                    width: SizeConfig.widthMultiplier * 6,
                    child: CircleAvatar(
                      radius: SizeConfig.widthMultiplier * 4,
                      backgroundColor: Colors.grey.shade300,
                      child: Icon(
                          playerCont.playerState.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: Colors.black,
                          size: 24),
                    ),
                  ),
                ),
              //WAVES
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.widthMultiplier * 2),
                child: AudioFileWaveforms(
                  enableSeekGesture: false,
                  size: widget.bubbleSize,
                  playerController: playerCont,
                  waveformType: WaveformType.fitWidth,
                  playerWaveStyle:  PlayerWaveStyle(
                    fixedWaveColor:Colors.grey.shade800,
                    liveWaveColor: Colors.grey,
                    spacing: 6,
                  ),
                ),
              ),
              //SUFFIX BUTTON
              InkWell(
                onTap: widget.suffixOnTap,
                child: SizedBox(
                  height: SizeConfig.heightMultiplier * 6,
                  width: SizeConfig.widthMultiplier * 7,
                  child: Icon(widget.suffixIcon,
                      size: 20, color: widget.suffixIconColor),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
