import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/task_detail_dialog_box.dart';
import '../widgets/task_edit_box.dart';
import 'package:firebase_auth/firebase_auth.dart';
class TaskListItem extends StatefulWidget {

  final BuildContext ctx;
  final DocumentSnapshot task;
  TaskListItem(this.ctx,this.task);

  @override
  _TaskListItemState createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem> {

  @override
  Widget build(BuildContext context) {

    // final task = Provider.of<TaskItem>(context,listen: false);
    final Map<DismissDirection, double> mp = {
      DismissDirection.endToStart : 0.8
    };
    return Dismissible(

      key: ValueKey(widget.task['title']),
      direction: DismissDirection.endToStart,
      movementDuration: Duration(milliseconds: 50),
      //dismissThresholds: mp,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to remove this task?'),
            elevation: 20,
            actions: [
              FlatButton(
                textColor: Colors.black,
                child: Text('NO'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                textColor: Colors.black,
                child: Text(
                  'YES'
                ),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) async{
        final uid = FirebaseAuth.instance.currentUser.uid;
        await FirebaseFirestore.instance.collection('otherUserData').doc(uid).collection('tasks').doc(widget.task.id).delete();
      },
      background: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'DELETE',
              style: TextStyle(
                color: Colors.yellowAccent,
                fontSize: 16,
              ),
            ),
            SizedBox(width: 5),
            Icon(
              Icons.delete,
              color: Colors.yellowAccent,
              size: 28,
            ),
          ],
        ),
      ),
      child: Container(
        height: 80,
        child: Card(
          elevation: 20,
          color: widget.task['isCompleted'] ? Colors.grey[400] : Colors.white,
          child: ListTile(
            onTap: () {
              return showDialog(
                context: context,
                builder: (ctx) => Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 20,
                  backgroundColor: Colors.white,
                  child: TaskDetailBox(
                    title: widget.task['title'],
                    description: widget.task['description'],
                    dueTime: widget.task['dueTime'],
                    dueDate: widget.task['dueDate'],
                    startTime: widget.task['startTime'],
                    startDate: widget.task['startDate'],
                  ),
                ),
              );
            },
            leading: IconButton(
                color: Colors.red,
                iconSize: 30,
                icon: Icon(
                  widget.task['isCompleted'] ? Icons.check_box_outlined : Icons.check_box_outline_blank,
                ),
                onPressed: () async {
                  final uid = FirebaseAuth.instance.currentUser.uid;
                  await FirebaseFirestore.instance.collection('otherUserData').doc(uid).collection('tasks').doc(widget.task.id).update({
                    'isCompleted': !widget.task['isCompleted'],
                  });
                },
            ),
            title: Container(
              child: Text(
                widget.task['title'],
                maxLines: 1,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            subtitle: Text(
              'Due Date- ${widget.task['dueDate']} ${widget.task['dueTime']}',
            ),
            trailing: IconButton(
              color: Colors.red,
              icon: Icon(Icons.edit_sharp),
              iconSize: 25,
              onPressed: () {
                return showDialog(
                  context: context,
                  builder: (ctx) => Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 20,
                    backgroundColor: Colors.white,
                    child: TaskEditBox(
                      task: widget.task,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
