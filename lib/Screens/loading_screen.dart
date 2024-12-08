import 'package:flutter/material.dart';
import 'dart:async'; // Future.delayed를 사용하기 위해 필요
import 'pdf_result_screen.dart'; // PdfResultScreen import 추가

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
    _startLoading();
  }

  void _startLoading() async {
    // 2초 동안 대기
    await Future.delayed(Duration(seconds: 2));

    // 로딩 완료 후 PdfResultScreen으로 이동
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => PdfResultScreen(
          category: widget.category,
          userDetails: widget.data,
        ),
      ),
    );
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
            Text(
              '잠시만 기다려주세요...',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'NotoSans',
                )
            ),
          ],
        ),
      ),
    );
  }
}
