import 'package:bloc_test/bloc_test.dart' as bloc_test;
import 'package:test/test.dart' as test;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:MASK/models/model.dart';
import 'package:MASK/services/blocs/tasks_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:MASK/services/api.dart';

class MockTasksRepository extends Mock implements TasksRepository {}
class MockClient extends Mock implements http.Client {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  API.client = MockClient();

  test.group('TasksBloc', () {
    TasksRepository repository;
    TasksBloc bloc;
    Tasks control;

    setUp(() {
      repository = MockTasksRepository();
      bloc = TasksBloc(repository);
      control = TasksRepository.mockTasks;
    });

    tearDown(() {
      bloc.close();
    });

    test.test('throws AssertionError if TasksRepository is null', () {
      expect(() => TasksBloc(null), throwsA(isAssertionError));
    });

    group('TasksRequested', () {
      bloc_test.blocTest(
        'emits [LoadInProgress, LoadSuccess] when TasksRequested is fired and getTasks succeeds',
        build: () => bloc,
        act: (bloc) => bloc.add(TasksRequested()),
        expect: [TasksLoadInProgress(), TasksLoadSuccess(control)],
      );
    });
  });
}
