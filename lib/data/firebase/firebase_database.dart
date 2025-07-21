import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tasky_app/data/firebase/firebase_auth.dart';
import 'package:tasky_app/models/task_model.dart';
import 'package:tasky_app/models/user_model.dart';

abstract class FirebaseDatabase {
  static CollectionReference<UserModel> collectionUser() {
    return FirebaseFirestore.instance
        .collection('Users')
        .withConverter<UserModel>(
          fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
          toFirestore: (user, _) => user.toJson(),
        );
  }

  //create user
  static createUser(UserModel useR) {
    collectionUser().doc(useR.id).set(useR);
  }

  //get user
  static getUser(String userId) async {
    var data = await collectionUser().doc(userId).get();
    return data.data();
  }

  static CollectionReference<TaskModel> collectionTask() {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? "";
    return collectionUser()
        .doc(userId)
        .collection("Tasks")
        .withConverter<TaskModel>(
          fromFirestore: (snapshot, _) => TaskModel.fromJson(snapshot.data()!),
          toFirestore: (task, _) => task.toJson(),
        );
  }

  static Future<void> addTask({
    required String taskTitle,
    required DateTime date,
    required int prority,
    required String description,
  }) async {
    var refs = await collectionTask().doc();
    String taskId = refs.id;
    TaskModel userTask = TaskModel(
      taskId: taskId,
      taskTitle: taskTitle,
      date: date,
      prority: prority,
      description: description,
    );
    refs.set(userTask);
  }

  static Future<List<TaskModel>> getAllTasks() async {
    var taskList = await collectionTask().get();
    return taskList.docs.map((task) {
      return task.data();
    }).toList();
  }

  static Future<void> updateTask(TaskModel task) async {
    return await collectionTask().doc(task.taskId).update(task.toJson());
  }

  static Future<void> deletTask(TaskModel task) async {
    return await collectionTask().doc(task.taskId).delete();
  }

  static CollectionReference<TaskModel> collectionCompeletedTask() {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? "";
    return collectionUser()
        .doc(userId)
        .collection("ComeletedTasks")
        .withConverter<TaskModel>(
          fromFirestore: (snapshot, _) => TaskModel.fromJson(snapshot.data()!),
          toFirestore: (task, _) => task.toJson(),
        );
  }

  static Future<List<TaskModel>> getAllCompletedTasks() async {
    var taskList = await collectionCompeletedTask().get();
    return taskList.docs.map((task) {
      return task.data();
    }).toList();
  }
  static Future<void> addCompeletedTask({
    required String taskTitle,
    required DateTime date,
    required int prority,
    required String description,
  }) async {
    var refs = await collectionCompeletedTask().doc();
    String taskId = refs.id;
    TaskModel userTask = TaskModel(
      taskId: taskId,
      taskTitle: taskTitle,
      date: date,
      prority: prority,
      description: description,
    );
    refs.set(userTask);
  }
  
}
