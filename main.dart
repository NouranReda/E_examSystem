import 'package:flutter/material.dart';
import 'package:e_exam/admin/first_page.dart';
import 'package:e_exam/professor/professor.dart';
import 'package:e_exam/professor/organize_exam.dart';
import 'login.dart';
import 'signUp.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-exam System',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:
     // Admin(),
      LoginPage(),
      //SignUpPage(),
    // ProfessorPage(),
    );
  }
}
