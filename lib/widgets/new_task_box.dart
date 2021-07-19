import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../Providers/Task.dart';
class NewTaskBox extends StatefulWidget {

  @override
  _NewTaskBoxState createState() => _NewTaskBoxState();
}

class _NewTaskBoxState extends State<NewTaskBox> {
  final _form = GlobalKey<FormState>();


  final newTask = new Task();
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
        newTask.startDate = pickedDate;
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
        newTask.startTime = pickedTime;
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
        newTask.dueDate = pickedDate;
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
        newTask.dueTime = pickedTime;
      });
    });
  }
  bool forMem = false;

  void _trySubmit(BuildContext context, AsyncSnapshot<dynamic> snapshot) async {
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
      if(forMem) {
        for (String follow in snapshot.data['followers']) {
          final uid = FirebaseAuth.instance.currentUser.uid;
          await Future.wait([
            FirebaseFirestore.instance.collection('otherUserData')
                .doc(follow)
                .collection('tasks')
                .add(newTask.toJson(context))
          ]);
        }
      }
      else{
        final uid = FirebaseAuth.instance.currentUser.uid;
        await Future.wait([
        FirebaseFirestore.instance.collection('otherUserData')
            .doc(uid)
            .collection('tasks')
            .add(newTask.toJson(context))
        ]);
      }
    }
    catch (err) {
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
                Navigator.of(ctx).pop();
              },
            ),
          ],
        ),
      );
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<dynamic>(
      stream: FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.uid).snapshots(),
      builder: (context, snapshot) {
        return Container(
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
                    decoration: InputDecoration(
                      labelText: 'Task Name',
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
                      newTask.title = value;
                    },
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    key: ValueKey('description'),
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
                      return null;
                    },
                    onSaved: (String value) {
                      newTask.description = value;
                    },
                  ),
                  SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        newTask.startDate != null ? 'Start Date:- ${DateFormat('dd/MM/yyyy').format(newTask.startDate)}' : 'Start Date',
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
                          'Choose',
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
                        newTask.startTime != null ? 'Start Time:- ${newTask.startTime.format(context)}' : 'Starting Time',
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
                          'Choose',
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
                        newTask.dueDate != null ? 'Due Date:- ${DateFormat('dd/MM/yyyy').format(newTask.dueDate)}' : 'Due Date',
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
                          'Choose',
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
                        newTask.dueTime != null ? 'Due Time:- ${newTask.dueTime.format(context)}' : 'Due Time',
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
                          'Choose',
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Text("For Members", style: TextStyle(fontSize: 18),),
                      TextButton(
                          onPressed: (){
                            forMem = !forMem;
                            setState(() {
                              newTask.forMembers = forMem;
                            });
                          },
                          child: Icon((forMem)?Icons.check_circle:Icons.check_circle_outline_outlined)),
                    ],
                  ),
                  _isLoading ? CircularProgressIndicator() : RaisedButton(
                    child: Text('SAVE'),
                    onPressed: () {
                      _trySubmit(context, snapshot);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
