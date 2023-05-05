import 'package:flutter/material.dart';
import 'package:e_exam/professor/organize_exam.dart';
class ProfessorPage extends StatefulWidget {
  @override
  _ProfessorPageState createState() => _ProfessorPageState();
}

class _ProfessorPageState extends State<ProfessorPage> {
  List<Chapter> _chapters = [];
  List<Question> _questions = [];
  List<String> _selectedChapters = [];
  int _allowedTime = 0;

  final _chapterController = TextEditingController();
  final _questionController = TextEditingController();
  final _option1Controller = TextEditingController();
  final _option2Controller = TextEditingController();
  final _option3Controller = TextEditingController();
  final _option4Controller = TextEditingController();
  String _correctAnswer = '';

  void _addChapter() {
    String chapterName = _chapterController.text.trim();
    if (chapterName.isNotEmpty && !_chapters.any((c) => c.name == chapterName)) {
      setState(() {
        _chapters.add(Chapter(name: chapterName));
      });
      _chapterController.clear();
    }
  }

  void _addQuestion() {
    String questionText = _questionController.text.trim();
    String option1 = _option1Controller.text.trim();
    String option2 = _option2Controller.text.trim();
    String option3 = _option3Controller.text.trim();
    String option4 = _option4Controller.text.trim();

    if (questionText.isNotEmpty && option1.isNotEmpty && option2.isNotEmpty && option3.isNotEmpty && option4.isNotEmpty && _correctAnswer.isNotEmpty) {
      setState(() {
        _questions.add(Question(
            text: questionText,
            options: [option1, option2, option3, option4],
            correctAnswer: _correctAnswer
        ));
      });
      _questionController.clear();
      _option1Controller.clear();
      _option2Controller.clear();
      _option3Controller.clear();
      _option4Controller.clear();
      _correctAnswer = '';
    }
  }

  void _publishQuestions() {
    // TODO: Publish questions to students
  }

  void _organizeExam() {
    // TODO: Organize exam structure
  }

  void _showResults() {
    // TODO: Show results of students
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Professor Page'),
    ),
    body: SingleChildScrollView(
    child: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text(
    'Add/Edit Chapters',
    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
    ),
    TextField(
    controller: _chapterController,
    decoration: InputDecoration(
    hintText: 'Chapter name'
    ),
    ),
    ElevatedButton(
    onPressed: _addChapter,
    child: Text('Add Chapter'),
    ),
    SizedBox(height: 16.0),
    Text(
    'Selected Chapters: ${_selectedChapters.join(", ")}',
    style: TextStyle(fontSize: 16.0),
    ),
    DropdownButtonFormField(
    hint: Text('Select Chapter'),
    items: _chapters.map((c) => DropdownMenuItem(value: c.name, child: Text(c.name))).toList(),
    onChanged: (value) {
    setState(() {
    if (_selectedChapters.contains(value)) {
    _selectedChapters.remove(value);
    } else {
    //_selectedChapters.add(value);
    }
    });
    },
    ),
    SizedBox(height: 32.0),
    Text(
    'Add/Edit Questions',
    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
    ),
    TextField(
    controller: _questionController,
    decoration: InputDecoration(
    hintText: 'Question text'
    ),
    ),
    TextField(controller: _option1Controller,
      decoration: InputDecoration(
          hintText: 'Option 1'
      ),
    ),
      TextField(
        controller: _option2Controller,
        decoration: InputDecoration(
            hintText: 'Option 2'
        ),
      ),
      TextField(
        controller: _option3Controller,
        decoration: InputDecoration(
            hintText: 'Option 3'
        ),
      ),
      TextField(
        controller: _option4Controller,
        decoration: InputDecoration(
            hintText: 'Option 4'
        ),
      ),
      SizedBox(height: 16.0),
      Text('Correct Answer: $_correctAnswer'),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                _correctAnswer = 'Option 1';
              });
            },
            child: Text('Option 1'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _correctAnswer = 'Option 2';
              });
            },
            child: Text('Option 2'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _correctAnswer = 'Option 3';
              });
            },
            child: Text('Option 3'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _correctAnswer = 'Option 4';
              });
            },
            child: Text('Option 4'),
          ),
        ],
      ),
      ElevatedButton(
        onPressed: _addQuestion,
        child: Text('Add Question'),
      ),
      SizedBox(height: 16.0),
      ElevatedButton(
        onPressed: _publishQuestions,
        child: Text('Publish Questions'),
      ),
      SizedBox(height: 32.0),
      ElevatedButton(onPressed: ()
        {
          Navigator.push(context,
          MaterialPageRoute(builder:
          (context)=>  OrganizeExamPage()),
          );
        }
          , child:  Text(
          'Organize Exam',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ),

      // TODO: Implement exam organization UI
      SizedBox(height: 32.0),
      ElevatedButton(onPressed: _showResults,
          child: Text(
            'Show Results',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),)

      // TODO: Implement show results UI
    ],
    ),
    ),
    ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text('Allowed Time'),
              content: TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  _allowedTime = int.tryParse(value) ?? 0;
                },
                decoration: InputDecoration(
                    hintText: 'Allowed time in minutes'
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // TODO: Save allowed time
                  },
                  child: Text('Save'),
                ),
              ],
            ),
          );
        },
        child: Icon(Icons.timer),
      ),
    );
  }
}

class Chapter {
  String name;
  int numberOfQuestions;
  Chapter({required this.name, this.numberOfQuestions = 0});
}

class Question {
  String text;
  List<String> options;
  String correctAnswer;

  Question({required this.text, required this.options, required this.correctAnswer});
}