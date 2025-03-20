import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lane_dane/main.dart';
import 'package:lane_dane/models/categories_model.dart';
import 'package:lane_dane/models/user_transaction.dart';
import 'package:lane_dane/res/colors.dart';

import 'package:lane_dane/utils/colors.dart';
import 'package:lane_dane/utils/constants.dart';
import 'package:lane_dane/view_models/transaction_vm.dart';
import 'package:lane_dane/view_models/user_transaction_vm.dart';
import 'package:lane_dane/views/sms/widgets/amount_field.dart';
import 'package:lane_dane/views/sms/widgets/custom_toggle_button.dart';
import 'package:lane_dane/views/sms/widgets/date_selector.dart';

class UserTransactionCreate extends GetView {
  TextEditingController amountController = TextEditingController();
  int length = 0;

  /// Add transaction screen where the auth user can create new transactions.
  /// Only the target contact is required, while all other fields are optional.
  ///
  /// Pass arguments to the screen as follows:
  /// ```dart
  /// {
  ///   'contact': (Users),
  ///   'all_transaction_id': (int),
  ///   'transaction_id': (int),
  ///   'amount': (int),
  ///   'transaction_type': (TransactionType),
  ///   'payment_status': (PaymentStatus),
  ///   'category_id': (int),
  /// }
  /// ```
  /// when navigating using named routes. Here the ['contact'] is the user for
  /// whom the transaction will be created. ['all_transaction_id'] is the id of
  /// the existing all transaction entry that will reference the transaction
  /// that will be created. ['transaction_id'] is the id of an existing
  /// transaction that indicating that the screen is in edit mode instead of
  /// create transaction  mode.['amount'] is the default amount to be entered
  /// into the amount field when the screen renders. ['transaction_type'] is the
  /// default transaction type selection that is to be set when the screen
  /// renders. ['payment_status'] is the default payment status option that
  /// will be selected when the screen renders. ['category_id'] is the default
  /// category that will be selected when the screen renders. Only ['contact']
  /// required, while all other fields can be skipped.
  static const String routeName = 'user-transaction-screen';

  // final Users contact;
  // final int? allTransactionId;
  // final int? transactionId;
  // final int? amount;
  // final String? description;
  // final TransactionType? transactionType;
  // final PaymentStatus? paymentStatus;
  // final int? categoryId;

//   @override
//   State<AddTransaction> createState() => _AddTransactionState();
// }

  // AppController appController = Get.find();
  late final DateController dueDateController = DateController();
  late final ValueNotifier<String> transactionType = ValueNotifier('lane');
  late final ValueNotifier<String> paymentStatus = ValueNotifier(
    'online',
  );
  late Widget profilePicture;
  final int _counterForTrackingNumberOfTransactionsCreated = 0;

  // @override
  // void initState() {
  //   super.initState();
  //   // FirebaseAnalytics.instance.setCurrentScreen(
  //   //   screenName: AddTransaction.routeName,
  //   // );
  //   // fetchCategories();

  // // if (widget.categoryId != null) {
  // //   _categorySelected.value =
  // //       CategoryController().retrieve(widget.categoryId!);
  // // }

  // _descriptionController.text = '';
  // profilePicture = ProfilePicture(
  //   count: 1,
  //   name: "Contact Name",
  //   radius: 48,
  //   fontsize: 28,
  //   random: true,
  // );

  //   @override
  //   Widget build(BuildContext context) {
  // // TODO: implement build
  // throw UnimplementedError();
  //   }

  // @override
  // void dispose() {
  //   // _amountController.dispose();
  //   // dueDateController.dispose();
  //   // transactionType.dispose();
  //   // paymentStatus.dispose();
  //   super.dispose();
  // }

  final List<String> transactionTypeList = [
    TransactionType.Lane.name,
    TransactionType.Dane.name,
  ];

  final List<String> paymentStatusList = [
    PaymentStatus.cash.name,
    PaymentStatus.online.name,
    PaymentStatus.Due.name
  ];
// String due = PaymentStatus.Due.name;
  // ! DUMMY for now later to be fetched from server
  // void fetchCategories() {
  //   CategoryController controller = CategoryController();
  //   _categories = [];
  //   _categories.addAll(controller.retrieveAll());
  // }

  // bool validateAmount() {
  //   if (_amountController.text.isEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text('Enter a valid amount', style: GoogleFonts.roboto()),
  //     ));
  //     return false;
  //   }
  //   int amount = double.parse(_amountController.text).toInt();
  //   if (amount.isNegative) {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text('Amount cannot be negative', style: GoogleFonts.roboto()),
  //     ));
  //     return false;
  //   }
  //   if (amount == 0) {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content:
  //           Text('Amount cannot be less than one', style: GoogleFonts.roboto()),
  //     ));
  //     return false;
  //   }
  //   return true;
  // }

