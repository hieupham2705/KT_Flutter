import "package:flutter/material.dart";
class DataAddtask {
  late String title;

  DataAddtask(this.title, this.startTime, this.endTime, this.deadline,
      this.isFavorite, this.isCompleted, this.remind, this.repeat,this.color);

  late String startTime;
  late String endTime;
  late String deadline;
  late bool isFavorite;
  late bool isCompleted;
  late String remind;
  late String repeat;
  late Color color = Colors.red;
}
