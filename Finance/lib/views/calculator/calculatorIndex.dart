import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:lane_dane/helpers/cache_storage_helper.dart';
import 'package:lane_dane/main.dart';
import 'package:lane_dane/models/users.dart';
import 'package:lane_dane/res/colors.dart';
// import 'package:lane_dane/views/pages/selectContact.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorIndex extends StatefulWidget {
  static const routeName = 'calculator-index';
  const CalculatorIndex({super.key});

  @override
  State<CalculatorIndex> createState() => _CalculatorIndexState();
}

class _CalculatorIndexState extends State<CalculatorIndex> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  Future<void> createPersonalTransaction(Users user) async {
    // var transaction = await Navigator.of(context).pushNamed(
    //   AddTransaction.routeName,
    //   arguments: {'contact': user},
    // );
    // if (transaction == null) {
    //   return;
    // }
    // Get.toNamed(AddTransaction.routeName, arguments: {
    //   'contact': user,
    // });
  }

  String doesContainDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0)) {
        return result = splitDecimal[0].toString();
      }
    }
    return result;
  }

  bool isOperator(String str) {
    return ['+', '-', '×', '÷', '%', '->'].contains(str);
  }

  String performCalculation(String equation) {
    String expression = equation;
    expression = expression.replaceAll('×', '*');
    expression = expression.replaceAll('÷', '/');
    expression = expression.replaceAll('%', '%');

    try {
      Parser p = Parser();
      Expression exp = p.parse(expression);

      ContextModel cm = ContextModel();
      String result = '${exp.evaluate(EvaluationType.REAL, cm)}';
      if (expression.contains('%')) {
        result = doesContainDecimal(result);
      }
      return result;
    } catch (e) {
      return "Error";
    }
  }

  navButtonPressed() async {
    if (result == 0) {
      Get.snackbar('Null Amount', 'Total amount cannot be 0');
      return;
    }
    /* 
         * Since the amount cannot be passed to SelectContact Screen individually
         * As a result, the amount will be stored in the cache and will be retrieved in the SelectContact Screen
         * 
         * Reason for not passing the amount directly: it creates a lot of problems in the SelectContact Screen where you have to make changes to Constructor in routes etc. 
         * 
         !!! Do not : Modify the Caching Logic Below
         */
    // CacheStorageHelper().saveFile('calculatorData', {
    //   'amount': result,
    //   'equation': equation,
    // });

    // dynamic selectContactResponse = await Get.toNamed(SelectContact.routeName);

    // if (selectContactResponse.runtimeType == Users) {
    //   createPersonalTransaction(selectContactResponse);
    // } else {
    //   talker
    //       .debug('@CalculatorIndex : buttonPressed(->) : No contact selected');
    //   return;
    // }
  }

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "AC") {
        equation = "0";
        result = "0";
      } else if (buttonText == "⌫") {
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
          result = "0";
        } else {
          result = performCalculation(equation);
        }
      } else if (buttonText == "+/-") {
        if (equation[0] != '-') {
          equation = '-$equation';
        } else {
          equation = equation.substring(1);
        }
        result = performCalculation(equation);
      } else if (buttonText == "=") {
        result = performCalculation(equation);
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Do you want to select contact?"),
            content: const Text(
                "Select a contact to add the transaction to the contact's account."),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Container(
                  // color: Colors.green,
                  padding: const EdgeInsets.all(14),
                  child: const Text("No, Don't add transaction yet"),
                ),
              ),
              TextButton(
                onPressed: () async {
                  // CacheStorageHelper().saveFile('calculatorData', {
                  //   'amount': result,
                  //   'equation': equation,
                  // });

                  // dynamic selectContactResponse =
                  //     await Get.toNamed(SelectContact.routeName);

                  // if (selectContactResponse.runtimeType == Users) {
                  //   await createPersonalTransaction(selectContactResponse);
                  // } else {
                  //   talker.debug(
                  //       '@CalculatorIndex : buttonPressed(->) : No contact selected');
                  //   return;
                  // }
                  Navigator.of(ctx).pop();
                },
                child: Container(
                  // color: Colors.green,
                  padding: const EdgeInsets.all(14),
                  child: const Text("Select contact"),
                ),
              ),
            ],
          ),
        );
      } else {
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
        if (isOperator(buttonText) || equation.length == 1) {
          // No need to perform calculation
        } else {
          result = performCalculation(equation);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black54,
        // appBar: AppBar(
        //   elevation: 0,
        //   backgroundColor: const Color(0xFF128C7E),
        //   title: const Text("Calculator", style: TextStyle(fontSize: 25)),
        // ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(result,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      color: AppColors.bgWhite, fontSize: 75))),
                          const SizedBox(width: 20),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(equation,
                                style: const TextStyle(
                                  fontSize: 40,
                                  color: Colors.white38,
                                )),
                          ),
                          IconButton(
                            icon: const Icon(Icons.backspace_outlined,
                                color: Color(0xFF128C7E), size: 30),
                            onPressed: () {
                              buttonPressed("⌫");
                            },
                          ),
                          const SizedBox(width: 20),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calcButton('AC', Colors.white10, () => buttonPressed('AC')),
                  calcButton('%', Colors.white10, () => buttonPressed('%')),
                  calcButton('÷', Colors.white10, () => buttonPressed('÷')),
                  calcButton("×", Colors.white10, () => buttonPressed('×')),
                ],
              ),
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calcButton('7', Colors.white24, () => buttonPressed('7')),
                  calcButton('8', Colors.white24, () => buttonPressed('8')),
                  calcButton('9', Colors.white24, () => buttonPressed('9')),
                  calcButton('-', Colors.white10, () => buttonPressed('-')),
                ],
              ),
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calcButton('4', Colors.white24, () => buttonPressed('4')),
                  calcButton('5', Colors.white24, () => buttonPressed('5')),
                  calcButton('6', Colors.white24, () => buttonPressed('6')),
                  calcButton('+', Colors.white10, () => buttonPressed('+')),
                ],
              ),
              const SizedBox(height: 10),
              // calculator number buttons

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calcButton('1', Colors.white24, () => buttonPressed('1')),
                  calcButton('2', Colors.white24, () => buttonPressed('2')),
                  calcButton('3', Colors.white24, () => buttonPressed('3')),
                  calcButton(
                      '=', const Color(0xFF128C7E), () => buttonPressed('=')),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calcButton('+/-', Colors.white24, () => buttonPressed('+/-')),
                  calcButton('0', Colors.white24, () => buttonPressed('0')),
                  calcButton('.', Colors.white24, () => buttonPressed('.')),
                  IconButton(
                      constraints:
                          const BoxConstraints(minHeight: 70, minWidth: 75),
                      style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          backgroundColor: const Color(0xFF128C7E)),
                      onPressed: () => navButtonPressed(),
                      icon: const Icon(
                        Icons.arrow_forward,
                        color: AppColors.label,
                      )),
                  // calcButton(
                  //     '^', const Color(0xFF128C7E), () => buttonPressed('^')),
                ],
              )
            ],
          ),
        ));
  }
}

Widget calcButton(
    String buttonText, Color buttonColor, void Function()? buttonPressed) {
  return Container(
    width: 75,
    // height: buttonText == '=' ? 150 : 70,
    height: 70,
    padding: const EdgeInsets.all(0),
    child: ElevatedButton(
      onPressed: buttonPressed,
      style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          backgroundColor: buttonColor),
      child: Text(
        buttonText,
        style: const TextStyle(fontSize: 27, color: Colors.white),
      ),
    ),
  );
}
