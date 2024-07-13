import 'package:doss/constants/colors.dart';
import 'package:doss/controllers/chat.dart';
import 'package:doss/view/pages/chat/components/sender_row_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatListView extends StatelessWidget {
  ChatListView({Key? key, required this.scrollController}) : super(key: key);

  final ScrollController scrollController;
  final cont = Get.find<ChatCont>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("23 Aug"),
        Expanded(
          child: StreamBuilder(
              stream: cont.chatStream(),
              builder: (context, snapshot) {
                if (cont.isChatLoading.value) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryClr,
                      strokeWidth: 2,
                    ),
                  );
                }
                return ListView.builder(
                    reverse: true,
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    controller: scrollController,
                    physics: const BouncingScrollPhysics(),
                    // controller: scrollController,
                    itemCount: cont.chats.value!.length + 1,
                    itemBuilder: (context, index) {
                      if (index == cont.chats.value!.length) {
                        if (cont.onReachesEnd.value ||
                            cont.chats.value!.length < 20) {
                          return const SizedBox();
                        }
                        return Center(
                            child: CircularProgressIndicator(
                                strokeWidth: 2, color: AppColors.primaryClr));
                      }
                      return SenderRowView(
                          chatData: cont.chats.value![index], index: index);
                      // : ReceiverRowView(
                      //     receiverMessage: cont.messageList[index].message),
                    });
              }),
        ),
      ],
    );
  }
}
