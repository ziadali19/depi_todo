import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:line_icons/line_icons.dart';
import 'package:todo/controllers/task_controller.dart';
import 'package:todo/main.dart';
import 'package:todo/ui/widgets/button.dart';

import '../../models/task.dart';
import '../size_config.dart';
import '../theme.dart';
import '../widgets/input_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController taskController = Get.put(TaskController());
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  String startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 15)))
      .toString();
  int? selectedRemind = 5;
  String? selectedRepeat = 'None';
  List<int> remindList = [5, 10, 15, 20];
  List<String> repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];
  int selectedColor = 0;
  DateTime? choosenDate;
  @override
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        // ignore: prefer_const_literals_to_create_immutables
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: const CircleAvatar(
              backgroundImage: AssetImage('images/person.jpeg'),
            ),
          ),
        ],
        elevation: 0,
        leading: IconButton(
            color: Get.isDarkMode ? Colors.white : darkGreyClr,
            onPressed: () {
              Get.back();
            },
            icon: const Icon(LineIcons.arrowLeft)),
        centerTitle: true,
        title: MyTextStyle('Add task', 20),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            InputField(
              label: 'Title',
              note: 'Enter title here.',
              controller: titleController,
            ),
            const SizedBox(
              height: 15,
            ),
            InputField(
              label: 'Note',
              note: 'Enter note here.',
              controller: noteController,
            ),
            const SizedBox(
              height: 15,
            ),
            InputField(
                label: 'Date',
                note: DateFormat.yMEd()
                    .format(choosenDate == null ? DateTime.now() : choosenDate!)
                    .toString(),
                widget: IconButton(
                  icon: Icon(
                    LineIcons.calendar,
                    color: Get.isDarkMode ? Colors.grey : Colors.black,
                  ),
                  onPressed: () {
                    getDateFromUser(); //DatePicker(DateTime.now());
                  },
                )),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                SizedBox(
                  width: SizeConfig.screenWidth * 0.5,
                  child: InputField(
                    label: 'Start time',
                    note: startTime,
                    widget: IconButton(
                      icon: Icon(
                        LineIcons.calendarMinusAlt,
                        color: Get.isDarkMode ? Colors.grey : Colors.black,
                      ),
                      onPressed: () {
                        getTimeFromUser(isStartTime: true);
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: SizeConfig.screenWidth * 0.5,
                  child: InputField(
                    label: 'End time',
                    note: endTime,
                    widget: IconButton(
                      icon: Icon(LineIcons.calendarMinusAlt,
                          color: Get.isDarkMode ? Colors.grey : Colors.black),
                      onPressed: () {
                        getTimeFromUser(isStartTime: false);
                      },
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            InputField(
                label: 'Remind',
                note: '$selectedRemind minutes early',
                widget: DropdownButton(
                  borderRadius: BorderRadius.circular(10),
                  dropdownColor: Colors.teal,
                  //value: val,
                  icon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 30,
                  ),
                  underline: Container(height: 0),
                  items: remindList
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: MyTextStyle1(e.toString(), 17),
                          ))
                      .toList(),
                  onChanged: (int? value) {
                    setState(() {
                      selectedRemind = value;
                    });
                  },
                )),
            const SizedBox(
              height: 15,
            ),
            InputField(
              label: 'Repeat',
              note: selectedRepeat.toString(),
              widget: DropdownButton(
                borderRadius: BorderRadius.circular(10),
                dropdownColor: Colors.teal,
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 30,
                ),
                underline: Container(height: 0),
                items: repeatList
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: MyTextStyle1(e.toString(), 17),
                        ))
                    .toList(),
                onChanged: (String? value) {
                  setState(() {
                    selectedRepeat = value;
                  });
                },
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: const EdgeInsets.only(
                          left: 16,
                        ),
                        child: MyTextStyle('Color', 20)),
                    const SizedBox(
                      height: 5,
                    ),
                    Wrap(
                      children: [
                        const SizedBox(
                          width: 16,
                        ),
                        ...List.generate(
                            3,
                            (index) => Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedColor = index;
                                      });
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: index == 0
                                          ? primaryClr
                                          : index == 1
                                              ? pinkClr
                                              : orangeClr,
                                      radius: 15,
                                      child: selectedColor == index
                                          ? const Icon(
                                              Icons.done_rounded,
                                              color: Colors.black,
                                            )
                                          : Container(),
                                    ),
                                  ),
                                ))
                      ],
                    )
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(right: 16),
                  child: MyButton(
                      label: 'Create task',
                      onTap: () {
                        validateText();
                      }),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }

  validateText() {
    if (titleController.text.isNotEmpty && noteController.text.isNotEmpty) {
      addTasksToDb();
      Get.back();
    } else if (titleController.text.isEmpty || noteController.text.isEmpty) {
      Get.snackbar('Invalid', 'All fields are required',
          margin: const EdgeInsets.all(10),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          colorText: Colors.white,
          icon: const Icon(
            Icons.warning_amber_rounded,
            color: Colors.white,
          ));
    }
  }

  addTasksToDb() async {
    await taskController.addTask(Task(
        title: titleController.text,
        note: noteController.text,
        remind: selectedRemind,
        color: selectedColor,
        repeat: selectedRepeat,
        isCompleted: 0,
        date: DateFormat.yMd()
            .format(choosenDate == null ? DateTime.now() : choosenDate!),
        startTime: startTime,
        endTime: endTime));
  }

  getDateFromUser() async {
    var val = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (val == null) {
      return;
    }
    setState(() {
      choosenDate = val;
    });
  }

  getTimeFromUser({required bool isStartTime}) async {
    TimeOfDay? val = await showTimePicker(
        context: context,
        initialTime: isStartTime
            ? TimeOfDay.fromDateTime(DateTime.now())
            : TimeOfDay.fromDateTime(
                DateTime.now().add(const Duration(minutes: 15))));
    debugPrint('$val');
    if (val == null) {
      return;
    }
    isStartTime
        ? setState(() {
            startTime = val.format(context);
          })
        : setState(() {
            endTime = val.format(context);
          });
  }
}
