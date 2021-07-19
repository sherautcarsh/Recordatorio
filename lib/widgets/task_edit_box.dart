import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
class TaskEditBox extends StatefulWidget {

  final DocumentSnapshot task;



  TaskEditBox({
    @required this.task,
  });
  @override
  _TaskEditBoxState createState() => _TaskEditBoxState();
}

class _TaskEditBoxState extends State<TaskEditBox> {
  final _form = GlobalKey<FormState>();

  String newTitle;
  String newDescription;
  DateTime newStartDate;
  DateTime newDueDate;
  TimeOfDay newStartTime;
  TimeOfDay newDueTime;
  var _isLoading = false;

  void _presentStartDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2100),
    ).then((pickedDate) {
      if(pickedDate == null){
        return;
      }
      setState(() {
        newStartDate = pickedDate;
      });
    });
  }

  void _presentStartTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 0,minute: 0),
    ).then((pickedTime) {
      if(pickedTime == null){
        return;
      }
      setState(() {
        newStartTime = pickedTime;
      });
    });
  }

  void _presentDueDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2100),
    ).then((pickedDate) {
      if(pickedDate == null){
        return;
      }
      setState(() {
        newDueDate = pickedDate;
      });
    });
  }

  void _presentDueTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 0,minute: 0),
    ).then((pickedTime) {
      if(pickedTime == null){
        return;
      }
      setState(() {
        newDueTime = pickedTime;
      });
    });
  }

  void _trySubmit(BuildContext context) async {
    final isValid = _form.currentState.validate();
    FocusScope.of(context).unfocus();
    if(!isValid){
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try{
      final uid = FirebaseAuth.instance.currentUser.uid;
      await FirebaseFirestore.instance.collection('otherUserData').doc(uid).collection('tasks').doc(widget.task.id).update({
        'title': newTitle != null ? newTitle : widget.task['title'],
        'description': newDescription != null ? newDescription : widget.task['description'],
        'startDate': newStartDate != null ? DateFormat('dd/MM/yyyy').format(newStartDate).toString() : widget.task['startDate'],
        'startTime': newStartTime != null ? newStartTime.format(context).toString().trim() : widget.task['startTime'],
        'dueDate': newDueDate != null ? DateFormat('dd/MM/yyyy').format(newDueDate).toString() : widget.task['dueDate'],
        'dueTime': newDueTime != null ? newDueTime.format(context).toString().trim() : widget.task['dueTime'],
      });
    } catch (err) {
      print(err);
      await showDialog<Null>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An error occurred'),
          content: Text('Something went wrong'),
          actions: [
            FlatButton(
              child: Text('Okay'),
              onPressed: () {
                //Navigator.of(ctx).pop();
              },
            ),
          ],
        ),
      );
    }
    setState(() {
      _isLoading = false;
    });
    //Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.6,
      width: MediaQuery.of(context).size.width*0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Form(
          key: _form,
          child: Column(
            children: [
              TextFormField(
                key: ValueKey('title'),
                initialValue: widget.task['title'],
                decoration: InputDecoration(
                  labelText: 'Title',
                  icon: Icon(Icons.title),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                ),
                style: TextStyle(
                  letterSpacing: 1.5,
                ),
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Enter a valid title';
                  }
                  if(value.length > 30) {
                    return 'Too Long';
                  }
                  return null;
                },
                onSaved: (String value) {
                  newTitle = value;
                },
              ),
              SizedBox(height: 10,),
              TextFormField(
                key: ValueKey('description'),
                initialValue: widget.task['description'],
                decoration: InputDecoration(
                  labelText: 'Description',
                  icon: Icon(Icons.text_snippet_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                ),
                keyboardType: TextInputType.multiline,
                maxLines: 6,
                style: TextStyle(
                  letterSpacing: 1.5,
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Enter decription';
                  }
                  if(value.length < 30){
                    return 'Too short!';
                  }
                  return null;
                },
                onSaved: (String value) {
                  newDescription = value;
                },
              ),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    newStartDate != null ? 'Start Date:- ${DateFormat('dd/MM/yyyy').format(newStartDate)}' : 'Start Date:- ${widget.task['startDate']}',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                      fontSize: 15,
                    ),
                  ),
                  FlatButton(
                    onPressed: _presentStartDatePicker,
                    child: Text(
                      'Edit',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    newStartTime != null ? 'Start Time:- ${newStartTime.format(context)}' : 'Start Time:- ${widget.task['startTime']}',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                      fontSize: 15,
                    ),
                  ),
                  FlatButton(
                    onPressed: _presentStartTimePicker,
                    child: Text(
                      'Edit',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    newDueDate != null ? 'Due Date:- ${DateFormat('dd/MM/yyyy').format(newDueDate)}' : 'Due Date:- ${widget.task['dueDate']}',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                      fontSize: 15,
                    ),
                  ),
                  FlatButton(
                    onPressed: _presentDueDatePicker,
                    child: Text(
                      'Edit',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    newDueTime != null ? 'Due Time:- ${newDueTime.format(context)}' : 'Due Time:- ${widget.task['dueTime']}',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                      fontSize: 15,
                    ),
                  ),
                  FlatButton(
                    onPressed: _presentDueTimePicker,
                    child: Text(
                      'Edit',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              _isLoading ? CircularProgressIndicator() : RaisedButton(
                child: Text('SAVE'),
                onPressed: () {
                  _trySubmit(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
