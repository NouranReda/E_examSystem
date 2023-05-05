import 'package:flutter/material.dart';

class Professor {
  final String name;
  final String email;
  late final bool approved;

  Professor({required this.name, required this.email, this.approved = false});
}

class ProfessorListPage extends StatefulWidget {
  @override
  _ProfessorListPageState createState() => _ProfessorListPageState();
}

class _ProfessorListPageState extends State<ProfessorListPage> {
  List<Professor> _professors = [
    Professor(name: 'ali', email: 'ali@yahoo.com', approved: true),
    Professor(name: 'samar', email: 'samar@yahoo.com'),
    Professor(name: 'amr', email: 'amr@yahoo.com'),
    Professor(name: 'Sarah', email: 'sarah@yahoo.com', approved: true),
  ];

  void _approveSignUp(int index) {
    setState(() {
      _professors[index].approved = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Professors'),
      ),
      body: ListView.builder(
        itemCount: _professors.length,
        itemBuilder: (context, index) {
          Professor professor = _professors[index];
          return ListTile(
            leading: CircleAvatar(
              child: Text(
                professor.name[0],
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            title: Text(professor.name),
            subtitle: Text(professor.email),
            trailing: professor.approved
                ? null
                : ElevatedButton(
              onPressed: () {
                _approveSignUp(index);
              },
              child: Text('Approve'),
            ),
          );
        },
      ),
    );
  }
}