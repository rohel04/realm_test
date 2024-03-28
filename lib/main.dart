import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realm_mongo/bloc/todo_bloc.dart';
import 'package:realm_mongo/services/realm_config.dart';
import 'package:realm_mongo/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await RealmConfig.instance.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoBloc(),
      child: const MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
