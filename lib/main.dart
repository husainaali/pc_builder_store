import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:pc_builder_store/database_helper.dart';
import 'home_page.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PC Builder Store',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
            debugShowCheckedModeBanner: false, // Set this to false to remove the "Debug" banner

      home: const MyHomePage(title: 'PC Builder Store'),
    );
  }
}
