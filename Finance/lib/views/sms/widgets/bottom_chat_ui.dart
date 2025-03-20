import 'package:flutter/material.dart';
import 'package:lane_dane/models/user_transaction.dart';
import 'package:lane_dane/res/colors.dart';
import 'package:lane_dane/utils/assets.dart';

// import 'package:lane_dane/views/pages/transaction_reminder_setting.dart';

// import '../../api/whatsapp.dart';
import '../../../models/users.dart';

class BottomChatField extends StatelessWidget {
  final Users user;
  final List<UserTransaction> transactionList;
  final Map<String, dynamic> me;

  const BottomChatField({
    super.key,
    required this.user,
    required this.transactionList,
    required this.me,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // final log = getLogger('BottomChatField');
    FocusNode focusNode = FocusNode();
    final TextEditingController messageController = TextEditingController();

    return Row(
      children: [
        Expanded(
          child: Opacity(
            opacity: 0.0,
            child: TextFormField(
              focusNode: focusNode,
              controller: messageController,
              onChanged: (val) {
                // log.d(val);
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SizedBox(
                    width: size.width * 0.1,
                    child: IconButton(
                      onPressed: () {
                        // toggleEmojiKeyboardContainer
                      },
                      icon: const Icon(
                        Icons.emoji_emotions,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                hintText: 'Type a message!',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                contentPadding: const EdgeInsets.all(10),
              ),
            ),
          ),
        ),
        Opacity(
          opacity: 0.0,
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 8,
              right: 2,
              left: 2,
            ),
            child: CircleAvatar(
              backgroundColor: const Color(0xFF128C7E),
              radius: 22,
              child: GestureDetector(
                child: const Icon(
                  Icons.send,
                  color: AppColors.bgWhite,
                ),
                onTap: () {
                  // sendTextMessage
                  // log.d(transactionList.last.amount);
                },
              ),
            ),
          ),
        ),
        //
        Padding(
          padding: const EdgeInsets.only(
            bottom: 8,
            right: 2,
            left: 2,
          ),
          child: CircleAvatar(
            backgroundColor: const Color(0xFF128C7E),
            radius: 22,
            child: GestureDetector(
              child: const Icon(
                Icons.schedule_outlined,
                size: 28,
                color: AppColors.bgWhite,
              ),
              onTap: () async {
                // AppController appController = Get.find();

                // if (!appController.user.isPremium) {
                //   await Navigator.of(context)
                //       .pushNamed(PremiumDetails.routeName);
                // }

                // if (appController.user.isPremium) {
                //   await Navigator.of(context)
                //       .pushNamed(TransactionReminderSetting.routeName);
                // }
                /**
                 * The above code is the flow for premium accounts.
                 * For now all users have access to this screen.
                 */

                // Navigator.of(context).pushNamed(
                //   TransactionReminderSetting.routeName,
                //   arguments: {
                //     'transactions': transactionList,
                //   },
                // );
              },
            ),
          ),
        ),
        //
        Padding(
          padding: const EdgeInsets.only(
            bottom: 8,
            right: 2,
            left: 2,
          ),
          child: CircleAvatar(
            backgroundColor: const Color(0xFF128C7E),
            radius: 22,
            child: GestureDetector(
              child: Image.asset(Assets.imagesWhatsappIcon,
                  height: 22 // TODO: whatsapp icon here
                  ),
              onTap: () async {
                // Send Whatsapp Message to the user
                //  "https://wa.me/${number}?text=Hello";
                // final res = await WhatsappHelper().send(
                //     context: context,
                //     phone: int.parse(user.phoneWithCode),
                //     message:
                //         '${me['full_name']} is inviting you to confirm transaction on the LaneDane app. ${Constants.kAppLink}');
                // log.e(res);
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            bottom: 8,
            right: 2,
            left: 2,
          ),
          child: CircleAvatar(
            backgroundColor: const Color(0xFF128C7E),
            radius: 22,
            child: GestureDetector(
                child: const Icon(
                  Icons.add,
                  color: AppColors.bgWhite,
                ),
                onTap: () {
                  // final result = z
                  //     AddTransaction.routeName,
                  //     arguments: {'contact': user});
                  // if (!context.mounted) return;
                  // result.then((value) {
                  //   if (value != null) {
                  //     final transaction = value as TransactionsModel;
                  //     talker.debug(
                  //         "@BottomChatField : build() : You pressed the add Tnx button and came back with this tnx : ${transaction.id} for ${transaction.description} ");
                  //     transactionList.add(transaction);
                  //   }
                  // });
                }),
          ),
        )
      ],
    );
    // isShowEmojiContainer
    //     ? SizedBox(
    //         height: 310,
    //         child: EmojiPicker(
    //           onEmojiSelected: ((category, emoji) {
    //             setState(() {
    //               _messageController.text =
    //                   _messageController.text + emoji.emoji;
    //             });

    //             if (!isShowSendButton) {
    //               setState(() {
    //                 isShowSendButton = true;
    //               });
    //             }
    //           }),
    //         ),
    //       )
    //     : const SizedBox(),
  }
}
