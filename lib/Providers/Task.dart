import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class Task{
  String title;
  String description;
  DateTime startDate;
  TimeOfDay startTime;
  DateTime dueDate;
  TimeOfDay dueTime;
  bool isCompleted;
  bool forMembers;

  Task({
    this.title,
    this.description,
    this.startDate,
    this.startTime,
    this.dueDate,
    this.dueTime,
    this.isCompleted = false,
    this.forMembers
  });

  Map<String, dynamic> toJson(BuildContext ctx) => {
    'title': title,
    'description': description,
    'startDate': DateFormat('dd/MM/yyyy').format(startDate).toString(),
    'startTime': startTime.format(ctx).toString().trim(),
    'dueDate': DateFormat('dd/MM/yyyy').format(dueDate).toString(),
    'dueTime': dueTime.format(ctx).toString().trim(),
    'isCompleted': isCompleted,
    'createdAt': Timestamp.now(),
    'forMembers' : forMembers,
  };
}