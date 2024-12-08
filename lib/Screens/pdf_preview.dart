import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // PDF 파일 읽기용
import 'dart:io';

class PdfPreviewScreen extends StatelessWidget {
  final String pdfPath;

  PdfPreviewScreen({required this.pdfPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF 미리보기',
          style: TextStyle(
          fontFamily: 'NotoSans',
        )),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: FutureBuilder<String>(
        future: _loadPdfText(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('PDF 파일을 불러오는 데 실패했습니다.',
              style: TextStyle(
              fontFamily: 'NotoSans',
              )
            ));
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Text(snapshot.data ?? 'PDF 내용이 없습니다.',
                  style: TextStyle(
                  fontFamily: 'NotoSans',
                  )
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Future<String> _loadPdfText() async {
    try {
      final file = File(pdfPath);
      return await file.readAsString();
    } catch (e) {
      return 'PDF 파일을 읽는 중 오류가 발생했습니다.';
    }
  }
}
