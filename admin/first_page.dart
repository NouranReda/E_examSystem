import 'package:flutter/material.dart';
import 'package:e_exam/admin/add,edit_level.dart';
import 'package:e_exam/admin/edit_subject.dart';
import 'package:e_exam/admin/view_list.dart';
import 'package:e_exam/admin/privilege.dart';
class Admin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => FacultyPage()));
              },
              child: Text('Add/Edit Levels and Departments'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SubjectPage()));
              },
              child: Text('Add/Edit Subjects'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfessorListPage(),));
              },
              child: Text('View List of Professors and Approve Sign up Requests'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfessorPrivilegesPage()));
              },
              child: Text('Professor Privileges'),
            ),
          ],
        ),
      ),
    );
  }
}



