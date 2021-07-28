import 'package:MASK/services/blocs/tasks_bloc.dart';

class Maestro {

  static TasksRepository _tasksRepository = TasksRepository();
  static TasksBloc tasksBloc;

  static void configure() {
    tasksBloc = TasksBloc(_tasksRepository);
    tasksBloc.add(TasksRequested());
  }

}
