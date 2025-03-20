// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:lane_dane/main.dart';
// import 'package:lane_dane/models/categories_model.dart';
// import 'package:lane_dane/models/personal_transaction.dart';
// import 'package:lane_dane/models/user_transaction.dart';
// import 'package:lane_dane/utils/colors.dart';
// import 'package:lane_dane/view_models/personal_tx_vm.dart';
// import 'package:lane_dane/views/select_contact/contact_permission.dart';
// import 'package:lane_dane/widgets/amount_field.dart';
// import 'package:lane_dane/widgets/custom_toggle_button.dart';
// import 'package:lane_dane/widgets/date_selector.dart';

// // * ↠ ↠ ↠ AddTransaction screen for SMS ↠ ↠ ↠
// class PersonalTnxDetailIndex extends GetView<PersonalTransactionVM> {
//   static const String routeName = 'add-transaction-screen';
//   PersonalTransaction personalTnx;

//   PersonalTnxDetailIndex({
//     super.key,
//     required this.personalTnx,
//   });

//   late final TextEditingController _descriptionController =
//       TextEditingController();
//   late final DateController dueDateController = DateController();
//   late final List<CategoriesModel> _categories;
//   late final ValueNotifier<CategoriesModel?> _categorySelected =
//       ValueNotifier(null);
//   late final ValueNotifier<String> transactionType = ValueNotifier('lane');
//   late final ValueNotifier<String> paymentStatus = ValueNotifier(
//     'online',
//   );
//   late Widget profilePicture;
//   final int _counterForTrackingNumberOfTransactionsCreated = 0;

//   final List<String> transactionTypeList = [
//     TransactionType.Lane.name,
//     TransactionType.Dane.name,
//   ];

//   final List<String> paymentStatusList = [
//     PaymentStatus.cash.name,
//     PaymentStatus.online.name,
//     PaymentStatus.Due.name,
//     PaymentStatus.Done.name,
//   ];
//   String due = PaymentStatus.Due.name;

//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;

//     callFunction() {
//       controller.addTransactions;
//     }

//     return Scaffold(
//       // resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(
//           'add_transaction'.tr,
//           style: const TextStyle(
//             color: AppColors.bgWhite,, // Change text color to white
//           ),
//         ),
//         backgroundColor: const Color(0xFF128C7E),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios),
//           onPressed: () {
//             Get.back();
//           },
//         ),
//       ),

//       floatingActionButton: Builder(
//         builder: (context) => Padding(
//           padding: const EdgeInsets.symmetric(
//             horizontal: 10.0,
//           ),
//           child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
//             FloatingActionButton(
//               heroTag: "AddTransactionClass",
//               onPressed: () {
//                 Get.to(ContactPermissionView());
//               },
//               backgroundColor: lightGreenColor,
//               child: const Icon(
//                 Icons.check,
//                 color: AppColors.bgWhite,, // Change the color to white
//               ),
//             )
//           ]),
//         ),
//       ),
//       persistentFooterAlignment: AlignmentDirectional.bottomCenter,
//       body: Builder(
//         builder: (context) {
//           return Container(
//             height: size.height -
//                 MediaQuery.of(context).viewInsets.top -
//                 Scaffold.of(context).appBarMaxHeight!,
//             width: size.width,
//             alignment: Alignment.center,
//             margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 40),
//             child: SingleChildScrollView(
//               physics: const BouncingScrollPhysics(),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   const SizedBox(height: 10),
//                   const SizedBox(height: 10),
//                   const SizedBox(height: 20),
//                   AmountField(),
//                   const SizedBox(height: 30),
//                   TextField(
//                     onChanged: (value) {
//                       controller.description = value.obs;
//                     },
//                     autofocus: true,
//                     decoration: InputDecoration(
//                       suffixIcon: Icon(
//                         Icons.description,
//                         size: 40,
//                         color: greenColor,
//                       ),
//                       labelText: 'description'.tr,
//                       labelStyle:
//                           const TextStyle(color: AppColors.label, fontSize: 18),
//                       iconColor: greenColor,
//                       border: UnderlineInputBorder(
//                         borderSide: BorderSide(
//                           color: greenColor,
//                         ),
//                       ),
//                       hintText: 'description'.tr,
//                       hintStyle: const TextStyle(
//                         fontSize: 18,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 30),
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text(
//                       'transaction_type'.tr,
//                       textAlign: TextAlign.left,
//                       style:
//                           GoogleFonts.roboto(color: AppColors.label, fontSize: 18),
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   CustomToggleButtons(
//                     initialSelection: transactionType.value,
//                     options:
//                         TransactionType.values.map<String>((TransactionType t) {
//                       return t.name.toLowerCase().tr;
//                     }).toList(),
//                     onSelect: (int index) {
//                       controller.transactionType =
//                           transactionTypeList[index].obs;
//                       talker.debug(
//                           "@AddTransaction : build() ⇢  ${transactionTypeList[index]}");
//                     },
//                   ),
//                   const SizedBox(height: 20),
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text(
//                       'Payment Type'.tr,
//                       textAlign: TextAlign.left,
//                       style:
//                           GoogleFonts.roboto(color: AppColors.label, fontSize: 18),
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   Column(
//                     children: [
//                       CustomToggleButtons(
//                         initialSelection: paymentStatus.value,
//                         options:
//                             PaymentStatus.values.map<String>((PaymentStatus s) {
//                           return s.name.toLowerCase().tr;
//                         }).toList(),
//                         onSelect: (int index) {
//                           controller.paymentStatus.value =
//                               paymentStatusList[index];
//                           talker.debug(
//                               "@AddTransaction : build() ⇢  ${controller.paymentStatus}");
//                         },
//                       ),
//                       const SizedBox(height: 10),

//                       // TextField(
//                       Obx(() {
//                         return controller.paymentStatus.toString() == due
//                             ? Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Align(
//                                     alignment: Alignment.centerLeft,
//                                     child: Text(
//                                       'due_date'.tr,
//                                       textAlign: TextAlign.left,
//                                       style: GoogleFonts.roboto(
//                                         color: AppColors.label,
//                                         fontSize: 18,
//                                       ),
//                                     ),
//                                   ),
//                                   CalendarIcon(
//                                     controller: controller,
//                                   ),
//                                 ],
//                               )
//                             : Container();
//                       }),
//                       Obx(
//                         () => controller.paymentStatus.toString() == due
//                             ? const DateInputField()
//                             : Container(),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 15),
//                   const SizedBox(height: 100),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// Widget _addCategoryButton(
//   BuildContext context,
//   List<CategoriesModel> categories,
//   ValueNotifier<CategoriesModel?> categorySelected,
// ) {
//   return InkWell(
//     onTap: () async {},
//     child: SizedBox(
//       height: 50,
//       width: 230,
//       child: Card(
//         color: AppColors.bgWhite,70,
//         child: Center(
//           child: ValueListenableBuilder(
//             valueListenable: categorySelected,
//             builder:
//                 (BuildContext context, CategoriesModel? value, Widget? child) {
//               String selectedVal = 'add_category'.tr;
//               if (categorySelected.value != null) {
//                 selectedVal = categorySelected.value!.message;
//               }
//               return Text(selectedVal);
//             },
//           ),
//         ),
//       ),
//     ),
//   );
// }
