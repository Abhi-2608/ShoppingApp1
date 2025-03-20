import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lane_dane/res/colors.dart';
import 'package:lane_dane/utils/colors.dart';
import 'package:lane_dane/utils/extensions/date_time_extension.dart';
import 'package:lane_dane/view_models/transaction_vm.dart';
import 'package:provider/provider.dart';

class DateController extends ChangeNotifier {
  DateTime? _date;

  DateController({DateTime? initial}) {
    _date = initial;
  }

  DateTime? get date {
    return _date;
  }

  bool get isNull {
    return _date == null;
  }

  bool get isNotNull {
    return _date != null;
  }

  set date(DateTime? newDate) {
    _date = newDate;
    notifyListeners();
  }

  String formatDate() {
    if (isNotNull) {
      return _date!.digitOnlyDate();
    } else {
      return '';
    }
  }

  void change(DateTime? newDate) {
    date = newDate;
  }
}

class DateInputField extends GetView<TransactionVM> {
  DateInputField({
    super.key,
  });

  //final TextEditingController _textController = TextEditingController();

  @override
  // void initState() {

  //  controller.date.addListener(update);
  // }

  // // @override
  // // void dispose() {
  // //   widget.dateController.removeListener(update);
  // //   super.dispose();
  // // }

  // void update() {
  //   if (mounted) {
  //     setState(() {});
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Get.put(TransactionVM());

    // _textController.text = controller.formatDate();

    // if (.dateController.isNull) {
    //   return Container();
    // }
    return Obx(
      () => controller.showDate.value
          ? LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
              return Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: constraints.maxWidth - 48,
                    child: Obx(
                      () => TextFormField(
                        controller: TextEditingController(
                            text: controller.formatDate().toString()),
                        decoration: const InputDecoration(
                          isCollapsed: true,
                          disabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.only(bottom: 4),
                        ),
                        style: GoogleFonts.roboto(
                          fontSize: 18,
                        ),
                        enabled: false,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 32,
                    child: IconButton(
                      onPressed: () {
                        controller.showDate.value = false;
                      },
                      icon: Icon(
                        Icons.clear,
                        color: greenColor,
                        size: 32,
                      ),
                    ),
                  ),
                ],
              );
            })
          : Container(),
    );
  }
}

class CalendarIcon extends GetView<TransactionVM> {
  // static const double defaultSize = 24;

  const CalendarIcon({
    super.key,
    // this.size = CalendarIcon.defaultSize,
  });

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    Get.put(TransactionVM());

    return IconButton(
      iconSize: 40,
      icon: const Icon(
        Icons.calendar_today_rounded,
        color: Color.fromRGBO(0, 130, 106, 1),
      ),
      onPressed: () async {
        DateTime? returnedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: today,
          lastDate: today.add(
            const Duration(days: 28),
          ),
          helpText: 'Due Date',
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData(
                primarySwatch: Colors.grey,
                splashColor: AppColors.label,
                colorScheme: ColorScheme.light(
                  primary: greenColor,
                ),
                dialogBackgroundColor: AppColors.bgWhite,
              ),
              child: child ?? Container(),
            );
          },
        );
        if (returnedDate != null) {
          controller.date.value = returnedDate;
          controller.showDate.value = true;
          DateInputField();
        }
      },
    );
  }
}
