// ignore_for_file: public_member_api_docs, sort_constructors_first
class TaskModel {
  String taskId;
  String taskTitle;
  DateTime date;
  int prority;
  String description;
  bool isCompeleted;
  TaskModel({
    required this.taskId,
    required this.taskTitle,
    required this.date,
    required this.prority,
    required this.description,
    this.isCompeleted = false,
  });
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      taskTitle: json["taskTitle"],
      date: DateTime.fromMillisecondsSinceEpoch(json["date"]),
      prority: json["prority"],
      description: json["description"],
      taskId: json["taskId"],
      isCompeleted: json["isCompeleted"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "taskId": taskId,
      "taskTitle": taskTitle,
      "date": date.millisecondsSinceEpoch,
      "prority": prority,
      "description": description,
      "isCompeleted": isCompeleted,
    };
  }
}
