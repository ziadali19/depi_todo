import 'package:flutter/material.dart';
import 'package:todo/main.dart';
import 'package:todo/models/task.dart';
import 'package:todo/ui/size_config.dart';
import 'package:todo/ui/theme.dart';

class TaskTile extends StatelessWidget {
  const TaskTile(this.task);
  final Task task;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15, left: 16, right: 16),
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(
          color: task.color == 0
              ? primaryClr
              : task.color == 1
                  ? pinkClr
                  : orangeClr,
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyTextStyle5(task.title!, 20),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.access_time_rounded,
                        color: Colors.black,
                        size: 22,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      MyTextStyle7('${task.startTime} - ${task.endTime}', 16)
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  MyTextStyle6(task.note!, 15),
                ],
              ),
            )),
            Container(
              height: 60,
              width: 1,
              color: Colors.black,
              margin: const EdgeInsets.symmetric(horizontal: 10),
            ),
            RotatedBox(
              quarterTurns: 3,
              child: MyTextStyle6(
                  task.isCompleted == 0 ? 'To do' : 'Completed', 15),
            )
          ],
        ),
      ),
    );
  }
}
