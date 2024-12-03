import 'package:flutter/material.dart';
import 'main_screen.dart';

class CompletionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '수고하셨어요! 또 다른 문서가 필요하시면\n메인으로 돌아가기 버튼을 눌러주세요.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => MainScreen()),
                  (route) => false,
                );
              },
              child: Text('메인으로 돌아가기'),
            ),
          ],
        ),
      ),
    );
  }
}


