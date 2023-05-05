import 'package:flutter/material.dart';

class FacultyPage extends StatefulWidget {
  @override
  _FacultyPageState createState() => _FacultyPageState();
}

class _FacultyPageState extends State<FacultyPage> {
  List<Level> _levels = [];
  List<Department> _departments = [];

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

  void _editLevel(int index) {
    String levelName = _levels[index].name;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Level'),
          content: TextField(
            onChanged: (value) {
              levelName = value;
            },
            decoration: InputDecoration(
              labelText: 'Level Name',
              border: OutlineInputBorder(),
            ),
            controller: TextEditingController(text: levelName),
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
                  _levels[index].name = levelName;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _editDepartment(int index) {
    String departmentName = _departments[index].name;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Department'),
          content: TextField(
            onChanged: (value) {
              departmentName = value;
            },
            decoration: InputDecoration(
              labelText: 'Department Name',
              border: OutlineInputBorder(),
            ),
            controller: TextEditingController(text: departmentName),
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
                  _departments[index].name = departmentName;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _removeLevel(int index) {
    setState(() {
      _levels.removeAt(index);
    });
  }

  void _removeDepartment(int index) {
    setState(() {
      _departments.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Faculty'),
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
    Expanded(
    child: ListView.builder(
    itemCount: _levels.length,
    itemBuilder: (context, index) {
    return Dismissible(
    key: UniqueKey(),
    direction: DismissDirection.endToStart,
    onDismissed: (direction) {
    _removeLevel(index);
    },
    background: Container(
    color: Colors.red,
    alignment: Alignment.centerRight,
    padding: EdgeInsets.only(right: 16.0),
    child: Icon(Icons.delete, color: Colors.white),
    ),
      child: ListTile(
        title: Text(_levels[index].name),
        onTap: () {
          _editLevel(index);
        },
      ),
    );
    },
    ),
    ),
      SizedBox(height: 16.0),
      ElevatedButton(
        onPressed: _addLevel,
        child: Text('Add Level'),
      ),
      SizedBox(height: 32.0),
      Text(
        'Departments',
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 16.0),
      Expanded(
        child: ListView.builder(
          itemCount: _departments.length,
          itemBuilder: (context, index) {
            return Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                _removeDepartment(index);
              },
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 16.0),
                child: Icon(Icons.delete, color: Colors.white),
              ),
              child: ListTile(
                title: Text(_departments[index].name),
                onTap: () {
                  _editDepartment(index);
                },
              ),
            );
          },
        ),
      ),
      SizedBox(height: 16.0),
      ElevatedButton(
        onPressed: _addDepartment,
        child: Text('Add Department'),
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