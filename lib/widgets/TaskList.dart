import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:MASK/widgets/TaskDetail.dart';
import 'package:MASK/models/model.dart';
import 'package:MASK/services/blocs/tasks_bloc.dart';
import 'package:MASK/services/blocs/auth_bloc.dart';
import 'package:MASK/services/auth.dart';

class TaskList extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<TaskList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MASK'),
        automaticallyImplyLeading: false,
        actions: [
          Padding(child:
          GestureDetector(
            onTap: () {
              _showLogoutDialog();
            },
            child: Icon(
              Icons.logout,
            ),
          ), padding: EdgeInsets.only(right: 10.0))
        ],),
      body: BlocBuilder<TasksBloc, TasksState>(
        builder: (context, tasksState) {
          if (tasksState is TasksLoadFailure) {
            return Text("Error loading tasks: $tasksState.error");
          } else if (tasksState is TasksLoadSuccess) {
            List<Task> tasks = tasksState.tasks.tasks;
            return ListView.separated(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                final theme = Theme.of(context).copyWith(dividerColor: Colors.lightBlue.withAlpha(0));
                return Theme(
                  data: theme, 
                  child: Padding(
                    padding: EdgeInsets.all(6.0), 
                    child: ListTile(
                      title: Text(task.title, style: TextStyle(fontSize: 14)),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        _navigateToTaskDetail(task);
                      }
                    )
                  )
                );
              },
              separatorBuilder: (BuildContext context, int index) => const Divider(),
            );
          } else {
            return Center(child: CircularProgressIndicator(value: null));
          }
        }
      )
    );
  }

  void _navigateToTaskDetail(Task task) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return TaskDetail(task);
        }
      )
    );
  }

  Future<void> _showLogoutDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              }
            ),
            TextButton(
              child: Text('Log Out', style: TextStyle(color: Colors.red)),
              onPressed: () async {
                bool success = await logout();
                if (success) {
                  Navigator.of(context).pop();
                  BlocProvider.of<AuthBloc>(context).add(AuthLogOut());
                }
              },
            ),
          ],
        );
      },
    );
  }
}
