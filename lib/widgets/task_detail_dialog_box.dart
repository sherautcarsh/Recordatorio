import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';

class TaskDetailBox extends StatefulWidget {

  final String title;
  final String description;
  final String startDate;
  final String startTime;
  final String dueDate;
  final String dueTime;

  TaskDetailBox({
    @required this.title,
    @required this.description,
    @required this.dueTime,
    @required this.startTime,
    @required this.startDate,
    @required this.dueDate,
});
  @override
  _TaskDetailBoxState createState() => _TaskDetailBoxState();
}

class _TaskDetailBoxState extends State<TaskDetailBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.5,
      width: MediaQuery.of(context).size.width*0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Text(
              widget.title,
              textAlign: TextAlign.center,
              maxLines: 1,
              style: TextStyle(
                fontSize: 20,
              ),
              softWrap: true,
            ),
            SizedBox(height: 10,),
            Divider(
              height: 10,
              thickness: 2,
              color: Colors.black,
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.green[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Text('Start Time'),
                      SizedBox(height: 5,),
                      Text('${widget.startDate}'),
                      SizedBox(height: 5,),
                      Text(widget.startTime),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.red[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Text('Due Time'),
                      SizedBox(height: 5,),
                      Text(widget.dueDate),
                      SizedBox(height: 5,),
                      Text(widget.dueTime),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Container(
              height: 340,
              width: 300,
              padding: EdgeInsets.all(10),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Text(
                  widget.description,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
