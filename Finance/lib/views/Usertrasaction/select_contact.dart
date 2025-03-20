//getx manner
//no logic or function will in view files
// the code should be clean
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lane_dane/models/users.dart';
import 'package:lane_dane/res/colors.dart';
import 'package:lane_dane/utils/colors.dart';
import 'package:lane_dane/views/user_transaction/userTransactionIndex.dart';

class SelectContact extends StatefulWidget {
  const SelectContact({super.key});

  @override
  State<SelectContact> createState() => _SelectContactState();
}

class _SelectContactState extends State<SelectContact> {
  TextEditingController contactController = TextEditingController();
  Users user = Users(
      phone_no: '+91 7596258691',
      onBoardedAt: DateTime(2024),
      tapCount: 2,
      full_name: 'Aditya Gupta');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: const Color(0xFF128C7E),
        title: Text(
          'select_contact'.tr,
          style: GoogleFonts.roboto(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              controller: contactController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.search),
                  hintText: 'Search name or number'),
            ),
          ),
          ListTile(
            tileColor: AppColors.bgWhite,
            leading: CircleAvatar(
              child: Icon(
                Icons.person_add,
                color: AppColors.bgWhite,
              ),
              backgroundColor: greenColor,
            ),
            trailing: IconButton(
                onPressed: () {}, icon: Icon(Icons.arrow_forward_ios)),
            title: Text(
              'add_contact'.tr,
              style: const TextStyle(
                color: AppColors.label,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  minVerticalPadding: 12,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        style: BorderStyle.solid, color: Colors.grey.shade200),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserTransactionIndex()));
                  },
                  tileColor: AppColors.bgWhite,
                  leading: CircleAvatar(
                    backgroundColor: greenColor,
                  ),
                  title: Text(
                    user.full_name.toString(),
                    style: const TextStyle(
                      color: AppColors.label,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Text('+91 ' + user.phoneNumber),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
