import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo/models/task.dart';
//import 'package:todo/services/notification_services.dart';
import 'package:todo/services/theme_services.dart';
import 'package:todo/ui/pages/add_task_page.dart';
import 'package:todo/ui/size_config.dart';
import 'package:todo/ui/widgets/button.dart';
import 'package:todo/ui/widgets/task_tile.dart';
import '../../controllers/task_controller.dart';
import '../../main.dart';
import '../theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //late NotifyHelper notifyHelper;
  @override
  void initState() {
    //  notifyHelper = NotifyHelper();
    //  notifyHelper.intialize();

    taskController.getTasks();
    super.initState();
  }

  final TaskController taskController = Get.put(TaskController());
  DateTime? selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: MyTextStyle('Home', 20),
          actions: [
            IconButton(
                color: Get.isDarkMode ? Colors.white : Colors.black,
                onPressed: () {
                  // NotifyHelper().cancelAllNotification();
                  taskController.deleteAllTask();
                },
                icon: const Icon(
                  Icons.delete_forever_rounded,
                  size: 30,
                )),
            Container(
              margin: const EdgeInsets.only(right: 16),
              child: const CircleAvatar(
                backgroundImage: AssetImage('images/person.jpeg'),
              ),
            ),
          ],
          elevation: 0,
          leading: IconButton(
            icon: Get.isDarkMode
                ? Icon(
                    Icons.wb_sunny_rounded,
                    color: Get.isDarkMode ? Colors.white : darkGreyClr,
                    size: 30,
                  )
                : Icon(
                    Icons.nightlight_round,
                    color: Get.isDarkMode ? Colors.white : darkGreyClr,
                    size: 30,
                  ),
            onPressed: () {
              ThemeServices().switchTheme();
              //notifyHelper.displayNotification(title: 'Theme changed', body: 'Dark light');

              // notifyHelper.scheduledNotification();
            },
          ),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              addTaskBar(),
              addDateBar(),
              showTasks(),
            ],
          ),
        )));
  }

  addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(top: 15, right: 16, left: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyTextStyle(
                  DateFormat.yMMMMd().format(DateTime.now()).toString()
                  /*selectedDate == null
                      ? DateFormat.yMMMMd().format(DateTime.now()).toString()
                      : DateFormat.yMMMMd().format(selectedDate!).toString(),*/
                  ,
                  20),
              MyTextStyle('Today', 20)
            ],
          ),
          MyButton(
              label: '+ Add task',
              onTap: () async {
                await Get.to(const AddTaskPage());
                taskController.getTasks();
              })
        ],
      ),
    );
  }

  addDateBar() {
    return Container(
        margin: const EdgeInsets.only(top: 15, right: 16, left: 16),
        child: DatePicker(
          DateTime.now(),
          initialSelectedDate: DateTime.now(),
          width: 70,
          height: 100,
          dateTextStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Get.isDarkMode ? Colors.white : darkGreyClr),
          dayTextStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Get.isDarkMode ? Colors.white : darkGreyClr),
          monthTextStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Get.isDarkMode ? Colors.white : darkGreyClr),
          selectionColor: Colors.teal,
          selectedTextColor: Colors.white,
          onDateChange: (date) {
            setState(() {
              selectedDate = date;
            });
          },
        ));
  }

  Obx showTasks() {
    return Obx(() {
      if (taskController.taskList.isEmpty) {
        return noTaskMsg();
      } else {
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: taskController.taskList.length,
          itemBuilder: (BuildContext context, int index) {
            Task task = taskController.taskList[index];

            if (task.repeat == 'Daily' ||
                task.date == DateFormat.yMd().format(selectedDate!) ||
                (task.repeat == 'Weekly' &&
                    selectedDate!
                                .difference(DateFormat.yMd().parse(task.date!))
                                .inDays %
                            7 ==
                        0) ||
                (task.repeat == 'Monthly' &&
                    DateFormat.yMd().parse(task.date!).day ==
                        selectedDate!.day)) {
              var hour0 = DateFormat('HH:mm').parse(task.startTime!);
              debugPrint('$hour0');
              var hour = DateFormat('HH:mm').format(hour0);
              debugPrint(hour);

              /* notifyHelper.scheduledNotifications(
                  id: task.id!,
                  title: task.title!,
                  note: task.note!,
                  hour: int.parse(hour.toString().split(':')[0]),
                  minutes: int.parse(hour.toString().split(':')[1]),
                  task: task);*/
              return AnimationConfiguration.staggeredList(
                duration: Duration(milliseconds: 1000),
                position: index,
                child: SlideAnimation(
                  horizontalOffset: 300,
                  child: FadeInAnimation(
                    child: GestureDetector(
                      // ignore: void_checks
                      onTap: () {
                        // ignore: void_checks
                        return showBottomSheet(context, task);
                      },
                      child: TaskTile(task),
                    ),
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        );
      }
    });
  }

  noTaskMsg() {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: const Duration(seconds: 2),
          child: SingleChildScrollView(
            //padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 100, right: 16, left: 16),
                  child: SvgPicture.asset(
                    'images/task.svg',
                    height: 150,
                    color: Get.isDarkMode ? Colors.grey : darkGreyClr,
                    semanticsLabel: 'Task',
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15, right: 16, left: 16),
                  child: MyTextStyle3(
                      "You don't have any tasks yet!\nAdd new tasks to make your days productive.",
                      20),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  buildBottomSheet(
      {required String label,
      required Function() OnTap,
      required Color clr,
      bool isClose = false}) {
    return GestureDetector(
      onTap: OnTap,
      child: Container(
        height: 65,
        margin: const EdgeInsets.symmetric(vertical: 4),
        width: SizeConfig.screenWidth * 0.7,
        decoration: BoxDecoration(
            border: Border.all(
                width: 2,
                color: isClose
                    ? (Get.isDarkMode ? Colors.grey[300]! : Colors.grey[600]!)
                    : clr),
            borderRadius: BorderRadius.circular(20),
            color: isClose ? Colors.transparent : clr),
        child: Center(
            child: isClose ? MyTextStyle(label, 25) : MyTextStyle8(label, 25)),
      ),
    );
  }

  showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(top: 4),
        width: SizeConfig.screenWidth,
        height: task.isCompleted == 1
            ? SizeConfig.screenHeight * 0.30
            : SizeConfig.screenHeight * 0.39,
        color: Get.isDarkMode ? darkGreyClr : Colors.white,
        child: Column(
          children: [
            Flexible(
                child: Container(
              height: 8,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Get.isDarkMode ? Colors.grey[300] : Colors.grey[600],
              ),
            )),
            const SizedBox(
              height: 20,
            ),
            task.isCompleted == 1
                ? Container()
                : buildBottomSheet(
                    label: 'Task Completed',
                    OnTap: () {
                      taskController.markAsCompleted(task.id!);
                      Get.back();
                      //    NotifyHelper().cancelNotification(task);
                    },
                    clr: Colors.lightGreen),
            const SizedBox(
              height: 10,
            ),
            buildBottomSheet(
                label: 'Delete task',
                OnTap: () {
                  taskController.deleteTask(task);
                  // NotifyHelper().cancelNotification(task);
                  Get.back();
                },
                clr: const Color.fromARGB(255, 176, 6, 6)),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              width: 90,
              child: Divider(
                thickness: 2,
                color: Colors.grey,
              ),
            ),
            buildBottomSheet(
                label: 'Cancel',
                OnTap: () {
                  Get.back();
                },
                clr: Colors.teal),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    ));
  }
}