  // Future<void> addSmsTnx() async {
  //   // final user = await _storageHelper.user();
  //   // print(user['id']);

  //   // * We have the amount -> So update the AllTransaction Table
  //   // TODO Add it to Transaction Table

  //   if (!validateAmount()) {
  //     return;
  //   }

  //   talker.debug(
  //       "@AddTransaction : addSmsTnx() ⇢ Adding transaction to DB with description : ${widget.description!} and amount : ${_amountController.text}");

  //   /*
  // * Incase we navigated to this screen via clikcing a SMS transaction,
  // * It will already have a description. So we will use the
  // * description from the SMS

  // * Thats why there is a check for widget.description
  // */
  //   appController.createTransaction(
  //     amount: _amountController.text,
  //     contact: widget.contact,
  //     description: widget.description == ''
  //         ? _descriptionController.text
  //         : widget.description!,
  //     paymentStatus: paymentStatus.value,
  //     transactionType: transactionType.value,
  //     category: _categorySelected.value,
  //     createdAt: DateTime.now(),
  //     existingAllTransactionId: widget.allTransactionId,
  //     updatedAt: DateTime.now(),
  //   );
  // }

  // Future<TransactionsModel?> addPersonalTnx() async {
  //   // * We don't have the amount -> So add the Transaction to Transaction Table
  //   if (!validateAmount()) {
  //     return null;
  //   }

  //   talker.debug(
  //       "@AddTransaction : addPersonalTnx() ⇢ Adding transaction to DB with description : ${_descriptionController.text} and amount : ${_amountController.text}");

  //   TransactionsModel transaction = appController.createTransaction(
  //     amount: _amountController.text,
  //     contact: widget.contact,
  //     description: _descriptionController.text,
  //     paymentStatus: paymentStatus.value,
  //     transactionType: transactionType.value,
  //     category: _categorySelected.value,
  //     createdAt: DateTime.now(),
  //     existingAllTransactionId: widget.allTransactionId,
  //     updatedAt: DateTime.now(),
  //     dueDate: dueDateController.date,
  //   );

  //   talker.info(
  //       "@AddTransaction : addSmsTnx() ⇢ i called createTransaction, this is what it returned ${transaction.description} and ${transaction.amount} for id ${transaction.serverId} and {${transaction.id}}");

  //   if (!kDebugMode) {
  //     final res = await WhatsappHelper().send(
  //       context: context,
  //       phone: int.parse(widget.contact.phoneWithCode),
  //       message: 'new_transaction_message'.trParams({
  //             'name': appController.user!.fullName,
  //             'amount': _amountController.text,
  //           }) +
  //           (!widget.contact.userRegistered()
  //               ? 'invite_prompt'.trParams({
  //                   'link': Constants.kAppLink,
  //                 })
  //               : ''),
  //     );
  //     talker.debug("@AddTransaction : addPersonalTnx() ⇢ $res");
  //   }
  //   // '${appController.user.fullName} is inviting you to confirm transaction of amount \u{20B9}${_amountController.text} on the LaneDane app. ${widget.contact.serverId.isNegative ? "Download the app from link below. \n${Constants.appLink}" : ''}');

  //   return transaction;
  // }

  // TransactionsModel settleTransaction() {
  //   TransactionsModel transaction =
  //       appController.transactionController.retrieveOnly(
  //     widget.transactionId!,
  //   )!;

  //   if (transaction.serverId! < 1) {
  //     Get.showSnackbar(
  //       const GetSnackBar(
  //         title: 'Invalid Transaction',
  //         message:
  //             'This transaction may have failed to sync on the server. Try again later',
  //       ),
  //     );
  //     throw transaction.serverId!;
  //   }

  //   TransactionsModel newTransaction = appController.settleTransaction(
  //     amount: _amountController.text,
  //     contact: widget.contact,
  //     description: _descriptionController.text,
  //     paymentStatus: paymentStatus.value,
  //     transactionType: transactionType.value,
  //     category: _categorySelected.value,
  //     createdAt: DateTime.now(),
  //     updatedAt: DateTime.now(),
  //     existingTransactionId: transaction.serverId!,
  //   );

  //   transaction =
  //       appController.transactionController.declineTransaction(transaction);

  //   return newTransaction;
  // }

