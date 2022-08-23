import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lesson_4_database_hive/model/user_model.dart';
import 'package:lesson_4_database_hive/page/homepage.dart';
import 'package:lesson_4_database_hive/src/db_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HiveDbService.setup();
  Hive.registerAdapter(UserAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
