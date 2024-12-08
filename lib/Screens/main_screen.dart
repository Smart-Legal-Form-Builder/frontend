import 'package:flutter/material.dart';
import 'category_selection_screen.dart'; // CategorySelectionScreen 이동을 위해 import


class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center( // 화면 중앙에 정렬
        child: Column(
          mainAxisSize: MainAxisSize.min, // 내용물만 차지하도록 크기 설정
          children: [
            Text(
              'LawReady',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
                fontFamily: 'RobotoBlack',
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20), // 텍스트와 버튼 사이 간격
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategorySelectionScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15), // 버튼 내부 여백
                textStyle: TextStyle(fontSize: 20, fontFamily: 'NotoSans'), // 글자 스타일
                backgroundColor: Colors.indigo, // 버튼 색상
                foregroundColor: Colors.white,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // 버튼 모서리 둥글게
                ),
              ),
              child: Text('고소장 작성하러 가기'),
            ),
          ],
        ),
      ),
    );
  }
}