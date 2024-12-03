import 'package:flutter/material.dart';
import 'completion_screen.dart'; // CompletionScreen import 추가

class PdfResultScreen extends StatelessWidget {
  final String pdfPath;

  PdfResultScreen({required this.pdfPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF 생성 완료'),
      ),
      body: Center( // Center 위젯으로 중앙 정렬
        child: Column(
          mainAxisSize: MainAxisSize.min, // 내용 크기만큼만 Column 확장
          children: [
            Text(
              'PDF가 성공적으로 생성되었습니다!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // PDF 미리보기 로직 추가
                print('PDF 미리보기: $pdfPath');
              },
              child: Text('PDF 미리보기'),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                // PDF 다운로드 로직 추가
                print('PDF 다운로드: $pdfPath');
              },
              child: Text('PDF 다운로드'),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // '다음' 버튼 클릭 시 CompletionScreen으로 이동
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CompletionScreen(),
                  ),
                );
              },
              child: Text('다음'),
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

