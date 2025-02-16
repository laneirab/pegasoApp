import 'package:flutter/material.dart';
import '../presentation/screens/home.dart';
import '../presentation/screens/calendar.dart';
import '../presentation/screens/subjects.dart';
import '../presentation/widgets/navigationBar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pegaso Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CustomNavigationBar(),
    );
  }
}
