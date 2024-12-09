import 'package:flutter/material.dart';
import 'loading_screen.dart'; // 로딩 화면 import
import '../utils/form_questions.dart'; // 질문 관련 유틸리티 가져오기

class DocumentForm extends StatefulWidget {
  final String category;

  DocumentForm({required this.category}); // 생성자에서 required 추가

  @override
  _DocumentFormState createState() => _DocumentFormState();
}

class _DocumentFormState extends State<DocumentForm> {
  final Map<String, TextEditingController> controllers = {};

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    final questions = categoryFields[widget.category];
    if (questions != null) {
      for (var question in questions) {
        controllers[question['key']!] = TextEditingController();
      }
    }
  }

  String _getLabelForKey(String key) {
    final questions = categoryFields[widget.category];
    if (questions != null) {
      return questions.firstWhere((q) => q['key'] == key)['label']!;
    }
    return '';
  }

  String _getPlaceHolderForKey(String key) {
    final questions = categoryFields[widget.category];
    if (questions != null) {
      return questions.firstWhere((q) => q['key'] == key)['placeholder']!;
    }
    return '';
  }

  void _onSubmit() {
    bool allFieldsFilled = controllers.values.every((controller) => controller.text.isNotEmpty);

    if (!allFieldsFilled) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('모든 필드를 입력해주세요.',
          style: TextStyle(
          fontFamily: 'NotoSans',
        ))),
      );
      return;
    }

    final data = {
      for (var entry in controllers.entries) entry.key: entry.value.text,
    };

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => LoadingScreen(
        category: widget.category,
        data: data,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text('${widget.category} 고소장 작성',
          style: TextStyle(
            fontFamily: 'NotoSans',
            color: Colors.white,
          ),
        ),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: controllers.entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(
                      controller: entry.value,
                      decoration: InputDecoration(
                        labelText: _getLabelForKey(entry.key),
                        labelStyle: TextStyle(
                          color: Colors.indigo,
                          fontFamily: 'NotoSans',
                        ),
                        hintText: _getPlaceHolderForKey(entry.key),
                        hintStyle: TextStyle(
                          color: Color(0xFFA7AFC0),
                          fontFamily: 'NotoSans',
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo,),
              onPressed: _onSubmit,
              child: Text('고소장 생성',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'NotoSans',
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
