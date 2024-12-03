import 'package:flutter/material.dart';
import 'loading_screen.dart'; // 로딩 화면 import
import '../utils/form_questions.dart'; // 질문 관련 유틸리티 가져오기

class DocumentForm extends StatefulWidget {
  final String category;

  DocumentForm(this.category);

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
    final questions = getQuestions(widget.category); // 질문 목록 가져오기
    for (var question in questions) {
      controllers[question] = TextEditingController();
    }
  }

  void _onSubmit() {
    // 사용자가 입력한 데이터를 Map으로 변환
    final data = {
      for (var entry in controllers.entries) entry.key: entry.value.text,
    };

    // 로딩 화면으로 이동하며 입력 데이터 전달
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
      appBar: AppBar(
        title: Text('${widget.category} 문서 작성'),
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
                        labelText: entry.key,
                        border: OutlineInputBorder(),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            ElevatedButton(
              onPressed: _onSubmit,
              child: Text('고소장 생성'),
            ),
          ],
        ),
      ),
    );
  }
}

