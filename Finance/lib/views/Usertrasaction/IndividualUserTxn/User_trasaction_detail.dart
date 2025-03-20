import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:intl/intl.dart';
import 'package:lane_dane/res/colors.dart';
import 'package:lane_dane/view_models/user_transaction_vm.dart';

class UserTransactionDetail extends GetView<UserTransactionVM> {
  @override
  Widget build(BuildContext context) {
    String formattedTimestamp = DateFormat('MMM d, yyyy hh:mm a').format(
        controller.dummyTransactions[controller.indx.value]['timestamp']);
    Get.put(UserTransactionVM());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 128, 105, 1),
        title: const Text("Transaction Details",
            style: TextStyle(
              color: AppColors.bgWhite,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: const Color.fromARGB(26, 236, 233, 233),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                  style: BorderStyle.solid,
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const ProfilePicture(name: 'Atul', radius: 30, fontsize: 20),
                const Text(
                  'User Name',
                  style: TextStyle(color: Colors.grey),
                ),
                const Divider(
                  height: 20,
                  endIndent: 20,
                  indent: 20,
                  color: Color(0xffcecece),
                  thickness: 1,
                ),
                Text(
                  controller.dummyTransactions[controller.indx.value]['amount'],
                  style: const TextStyle(
                    color: Colors.lightGreen,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Created At:'),
                        Text('Updated At:'),
                        Text('Type:'),
                        Text('payment Status:'),
                        Text('Confiramtion:')
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(formattedTimestamp),
                        Text(formattedTimestamp),
                        Text(controller.dummyTransactions[controller.indx.value]
                            ['type']),
                        Text(controller.dummyTransactions[controller.indx.value]
                            ['status']),
                        const Text('Confirmation')
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.bgWhite,
                  side: const BorderSide(
                      style: BorderStyle.solid, color: Colors.green),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                onPressed: () {},
                icon: const Icon(
                  Icons.edit,
                  color: Colors.green,
                ),
                label:
                    const Text('Edit', style: TextStyle(color: Colors.green)),
              ),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.bgWhite,
                  side: const BorderSide(
                      style: BorderStyle.solid, color: Colors.red),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                onPressed: () {},
                icon: const Icon(
                  Icons.switch_access_shortcut,
                  color: Colors.red,
                ),
                label: const Text(
                  'Decline',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
