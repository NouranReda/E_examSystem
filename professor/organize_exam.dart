import 'package:flutter/material.dart';

class OrganizeExamPage extends StatefulWidget {
  @override
  _OrganizeExamPageState createState() => _OrganizeExamPageState();
}

class _OrganizeExamPageState extends State<OrganizeExamPage> {
  List<Chapter> _chapters = [];
  List<Question> _questions = [];
  List<String> _selectedChapters = [];
  List<String> _selectedQuestions = [];
  int _totalMarks = 0;
  int _passingMarks = 0;

  void _addChapter() {
    String chapterName = 'Chapter ${_chapters.length + 1}';
    setState(() {
      _chapters.add(Chapter(name: chapterName));
    });
  }

  void _addQuestion() {
    String questionText = 'Question ${_questions.length + 1}';
    String option1 = 'Option 1';
    String option2 = 'Option 2';
    String option3 = 'Option 3';
    String option4 = 'Option 4';

    setState(() {
      _questions.add(Question(
          text: questionText,
          options: [option1, option2, option3, option4],
          correctAnswer: 'Option 1'
      ));
    });
  }

  void _removeChapter(int index) {
    setState(() {
      _chapters.removeAt(index);
    });
  }

  void _removeQuestion(int index) {
    setState(() {
      _questions.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Organize Exam'),
        ),
        body: Padding(
        padding: const EdgeInsets.all(16.0),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text(
    'Add Chapters',
    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
    ),
    SizedBox(height: 16.0),
    Expanded(
    child: ListView.builder(
    itemCount: _chapters.length,
    itemBuilder: (context, index) {
    return Dismissible(
    key: UniqueKey(),
    direction: DismissDirection.endToStart,
    onDismissed: (direction) {
    _removeChapter(index);
    },
    background: Container(
    color: Colors.red,
    alignment: Alignment.centerRight,
    padding: EdgeInsets.only(right: 16.0),
    child: Icon(Icons.delete, color: Colors.white),
    ),
    child: ListTile(
    title: Text(_chapters[index].name),
    trailing: Text('${_chapters[index].numberOfQuestions} Questions'),
    onTap: () {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ChapterQuestionsPage(chapter: _chapters[index], questions: _questions)));
    },
    ),
    );
    },
    ),
    ),
    SizedBox(height: 16.0),
    ElevatedButton(
    onPressed: _addChapter,
    child: Text('Add Chapter'),
    ),
    SizedBox(height: 32.0),
    Text(
    'Add Questions',
    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
    ),
    SizedBox(height: 16.0),
    Expanded(
    child: ListView.builder(
    itemCount: _questions.length,
    itemBuilder: (context, index) {
    return Dismissible(
    key: UniqueKey(),
    direction: DismissDirection.endToStart,
    onDismissed: (direction) {
    _removeQuestion(index);
    },
    background: Container(
    color: Colors.red,
    alignment: Alignment.centerRight,
    padding: EdgeInsets.only(right: 16.0),
    child: Icon(Icons.delete, color: Colors.white),
    ),
    child: ListTile(
    title: Text(_questions[index].text),
      subtitle: Text(_questions[index].options.join(", ")),
      trailing: Text('Correct Answer: ${_questions[index].correctAnswer}'),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => EditQuestionPage(question: _questions[index])));
      },
    ),
    );
    },
    ),
    ),
      SizedBox(height: 16.0),
      ElevatedButton(
        onPressed: _addQuestion,
        child: Text('Add Question'),
      ),
      SizedBox(height: 32.0),
      Text(
        'Exam Settings',
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 16.0),
      Row(
        children: [
          Expanded(
            flex: 1,
            child: TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                _totalMarks = int.tryParse(value) ?? 0;
              },
              decoration: InputDecoration(
                labelText: 'Total Marks',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(width: 16.0),
          Expanded(
            flex: 1,
            child: TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                _passingMarks = int.tryParse(value) ?? 0;
              },
              decoration: InputDecoration(
                labelText: 'Passing Marks',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: 32.0),
      ElevatedButton(
        onPressed: () {
          // TODO: Save exam settings
        },
        child: Text('Save Exam Settings'),
      ),
    ],
    ),
        ),
    );
  }
}

class ChapterQuestionsPage extends StatefulWidget {
  final Chapter chapter;
  final List<Question> questions;

  ChapterQuestionsPage({required this.chapter, required this.questions});

  @override
  _ChapterQuestionsPageState createState() => _ChapterQuestionsPageState();
}

class _ChapterQuestionsPageState extends State<ChapterQuestionsPage> {
  List<String> _selectedQuestions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text(widget.chapter.name),
    ),
    body: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text(
    'Select Questions',
    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
    ),
    SizedBox(height: 16.0),
    Expanded(
    child: ListView.builder(
    itemCount: widget.questions.length,
    itemBuilder: (context, index) {
    return CheckboxListTile(
    title: Text(widget.questions[index].text),
    subtitle: Text(widget.questions[index].options.join(", ")),
    value: _selectedQuestions.contains(widget.questions[index].text),
    onChanged: (value) {
    setState(() {
    if (value == true) {
    _selectedQuestions.add(widget.questions[index].text);
    } else {
    _selectedQuestions.remove(widget.questions[index].text);
    }
    });
    },
    );
    },
    ),
    ),
    SizedBox(height: 16.0),
    ElevatedButton(
    onPressed: () {
    setState(() {widget.chapter.numberOfQuestions = _selectedQuestions.length;
    });
    Navigator.pop(context);
    },
      child: Text('Save'),
    ),
    ],
    ),
    ),
    );
  }
}

class EditQuestionPage extends StatefulWidget {
  final Question question;

  EditQuestionPage({required this.question});

  @override
  _EditQuestionPageState createState() => _EditQuestionPageState();
}

class _EditQuestionPageState extends State<EditQuestionPage> {
  TextEditingController _textEditingController = TextEditingController();
  List<TextEditingController> _optionControllers = [];

  @override
  void initState() {
    super.initState();
    _textEditingController.text = widget.question.text;
    widget.question.options.forEach((option) {
      _optionControllers.add(TextEditingController(text: option));
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _optionControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Question'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _textEditingController,
              onChanged: (value) {
                widget.question.text = value;
              },
              decoration: InputDecoration(
                labelText: 'Question Text',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            Text('Options:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            Column(
              children: List.generate(
                _optionControllers.length,
                    (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: TextField(
                      controller: _optionControllers[index],
                      onChanged: (value) {
                        widget.question.options[index] = value;
                      },
                      decoration: InputDecoration(
                        labelText: 'Option ${index + 1}',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                widget.question.correctAnswer = widget.question.options[0];
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        ),
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