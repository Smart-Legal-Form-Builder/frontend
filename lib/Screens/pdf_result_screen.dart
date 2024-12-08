import 'package:flutter/material.dart';
import 'package:dio/dio.dart'; // HTTP 요청을 위해 Dio 패키지 사용
import 'dart:html' as html; // 웹에서 파일 다운로드 및 열기를 위해 필요
import 'completion_screen.dart'; // CompletionScreen import 추가

class PdfResultScreen extends StatefulWidget {
  final String category;
  final Map<String, String> userDetails;

  PdfResultScreen({required this.category, required this.userDetails});

  @override
  _PdfResultScreenState createState() => _PdfResultScreenState();
}

class _PdfResultScreenState extends State<PdfResultScreen> {
  String? pdfUrl;

  // PDF 생성 요청
  Future<void> _generatePdf() async {
    try {
      final dio = Dio();
      final response = await dio.post(
        'http://localhost:5000/api/generate-complaint',
        data: {
          'category': widget.category,
          'userDetails': widget.userDetails,
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          pdfUrl = response.data['fileUrl'];
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('PDF가 성공적으로 생성되었습니다!',
            style: TextStyle(
            fontFamily: 'NotoSans',
          ))),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('PDF 생성에 실패했습니다.',
            style: TextStyle(
            fontFamily: 'NotoSans',
          ))),
        );
      }
    } catch (e) {
      print('PDF 생성 실패: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('PDF 생성에 실패했습니다: $e',
          style: TextStyle(
          fontFamily: 'NotoSans',
        ))),
      );
    }
  }

  // PDF 미리보기 기능 (브라우저 새 탭에서 열기)
  void _previewPdf() {
    if (pdfUrl != null) {
      html.window.open(pdfUrl!, '_blank');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('PDF가 아직 생성되지 않았습니다.',
          style: TextStyle(
          fontFamily: 'NotoSans',
        ))),
      );
    }
  }

  // PDF 다운로드 기능 (웹 전용)
  void _downloadPdf() {
    if (pdfUrl != null) {
      final anchor = html.AnchorElement(href: pdfUrl!)
        ..setAttribute('download', 'complaint.pdf')
        ..click();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('PDF가 아직 생성되지 않았습니다.',
          style: TextStyle(
          fontFamily: 'NotoSans',
        ))),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _generatePdf(); // 화면이 로드될 때 PDF 생성 요청 보내기
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF 생성 완료',
          style: TextStyle(
          fontFamily: 'NotoSans',
        )),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'PDF가 성공적으로 생성되었습니다!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'NotoSans'),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _previewPdf,
              child: Text('PDF 미리보기',
                style: TextStyle(
                  fontFamily: 'NotoSans',
                  )),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: _downloadPdf,
              child: Text('PDF 다운로드',
                style: TextStyle(
                  fontFamily: 'NotoSans',
                  )),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CompletionScreen(),
                  ),
                );
              },
              child: Text('다음',
                style: TextStyle(
                  fontFamily: 'NotoSans',
                  )),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
