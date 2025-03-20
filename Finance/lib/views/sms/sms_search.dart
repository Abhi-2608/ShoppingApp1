import 'package:flutter/material.dart';

class SmsSearch extends StatelessWidget {
   SmsSearch({super.key});
  TextEditingController queryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: queryController,
          
        )

      ],
    );
  }
}