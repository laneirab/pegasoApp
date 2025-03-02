import 'package:flutter/material.dart';
import '/infrastructure/datasources/grade_datasource.dart';
import '/presentation/widgets/navigationBar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GradeDataSource.initialize();
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