  // void _saveCounterVariableToCache() {
  //   final LocalStore store = appController.localstore;
  //   int transactionsCreatedCounter = store.retrieveTransactionsCreatedCounter();
  //   transactionsCreatedCounter++;
  //   store.updateTransactionsCreatedCounter(transactionsCreatedCounter);
  //   talker.debug(
  //       '@AddTransaction : _saveCounterVariableToCache() ⇢ Cached Data: $transactionsCreatedCounter');
  //   _counterForTrackingNumberOfTransactionsCreated = transactionsCreatedCounter;
  //   // call setState and set the recieved value to the counter variable
  // }

  @override
  Widget build(BuildContext context) {
    UserTransactionVM controller = Get.put(UserTransactionVM());
    final Size size = MediaQuery.of(context).size;
    TransactionVM transactionVM = Get.put(TransactionVM());

    // void submit() async {
    //   try {
    //     if (widget.allTransactionId != null) {
    //       await addSmsTnx();
    //       Get.back();
    //     } else if (widget.transactionId != null) {
    //       TransactionsModel transaction = settleTransaction();
    //       Navigator.of(context).pop(transaction);
    //     } else {
    //       final TransactionsModel? transactionData = await addPersonalTnx();
    //       // Lets keep a counter here
    //       if (!kDebugMode) {
    //         _saveCounterVariableToCache();
    //         if (_counterForTrackingNumberOfTransactionsCreated == 5) {
    //           // TODO: Show the user a dialog to rate the app
    //           // InAppReviewHelper().requestReview();
    //           InAppReviewHelper().openStoreListing();
    //         }
    //       }
    //       if (transactionData != null && mounted) {
    //         // Get.back();
    //         Navigator.of(context).pop(transactionData);
    //         talker.debug(
    //             "@AddTransaction : sumbit : transactionData not null for id : ${transactionData.id} and description : ${transactionData.description} so going to back screen");
    //         // Get.back(result: transactionData);
    //       }
    //       // Navigator.of(context). /*pushNamedAndRemoveUntil*/
    //       //     pushReplacementNamed(
    //       //   PersonalTransactions.routeName,
    //       //   arguments: {
    //       //     // 'transaction': transactionData['trasnsacitonObject'],
    //       //     'contact': widget.contact
    //       //   },
    //       // );
    //     }
    //   } on UnauthorizedError {
    //     appController.logout();
    //   } catch (err, stack) {
    //     switch (err) {
    //       case 'MISSING_AMOUNT':
    //         showSnackBar(context, 'Enter the amount');
    //         break;
    //       default:
    //         FirebaseCrashlytics.instance.recordError(
    //           err,
    //           stack,
    //           fatal: false,
    //           printDetails: true,
    //           reason: 'Failed to add transaction',
    //           information: [
    //             _amountController.text,
    //             _categorySelected.value?.message ?? 'no category selected',
    //             transactionType.value,
    //             paymentStatus.value,
    //           ],
    //         );
    //         showSnackBar(context, 'Unknown Error');
    //     }
    //   }
    // }

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'add_transaction'.tr,
          style: const TextStyle(
            color: AppColors.bgWhite, // Change text color to white
          ),
        ),
        backgroundColor: const Color(0xFF128C7E),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
      ),

      floatingActionButton: Builder(
        builder: (context) => Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            // Padding(
            //   padding: const EdgeInsets.only(left: 30),
            //   child: FloatingActionButton(
            //     onPressed: () {},
            //     backgroundColor: lightGreenColor,
            //     child: const Icon(
            //       Icons.schedule,
            //       size: 17,
            //     ),
            //   ),
            // ),

            FloatingActionButton(
              heroTag: "AddTransactionClass",
              onPressed: () {
                Get.to(UserTransactionCreate());
              },
              backgroundColor: lightGreenColor,
              child: const Icon(
                Icons.check,
                color: AppColors.bgWhite, // Change the color to white
              ),
            )
          ]),
        ),
      ),
      persistentFooterAlignment: AlignmentDirectional.bottomCenter,
      body: Builder(
        builder: (context) {
          return Container(
            height: size.height -
                MediaQuery.of(context).viewInsets.top -
                Scaffold.of(context).appBarMaxHeight!,
            width: size.width,
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 40),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // profilePicture,

                  // const SizedBox(height: 10),
                  // Text(
                  //   // widget.contact.full_name!,
                  //   "Contact Name",
                  //   style: const TextStyle(
                  //     fontSize: 20,
                  //     fontWeight: FontWeight.w700,
                  //   ),
                  // ),

                  AmountField(
                    controller: amountController,
                  ),

                  // SizedBox(
                  //   width: 24 * length.toInt() + 48 + 48 + (length.toString().isEmpty ? 24 : 0),
                  //   child: TextFormField(
                  //     onChanged: (value) {

                  //       length = value.toString().length;
                  //     },
                  //     maxLines: 1,
                  //     keyboardType: TextInputType.number,
                  //     controller: amountController,
                  //     decoration: InputDecoration(
                  //       prefixIcon: const Icon(Icons.currency_rupee,
                  //         size: 28,
                  //         color: AppColors.label,
                  //       ),
                  //       hintStyle: GoogleFonts.roboto(
                  //         color: const Color(0xFF000000).withOpacity(0.25),
                  //       ),
                  //       hintText: '0',
                  //     ),
                  //     style: const TextStyle(
                  //       fontSize: 48,
                  //     ),
                  //   ),
                  // ),

                  const SizedBox(height: 30),
                  Text(
                    'Shubham Gupta',
                    style: TextStyle(fontSize: 22),
                  ),
                  // _addCategoryButton(context, _categories, _categorySelected),
                  // InkWell(
                  //   onTap: () {},
                  //   child: Container(
                  //     padding:
                  //         EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  //     decoration: BoxDecoration(
                  //       color: Color.fromARGB(255, 246, 234, 234),
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //     child: Text("Add Category"),
                  //   ),
                  // ),
                  SizedBox(
                    height: 40,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'transaction_type'.tr,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.roboto(
                          color: AppColors.label, fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    child: CustomToggleButtons(
                      initialSelection: transactionType.value,
                      options: TransactionType.values
                          .map<String>((TransactionType t) {
                        return t.name.tr;
                      }).toList(),
                      onSelect: (int index) {
                        transactionVM.transactionType =
                            transactionTypeList[index].obs;
                        talker.debug(
                            "@AddTransaction : build() ⇢  ${transactionTypeList[index]}");
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Payment Type'.tr,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.roboto(
                          color: AppColors.label, fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children: [
                      Container(
                        height: 50,
                        width: double.infinity,
                        child: CustomToggleButtons(
                          initialSelection: paymentStatus.value,
                          options: PaymentStatus.values.map<String>((t) {
                            return t.name.tr;
                          }).toList(),
                          onSelect: (int index) {
                            transactionVM.paymentStatus.value =
                                paymentStatusList[index];
                            talker.debug(
                                "@AddTransaction : build() ⇢  ${transactionVM.paymentStatus}");
                          },
                        ),
                      ),
                      const SizedBox(height: 70),

                      // TextField(

                      TextField(
                        onChanged: (value) {
                          transactionVM.description = value.obs;
                        },
                        autofocus: true,
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.description,
                            size: 40,
                            color: greenColor,
                          ),
                          labelText: 'description'.tr,
                          labelStyle: const TextStyle(
                              color: AppColors.label, fontSize: 18),
                          iconColor: greenColor,
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: greenColor,
                            ),
                          ),
                          hintText: 'description'.tr,
                          hintStyle: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'due_date'.tr,
                              textAlign: TextAlign.left,
                              style: GoogleFonts.roboto(
                                color: AppColors.label,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          CalendarIcon(),
                        ],
                      ),

                      // SizedBox(
                      //     height:
                      //         widget.paymentStatus.value.toLowerCase() == 'pending' ? 10 : 0),

                      DateInputField(),
                    ],
                  ),
                  const SizedBox(height: 15),
                  // AddTransactionHelperText(
                  //   amountController: _amountController,
                  //   paymentStatusNotifier: paymentStatus,
                  //   transactionTypeNotifier: transactionType,
                  //   dateController: dueDateController,
                  //   user: widget.contact,
                  // ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget _addCategoryButton(
  BuildContext context,
  List<CategoriesModel> categories,
  ValueNotifier<CategoriesModel?> categorySelected,
) {
  return InkWell(
    onTap: () async {
      // CategoriesModel? value = await showSearch<CategoriesModel?>(
      //   context: context,
      //   // delegate: addCategorySearchDelegate(
      //   //   categoryModel: categories,
      //   // ),
      //   delegate:
      // );

      // if (value != null) {
      //   categorySelected.value = value;
      //   // if (!_categories.contains(value.message)) {
      //   //   final cat = CategoriesModel(message: value.message);
      //   //   _categories.add(cat);
      //   //   // log.i('_categories length after: ${_categories.length}');
      //   // }
      // }
      // // log.i('_categories length before: ${_categories.length}');
    },
    child: SizedBox(
      height: 50,
      width: 230,
      child: Card(
        color: Colors.white70,
        child: Center(
          child: ValueListenableBuilder(
            valueListenable: categorySelected,
            builder:
                (BuildContext context, CategoriesModel? value, Widget? child) {
              String selectedVal = 'add_category'.tr;
              if (categorySelected.value != null) {
                selectedVal = categorySelected.value!.message;
              }
              return Text(selectedVal);
            },
          ),
        ),
      ),
    ),
  );
}
