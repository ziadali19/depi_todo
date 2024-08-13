import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/main.dart';
import 'package:todo/ui/size_config.dart';

import '../theme.dart';

class InputField extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const InputField(
      {required this.label, required this.note, this.controller, this.widget});
  final String label;
  final String note;
  final TextEditingController? controller;
  final Widget? widget;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const SizedBox(
              width: 16,
            ),
            MyTextStyle(label, 20),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          //width: SizeConfig.screenWidth,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: TextFormField(
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.normal,
                  color: Get.isDarkMode ? Colors.grey : darkGreyClr),
              readOnly: widget != null ? true : false,
              cursorColor: Get.isDarkMode ? Colors.grey : Colors.black,
              controller: controller,
              autofocus: false,
              decoration: InputDecoration(
                  suffixIcon: widget,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                          color: Get.isDarkMode ? Colors.grey : Colors.black)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                          color: Get.isDarkMode ? Colors.grey : Colors.black)),
                  hintText: note,
                  hintStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Get.isDarkMode ? Colors.white : darkGreyClr))),
        )
      ],
    );
  }
}
