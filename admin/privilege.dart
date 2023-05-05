import 'package:flutter/material.dart';

class Privilege {
  final String name;
  late final bool enabled;

  Privilege({required this.name, this.enabled = false});
}

class ProfessorPrivilegesPage extends StatefulWidget {
  @override
  _ProfessorPrivilegesPageState createState() =>
      _ProfessorPrivilegesPageState();
}

class _ProfessorPrivilegesPageState extends State<ProfessorPrivilegesPage> {
  List<Privilege> _privileges = [
    Privilege(name: 'Manage Students'),
    Privilege(name: 'Manage Assignments', enabled: true),
    Privilege(name: 'Manage Grades'),
    Privilege(name: 'View Reports', enabled: true),
  ];

  void _togglePrivilege(int index) {
    setState(() {
      _privileges[index].enabled = !_privileges[index].enabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Professor Privileges'),
      ),
      body: ListView.builder(
        itemCount: _privileges.length,
        itemBuilder: (context, index) {
          Privilege privilege = _privileges[index];
          return SwitchListTile(
            title: Text(privilege.name),
            value: privilege.enabled,
            onChanged: (value) {
              _togglePrivilege(index);
            },
          );
        },
      ),
    );
  }
}