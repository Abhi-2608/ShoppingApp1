import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:lane_dane/res/colors.dart';
import 'package:lane_dane/utils/colors.dart';
import 'premium.dart';

class Reminder extends StatefulWidget {
  final String name;
  final String time;
  final String amt;
  const Reminder(
      {super.key, required this.name, required this.time, required this.amt});

  @override
  State<Reminder> createState() => _ReminderState();
}

class _ReminderState extends State<Reminder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false, // Remove back icon
        title: Text(
          'lane_dane'.tr,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.bgWhite, // Set color to white
          ),
        ),
        backgroundColor: const Color(0xFF128C7E),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: Colors.black),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings, color: Colors.black),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.my_library_add, color: Colors.black),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'We Will Continuosly Remind',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                Text(
                  widget.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                Text(
                  'At ${widget.time} via SMS to payback amount of RS${widget.amt}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 25,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                fixedSize: Size(MediaQuery.of(context).size.width - 100, 50),
                backgroundColor: Colors.green),
            onPressed: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Reminder'),
                content: const Text('sent succsessfully'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                          color: Color.fromARGB(255, 3, 77, 64), fontSize: 20),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text(
                      'OK',
                      style: TextStyle(
                          color: Color.fromARGB(255, 3, 77, 64), fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
            child: const Text(
              'Okay',
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
