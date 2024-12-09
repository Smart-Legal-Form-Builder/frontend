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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text('PDF 생성 완료',
          style: TextStyle(
          fontFamily: 'NotoSans',
          color: Colors.white,
        )),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '고소장이 성공적으로 생성되었습니다!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'NotoSans'),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 21),
              ),
              onPressed: _downloadPdf,
              child: Text('PDF로 다운받기',
                  style: TextStyle(
                    fontFamily: 'NotoSans',
                    color: Colors.white,
                  )),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              ),
              onPressed: _previewPdf,
              child: Text('사건 리포트 보기',
                  style: TextStyle(
                    fontFamily: 'NotoSans',
                    color: Colors.white,
                  )),
            ),
            SizedBox(height: 50),
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
                  color: Colors.white,
                  )),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
