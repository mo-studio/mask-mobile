import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:MASK/services/maestro.dart';
import 'package:MASK/services/blocs/auth_bloc.dart';
import 'package:MASK/widgets/Welcome.dart';
import 'package:MASK/widgets/TaskList.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

  final authBloc = AuthBloc();
  authBloc.add(AuthRequested());
  runApp(BlocProvider.value(value: authBloc, child: MASK()));
}

class MASK extends StatefulWidget {
  @override
  _MASKState createState() => _MASKState();
}

class _MASKState extends State<MASK> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MASK',
      theme: ThemeData(
        primaryColor: Color(0xFF009CE9),
        accentColor: Color(0xFF8C40CD),
      ),
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, authState) {
          if (authState is AuthLoadInProgress) {
            return Center(child: CircularProgressIndicator(value: null));
          } else if (authState is AuthLoaded) {
            if (authState.isLoggedIn) {
              Maestro.configure();
              return BlocProvider.value(value: Maestro.tasksBloc, child: TaskList());
            } else {
              return BlocProvider.value(value: BlocProvider.of<AuthBloc>(context), child: Welcome());
            }
          }
          return null;
      })
    );
  }

  @override
  void dispose() {
    Maestro.tasksBloc.close();
    super.dispose();
  }

}
