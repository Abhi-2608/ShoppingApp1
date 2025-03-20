import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lane_dane/res/colors.dart';

class Premium extends StatefulWidget {
  const Premium({super.key});

  @override
  State<Premium> createState() => _PremiumState();
}

class _PremiumState extends State<Premium> {
  Color _color = Colors.green.shade500;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double heigth = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/inviteImage.png',
              fit: BoxFit.cover,
            ),
            const Center(
              child: Text(
                'Premium Mode',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(255, 226, 223, 223)),
                  borderRadius: const BorderRadius.all(Radius.circular(15))),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'Become a pro member and enjoy the following features'),
                    SizedBox(
                      height: 7,
                    ),
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.check,
                          color: Colors.green,
                        ),
                        Text('Ads Free')
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.check,
                          color: Colors.green,
                        ),
                        Text('Better performance')
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.check,
                          color: Colors.green,
                        ),
                        Text('Unlock All Features')
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() {
                      _color = Colors.green.shade800;
                    }),
                    child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                        color: _color,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                      ),
                      child: const Column(
                        children: [
                          Text(
                            'Monthly',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          Text(
                            'Rs',
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            '150',
                            style: TextStyle(fontSize: 15),
                          ),
                          Text(
                            '/month',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() {
                      _color = Colors.green.shade800;
                    }),
                    child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                        color: _color,
                        // border:
                        //     Border.all(color: Colors.green.shade400, width: 2),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                      ),
                      child: const Column(
                        children: [
                          Text(
                            'Quaterly',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          Text(
                            'Rs',
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            '360',
                            style: TextStyle(fontSize: 15),
                          ),
                          Text(
                            '120/month',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() {
                      _color = Colors.green.shade800;
                    }),
                    child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                        color: _color,
                        // border:
                        //     Border.all(color: Colors.green.shade400, width: 2),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                      ),
                      // ignore: prefer_const_constructors
                      child: Column(
                        children: const [
                          Text(
                            'Yearly',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          Text(
                            'Rs',
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            '1200',
                            style: TextStyle(fontSize: 15),
                          ),
                          Text(
                            '100/month',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 40,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: Colors.green,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Upgrade to premium',
                    style: TextStyle(color: AppColors.bgWhite, fontSize: 20),
                  ),
                  Icon(
                    Icons.arrow_right_alt_outlined,
                    color: AppColors.bgWhite,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
