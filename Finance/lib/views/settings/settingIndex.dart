import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:lane_dane/res/colors.dart';
import 'package:lane_dane/view_models/settings_vm.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double heigth = MediaQuery.of(context).size.height;
    SettingVM controller = Get.put(SettingVM());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF128C7E),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text("Settings", style: TextStyle(fontSize: 25)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 5.0),
        child: Column(
          children: [
            // Container(
            //   width: width,
            //   decoration: BoxDecoration(
            //       border: Border(
            //     bottom: BorderSide(
            //       color: Colors.grey.shade400,
            //     ),
            //     top: BorderSide(
            //       color: Colors.grey.shade400,
            //     ),
            //   )),
            //   child: Row(
            //     children: [
            //       const Padding(
            //         padding: EdgeInsets.all(12.0),
            //         child: CircleAvatar(
            //           radius: 38,
            //           backgroundImage:
            //               AssetImage("assets/images/account_ic.png"),
            //         ),
            //       ),
            //       const SizedBox(
            //         width: 10,
            //       ),
            //       const Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Text('Profile Name'),
            //           Text('NickName'),
            //         ],
            //       ),
            //       Expanded(
            //         child: SizedBox(
            //           width: width,
            //         ),
            //       ),
            //       IconButton(
            //           onPressed: () {},
            //           icon: const Icon(
            //             Icons.qr_code,
            //             color: Color.fromARGB(255, 38, 183, 43),
            //           )),
            //       IconButton(
            //           onPressed: () {},
            //           icon: const Icon(
            //             Icons.arrow_drop_down_circle_outlined,
            //             color: Color.fromARGB(255, 38, 183, 43),
            //           )),
            //     ],
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  width: width,
                  height: 200,
                  child: Column(
                    children: [
                      const Text(
                        'Extra Features',
                        style: TextStyle(
                          fontSize: 30,
                          color: AppColors.bgWhite,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const Expanded(
                        child: SizedBox(
                          height: 10,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(
                          18.0,
                        ),
                        child: Container(
                          height: 40,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            color: AppColors.label,
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Upgrade to premium',
                                style: TextStyle(
                                    color: AppColors.bgWhite, fontSize: 20),
                              ),
                              Icon(
                                Icons.arrow_right_alt_outlined,
                                color: AppColors.bgWhite,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
            const SizedBox(
              height: 5,
            ),
            ListTile(
              titleAlignment: ListTileTitleAlignment.top,
              leading: const Padding(
                padding: EdgeInsets.only(top: 7.0),
                child: Icon(Icons.key),
              ),
              title: const Text('Account', style: TextStyle(fontSize: 20)),
              subtitle: Text(
                'Security notifications, change number',
                style: TextStyle(color: Colors.grey.shade500),
              ),
            ),
            ListTile(
              onTap: () {
                controller.privacyPolicy();
              },
              titleAlignment: ListTileTitleAlignment.top,
              leading: const Padding(
                padding: EdgeInsets.only(top: 7.0),
                child: Icon(Icons.lock),
              ),
              title: const Text(
                'Privacy Policy',
                style: TextStyle(fontSize: 20),
              ),
              subtitle: Text(
                'Block Contacts, disappearing messages',
                style: TextStyle(color: Colors.grey.shade500),
              ),
            ),
            ListTile(
              onTap: () {
                controller.rateUs();
              },
              titleAlignment: ListTileTitleAlignment.top,
              leading: const Padding(
                padding: EdgeInsets.only(top: 7.0),
                child: Icon(Icons.star_border),
              ),
              title: const Text(
                'Rate us',
                style: TextStyle(fontSize: 20),
              ),
              subtitle: Text('Rate us out of 5',
                  style: TextStyle(color: Colors.grey.shade500)),
            ),
            ListTile(
              titleAlignment: ListTileTitleAlignment.top,
              leading: const Padding(
                padding: EdgeInsets.only(top: 7.0),
                child: Icon(Icons.blur_circular),
              ),
              title: const Text(
                'App language',
                style: TextStyle(fontSize: 20),
              ),
              subtitle: Text('English (Device Language)',
                  style: TextStyle(color: Colors.grey.shade500)),
            ),
            ListTile(
              onTap: () {
                controller.shareApp();
              },
              titleAlignment: ListTileTitleAlignment.top,
              leading: const Padding(
                padding: EdgeInsets.only(top: 7.0),
                child: Icon(Icons.people),
              ),
              title: const Text(
                'Invite a Friend',
                style: TextStyle(fontSize: 20),
              ),
              //subtitle: Text('Rate us out of 5'),
            ),
            Expanded(
                child: SizedBox(
              height: heigth,
            )),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Vue Nice Technology',
                  style: TextStyle(
                    color: Colors.green.shade900,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
