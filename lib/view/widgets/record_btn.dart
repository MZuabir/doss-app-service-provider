import 'dart:async';
import 'package:doss/constants/icons.dart';
import 'package:doss/controllers/recording.dart';
import 'package:doss/utils/size_config.dart';
import 'package:doss/view/widgets/custom_snackbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:get/get.dart';
import 'package:record/record.dart';

class RecordBtn extends StatefulWidget {
  RecordBtn({
    super.key,
    required this.isAddPost,
  });
  final bool isAddPost;
  @override
  State<RecordBtn> createState() => _RecordBtnState();
}

class _RecordBtnState extends State<RecordBtn>
    with SingleTickerProviderStateMixin {
  final cont = Get.find<RecordingCont>();
  int _recordDuration = 0;
  Timer? _timer;
  final _audioRecorder = Record();
  StreamSubscription<RecordState>? _recordSub;
  RecordState _recordState = RecordState.stop;
  StreamSubscription<Amplitude>? _amplitudeSub;
  Amplitude? _amplitude;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    //FOR ANIMATION
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_controller);

    _controller.addListener(() {
      setState(() {});
    });
    //FOR RECORDING
    _recordSub = _audioRecorder.onStateChanged().listen((recordState) {
      setState(() => _recordState = recordState);
    });

    _amplitudeSub = _audioRecorder
        .onAmplitudeChanged(const Duration(milliseconds: 300))
        .listen((amp) => setState(() => _amplitude = amp));
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    _recordSub?.cancel();
    _amplitudeSub?.cancel();
    _audioRecorder.dispose();
    super.dispose();
  }

  //START RECORDING
  Future<void> _startRecording() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        await _audioRecorder.start();
        _recordDuration = 0;

        _startTimer();
        cont.isRecording.value = true;
        _controller.forward();
      } else {
        showCustomSnackbar(true,
            'Please give permission for mircophone by going into settings of your phone');
      }
    } catch (e) {
      print(e);
      if (kDebugMode) {
        print(e);
      }
    }
  }

  //STOP RECORDING
  Future<void> _stopRecording() async {
    _timer?.cancel();
    cont.durationInSeconds = _recordDuration.seconds.inSeconds;
    _recordDuration = 0;
    _controller.reverse();

    cont.isRecording.value = false;
    final path = await _audioRecorder.stop();

    if (path != null) {
      //WHEN AUDIO IS DONE
      cont.recordedAudioPath.value = path;
    }
  }

  //TIMER
  void _startTimer() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() => _recordDuration++);
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Obx(
      () => SizedBox(
        height: SizeConfig.heightMultiplier * 7,
        width: cont.isRecording.value
            ? SizeConfig.widthMultiplier * 60
            : SizeConfig.widthMultiplier * 10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //RECORDING DURATION
            cont.isRecording.value ? _buildTimer(textTheme) : const SizedBox(),

            //BUTTON
            InkWell(
                onTap: () => !cont.isRecording.value
                    ? _startRecording()
                    : _recordDuration.seconds.inSeconds > 1
                        ? _stopRecording()
                        : null,
                child: RotationTransition(
                  turns: _animation,
                  child: cont.isRecording.value
                      ? const Icon(Icons.done, size: 30, color: Colors.white)
                      : Image.asset(
                          AppIcons.microPhone,
                          height: SizeConfig.heightMultiplier * 3.5,
                          width: SizeConfig.heightMultiplier * 3.5,
                        ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildTimer(TextTheme textTheme) {
    final String minutes = _formatNumber(_recordDuration ~/ 60);
    final String seconds = _formatNumber(_recordDuration % 60);

    return FadeIn(
      duration: const Duration(milliseconds: 300),
      child: SizedBox(
        width: SizeConfig.widthMultiplier * 15,
        child: Text('$minutes : $seconds',
            style: textTheme.bodyMedium!.copyWith(
                color: Colors.redAccent, fontWeight: FontWeight.w500)),
      ),
    );
  }

  String _formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0$numberStr';
    }

    return numberStr;
  }
}
