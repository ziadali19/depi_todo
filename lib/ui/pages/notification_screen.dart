import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:todo/main.dart';

import '../theme.dart';

class NotificationScreen extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const NotificationScreen(this.payload);
  final String? payload;
  @override
  // ignore: library_private_types_in_public_api
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late String _payload;
  @override
  void initState() {
    _payload = widget.payload!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: MyTextStyle("${_payload.split('|')[0]}", 20),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
            color: Get.isDarkMode ? Colors.white : darkGreyClr,
            onPressed: () => Get.back(),
            icon: const Icon(LineIcons.arrowLeft)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                MyTextStyle('Hello Ziad', 30),
                const SizedBox(
                  height: 10,
                ),
                MyTextStyle1('You have a new reminder', 20),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                margin: const EdgeInsets.only(left: 30, right: 30),
                decoration: BoxDecoration(
                    color: Colors.teal[600],
                    borderRadius: BorderRadius.circular(20)),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(
                          Icons.text_format_rounded,
                          size: 40,
                          color: Get.isDarkMode ? Colors.white : darkGreyClr,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        MyTextStyle('Title', 30),
                      ]),
                      const SizedBox(
                        height: 20,
                      ),
                      MyTextStyle1(_payload.split('|')[0].toString(), 20),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(children: [
                        LineIcon(
                          Icons.description_rounded,
                          size: 40,
                          color: Get.isDarkMode ? Colors.white : darkGreyClr,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        MyTextStyle2('Description', 30),
                        const SizedBox(
                          width: 10,
                        ),
                      ]),
                      const SizedBox(
                        height: 20,
                      ),
                      MyTextStyle1(_payload.split('|')[1].toString(), 20),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(children: [
                        LineIcon(
                          Icons.date_range_rounded,
                          size: 40,
                          color: Get.isDarkMode ? Colors.white : darkGreyClr,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        MyTextStyle('Date', 30),
                        const SizedBox(
                          width: 10,
                        ),
                      ]),
                      const SizedBox(
                        height: 20,
                      ),
                      MyTextStyle1(_payload.split('|')[2].toString(), 20),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
