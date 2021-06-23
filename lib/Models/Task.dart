import 'package:flutter/material.dart';

class Task{
  String heading;
  String description;
  bool done;
  DateTime start;
  DateTime end;

  Task(this.heading, this.description, this.done, this.start, this.end);
}