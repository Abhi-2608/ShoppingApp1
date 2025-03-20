import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lane_dane/view_models/user_transaction_vm.dart';
import 'package:lane_dane/views/sms/widgets/user_transaction_single_chats_list_tile.dart';

class UserTransactionIndex extends GetView<UserTransactionVM> {
  static const String routeName = 'user-transactions';

  const UserTransactionIndex({
    Key? key,
  }) : super(key: key);

  // Future<void> refresh() async {
  //   await appController.retrieveTransactionsFromServer();
  //   appController.resendFailedTransactions();
  // }
  //
  // void updateUserGroupEntityList(Query<UserGroupEntity> query) {
  //   setState(() {
  //     entityList = query.find();
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    Get.put(UserTransactionVM());
    final Size size = MediaQuery.of(context).size;
    final double topPadding =
        Get.statusBarHeight + kToolbarHeight + kToolbarHeight;

    if (controller.entityList.isEmpty) {
      return Container(
        height: size.height - topPadding,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        alignment: Alignment.center,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            PromptText(),
          ],
        ),
      );
    }
    return SizedBox(
      height: size.height,
      child: SingleChildScrollView(
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: const ScrollPhysics(),
          itemCount: controller.entityList.length,
          itemBuilder: (context, index) {
            return UserTransactionSingleChatsLIstTile(
              entity: controller.entityList[index],
            );
          },
        ),
      ),
    );
  }
}

class PromptText extends StatefulWidget {
  const PromptText({Key? key}) : super(key: key);

  @override
  State<PromptText> createState() => _PromptTextState();
}

class _PromptTextState extends State<PromptText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  );
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(1.5, 0),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  ));

  @override
  void initState() {
    super.initState();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle messageStyle = GoogleFonts.roboto(
      letterSpacing: 0.9,
      color: const Color(0xFF248A41),
      fontWeight: FontWeight.bold,
      fontSize: 22,
    );
    return SlideTransition(
      position: _offsetAnimation,
      child: Container(
        child: Column(
          children: [
            Text(
              'user_transaction_animated_text_1'.tr,
              textAlign: TextAlign.center,
              style: messageStyle,
            ),
          ],
        ),
      ),
    );
  }
}
