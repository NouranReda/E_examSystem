import 'package:flutter/material.dart';

class SubjectPage extends StatefulWidget {
  @override
  _SubjectPageState createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  List<Level> _levels = [];
  List<Department> _departments = [];
  List<Subject> _subjects = [];

  Level? _selectedLevel;
  Department? _selectedDepartment;

  final _subjectNameController = TextEditingController();

  void _addLevel() {
    String levelName = 'Level ${_levels.length + 1}';
    setState(() {
      _levels.add(Level(name: levelName));
    });
  }

  void _addDepartment() {
    String departmentName = 'Department ${_departments.length + 1}';
    setState(() {
      _departments.add(Department(name: departmentName));
    });
  }

  void _addSubject() {
    String subjectName = _subjectNameController.text.trim();
    if (subjectName.isNotEmpty) {
      setState(() {
        _subjects.add(
          Subject(
            name: subjectName,
            level: _selectedLevel!,
            department: _selectedDepartment!,
          ),
        );
      });
      _subjectNameController.clear();
    }
  }

  void _editSubject(int index) {
    String subjectName = _subjects[index].name;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Subject'),
          content: TextField(
            onChanged: (value) {
              subjectName = value;
            },
            decoration: InputDecoration(
              labelText: 'Subject Name',
              border: OutlineInputBorder(),
            ),
            controller: TextEditingController(text: subjectName),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                setState(() {
                  _subjects[index].name = subjectName;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _removeSubject(int index) {
    setState(() {
      _subjects.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Subjects'),
        ),
        body: Padding(
        padding: const EdgeInsets.all(16.0),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text(
    'Levels',
    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
    ),
    SizedBox(height: 16.0),
    Row(
    children: [
    Expanded(
    child: DropdownButtonFormField<Level>(
    decoration: InputDecoration(
    labelText: 'Select Level',
    border: OutlineInputBorder(),
    ),
    value: _selectedLevel,
    onChanged: (Level? level) {
    setState(() {
    _selectedLevel = level;
    });
    },
    items: _levels.map((Level level) {
    return DropdownMenuItem<Level>(
    value: level,
    child: Text(level.name),
    );
    }).toList(),
    ),
    ),
    SizedBox(width: 16.0),
    ElevatedButton(
    onPressed: _addLevel,
    child: Text('Add Level'),
    ),
    ],
    ),
    SizedBox(height: 32.0),
    Text(
    'Departments',
    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
    ),
    SizedBox(height: 16.0),
    Row(
    children: [
    Expanded(child: DropdownButtonFormField<Department>(
      decoration: InputDecoration(
        labelText: 'Select Department',
        border: OutlineInputBorder(),
      ),
      value: _selectedDepartment,
      onChanged: (Department? department) {
        setState(() {
          _selectedDepartment = department;
        });
      },
      items: _departments.map((Department department) {
        return DropdownMenuItem<Department>(
          value: department,
          child: Text(department.name),
        );
      }).toList(),
    ),
    ),
      SizedBox(width: 16.0),
      ElevatedButton(
        onPressed: _addDepartment,
        child: Text('Add Department'),
      ),
    ],
    ),
      SizedBox(height: 32.0),
      Text(
        'Subjects',
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 16.0),
      Expanded(
        child: ListView.builder(
          itemCount: _subjects.length,
          itemBuilder: (context, index) {
            return Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                _removeSubject(index);
              },
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 16.0),
                child: Icon(Icons.delete, color: Colors.white),
              ),
              child: ListTile(
                title: Text(_subjects[index].name),
                onTap: () {
                  _editSubject(index);
                },
              ),
            );
          },
        ),
      ),
      SizedBox(height: 16.0),
      TextField(
        decoration: InputDecoration(
          labelText: 'Subject Name',
          border: OutlineInputBorder(),
        ),
        controller: _subjectNameController,
      ),
      SizedBox(height: 16.0),
      ElevatedButton(
        onPressed: _addSubject,
        child: Text('Add Subject'),
      ),
    ],
    ),
        ),
    );
  }
}

class Level {
  String name;

  Level({required this.name});
}

class Department {
  String name;

  Department({required this.name});
}

class Subject {
  String name;
  Level level;
  Department department;

  Subject({required this.name, required this.level, required this.department});
}