import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:lane_dane/res/colors.dart';
import 'package:lane_dane/view_models/transaction_vm.dart';

class AmountField extends GetView<TransactionVM> {
  AmountField({
    Key? key,
    required TextEditingController controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(TransactionVM());
    TextEditingController amountController = TextEditingController();
    return Obx(
      () => SizedBox(
        width: 24 * controller.length.toInt() +
            48 +
            48 +
            (controller.length.toString().isEmpty ? 24 : 0),
        child: TextFormField(
          onChanged: (String input) {
            controller.updateLength(input.length);
            controller.amount = TextEditingController(text: input).obs;
          },
          maxLines: 1,
          keyboardType: TextInputType.number,
          controller: controller.amount.value,
          decoration: InputDecoration(
            prefixIcon: const Icon(
              Icons.currency_rupee,
              size: 28,
              color: AppColors.label,
            ),
            hintStyle: GoogleFonts.roboto(
              color: const Color(0xFF000000).withOpacity(0.25),
            ),
            hintText: '0',
          ),
          style: const TextStyle(
            fontSize: 48,
          ),
        ),
      ),
    );
  }
}
