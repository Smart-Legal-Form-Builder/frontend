import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'pdf_result_screen.dart'; // PDF 결과 화면 import

class LoadingScreen extends StatefulWidget {
  final String category;
  final Map<String, String> data;

  LoadingScreen({required this.category, required this.data});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    _generatePdf();
  }

  Future<void> _generatePdf() async {
    final url = Uri.parse('http://localhost:3000/generate-pdf'); // 백엔드 URL

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'category': widget.category,
          'data': widget.data,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final pdfPath = responseData['pdfPath'];

        // PDF 생성 성공 시 PdfResultScreen으로 이동
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => PdfResultScreen(pdfPath: pdfPath),
        ));
      } else {
        // 실패 시 에러 메시지 표시
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('PDF 생성 실패. 다시 시도해주세요.')),
        );
        Navigator.of(context).pop(); // 이전 화면으로 복귀
      }
    } catch (e) {
      // 네트워크 또는 기타 오류 처리
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('오류 발생: $e')),
      );
      Navigator.of(context).pop(); // 이전 화면으로 복귀
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text('잠시만 기다려주세요! PDF를 생성 중입니다...'),
          ],
        ),
      ),
    );
  }
}
