import 'dart:convert';
import 'dart:developer';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:doss/constants/api.dart';
import 'package:doss/constants/cont.dart';
import 'package:doss/models/chat.dart';
import 'package:doss/services/api.dart';
import 'package:doss/view/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatCont extends GetxController {
  RxInt currentPage = 1.obs;
  RxBool isChatLoading = true.obs;
  RxBool isRequestLoading = false.obs;
  RxBool onReachesEnd = false.obs;
  TextEditingController msg = TextEditingController();
  Rxn<List<Chats>> chats = Rxn<List<Chats>>();
  Rxn<List<Chats>> newChats = Rxn<List<Chats>>();

  // List<MessageData> messageList = [];
  RxBool showAttachment = false.obs;
  //FOR AUDIO MSGS
  Rxn<Map<String, PlayerController>> playerConts =
      Rxn<Map<String, PlayerController>>();
  RxString playingMsg = ''.obs;
  void playAudio(PlayerController player, String id) async {
    if (player.playerState.isPlaying) {
      await player.pausePlayer();
    } else {
      playingMsg.value = id;
      await player.startPlayer(finishMode: FinishMode.pause);
    }
  }

  //INITIALIZE PLAYER
  void initializePlayer(String id, PlayerController controller) {
    playerConts.value![id] = controller;
  }

//CONVERT IMAGE INTO BASE64
  

  Future<void> sendMsg(
      {String? msg, String? imgPath, String? img, String? audio}) async {
    authCont.isLoading.value = true;
    try {
      var body = {
        "residentialVerificationRequestId":
            verificationCont.verificationID.value,
        "message": msg,
        "photo": img,
        "Audio": audio
      };
      //ADD IN FRONTEND FIRST

      if (audio == null && img==null) {
        log("ADDED $imgPath");
        Chats data = Chats(
            id: 'local',
            userId: authCont.userInfo!.sub,
            message: msg,
            photoUrl: imgPath ?? '',
            when: DateTime.now().toString(),
            audioUrl: audio ?? '');
        chats.value!.insert(0, data);
        chats.refresh();
      }
      log("MESSAGE $msg");
      if (msg != '' && msg != null) {
        authCont.isLoading.value = false;
      }
      //THEN SEND TO SERVER
      final response = await ApiService.post(
          endPoint: ApiUrls.endpoint + ApiUrls.verificationchatURL,
          accessToken: authCont.accessToken.value,
          body: body);

      if (response != null) {
        if (response.statusCode == 200) {
          await getChat();
        } else {
          showCustomSnackbar(true, "Something went wrong");
        }
      } else {
        showCustomSnackbar(true, "Something went wrong");
      }
    } catch (e) {
      showCustomSnackbar(true, "Something went wrong");
      debugPrint(e.toString());
    } finally {
      authCont.isLoading.value = false;
    }
  }

  Stream chatStream() {
    return Stream.periodic(const Duration(seconds: 1)).asyncMap((_) async {
      await getChat();
    });
  }

  Future<List<Chats>?> getChat() async {
    try {
      log('CURRENT PAGE ${currentPage.value}');
      final response = await ApiService.get(
        endPoint:
            "${ApiUrls.endpoint}${ApiUrls.verificationChatMsgURL}${verificationCont.verificationID.value}&page=${currentPage.value}&count=20",
        accessToken: authCont.accessToken.value,
      );

      if (response != null) {
        if (response.statusCode == 200) {
          ChatModel model = ChatModel.fromJson(jsonDecode(response.body));
          if (model.data!.chats!.isEmpty) {
            onReachesEnd.value = true;
          }
          //REMOVE LOCAL MESSAGES
          for (int i = 0; i < chats.value!.length; i++) {
            if (chats.value![i].id == 'local') {
              log("FOUND");
              chats.value!.removeAt(i);
            }
          }

          playerConts.value!.removeWhere((key, value) => key == 'local');

          //ADD REAL TIME DATA
          for (var element in model.data!.chats!) {
            if (!isIdPresentInList(chats.value!, element)) {
              chats.value!.add(element);
            }
          }

          log("LENGTH ${chats.value!.length}");
          chats.value!.sort((a, b) => a.when!.compareTo(b.when!));
          chats.value = chats.value!.reversed.toList();
          return chats.value!;
        } else {
          showCustomSnackbar(true, "Something went wrong");
        }
      } else {
        showCustomSnackbar(true, "Something went wrong");
      }
    } catch (e) {
      print(e);
      showCustomSnackbar(true, "Something went wrong");
    } finally {
      isChatLoading.value = false;
    }
  }

  static bool isIdPresentInList(List<Chats> list, Chats element) {
    return list.any((chat) => chat.id == element.id && chat.id != 'local');
  }

  //MAKE RESOLUTION DONE
  Future<void> requestResolution(String verificationID) async {
    try {
      isRequestLoading.value = true;
      final response = await ApiService.put(
          endPoint:
              '${ApiUrls.endpoint}verification-request/$verificationID/status/Done',
          accessToken: authCont.accessToken.value);
      if (response!.statusCode == 200) {
        Get.back(result: 'refresh');
      } else {
        showCustomSnackbar(true, "Something went wrong");
      }
    } catch (e) {
      log(e.toString());
      showCustomSnackbar(true, "Something went wrong");
    } finally {
      isRequestLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    playerConts.value = {};
    chats.value = [];
  }
}
