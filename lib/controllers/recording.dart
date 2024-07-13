import 'package:get/get.dart';

class RecordingCont extends GetxController{
  RxBool isRecording=false.obs;
  RxString recordedAudioPath=''.obs;
  int durationInSeconds=0;
}