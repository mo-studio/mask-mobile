import 'dart:ui';
import 'package:MASK/widgets/Welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:MASK/widgets/TaskList.dart';
import 'package:MASK/widgets/TaskDetail.dart';
import 'package:MASK/services/maestro.dart';
import 'package:MASK/models/model.dart';
import 'package:MASK/services/blocs/tasks_bloc.dart';

Type typeOf<T>() => T;

class MockTasksBloc extends MockBloc<TasksState> implements TasksBloc {}

void main() {
  group('widget smoke tests', () {
    Maestro.configure();

    TasksBloc tasksBloc;

    setUp(() {
      tasksBloc = MockTasksBloc();
    });

    tearDown(() {
      tasksBloc.close();
    });

    testWidgets('Welcome', (WidgetTester tester) async {
      // set tester resolution to iPhone SE (smallest iOS device capable of running MASK)
      await tester.binding.setSurfaceSize(Size(1136, 640));
      await tester.pumpWidget(MaterialApp(home: Welcome()));
      expect(find.text('Welcome to Airmen Mobile Processing'), findsOneWidget);
    });

    testWidgets('TaskList', (WidgetTester tester) async {
      when(tasksBloc.state).thenReturn(TasksLoadSuccess(TasksRepository.mockTasks));
      await tester.binding.setSurfaceSize(Size(1136, 640));
      await tester.pumpWidget(MaterialApp(
          home: MultiBlocProvider(
            providers: [
              BlocProvider.value(value: tasksBloc)
            ],
            child: TaskList()
          )
        )
      );
      
      for (Task task in TasksRepository.mockTasks.tasks) {
        expect(find.text(task.title), findsOneWidget);
      }
    });

    testWidgets('TaskDetail', (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(Size(1136, 640));
      final task = Task(id: 1234, title: "Get this thing from that person.", text: "Call that person at this number: 123-456-7890");
      await tester.pumpWidget(MaterialApp(home: TaskDetail(task)));
      expect(find.text(task.title), findsOneWidget);
      expect(find.text(task.text), findsOneWidget);
    });
  });
}