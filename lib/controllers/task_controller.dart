import 'package:get/get.dart';
import 'package:todo/db/db_helper.dart';

import '../models/task.dart';

class TaskController extends GetxController {
  List taskList = <Task>[].obs;

  getTasks() async {
    final List<Map<String, Object?>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((e) => Task.fromJson(e)).toList());
  }

  Future<int> addTask(Task? task) {
    return DBHelper.insert(task);
  }

  deleteTask(Task task) async {
    await DBHelper.delete(task);
    getTasks();
  }

  deleteAllTask() async {
    await DBHelper.deleteAll();
    getTasks();
  }

  markAsCompleted(int id) async {
    await DBHelper.update(id);
    getTasks();
  }
}
