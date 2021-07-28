import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:MASK/models/model.dart';
import 'package:MASK/services/phone_number_linkifier.dart';

class TaskDetail extends StatefulWidget {

  final Task task;

  TaskDetail(this.task);

  @override
  _TaskDetailState createState() =>
      _TaskDetailState(this.task);

}

class _TaskDetailState extends State<TaskDetail> {
  
  final Task task;
  
  bool issueHasBeenReported = false;

  _TaskDetailState(this.task);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Task Details')),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(task.title,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 24)
                ),
                SizedBox(height: 24),
                Linkify(
                  linkifiers: [
                    UrlLinkifier(),
                    EmailLinkifier(),
                    PhoneNumberLinkifier()
                  ],
                  text: task.text,
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.65)),
                  onOpen: (element) {
                    launch(element.url);
                  },
                ),
                SizedBox(height: 24),
                if (task.verificationRequired)
                  Text("Verification Required", style: TextStyle(color: Colors.red)),
                SizedBox(height: 24),
              ],
            ),  
          ]
        )
      )
    );
  }
}
