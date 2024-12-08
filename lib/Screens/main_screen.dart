import 'package:flutter/material.dart';
import 'category_selection_screen.dart'; // CategorySelectionScreen 이동을 위해 import

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'LawReady',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
                fontFamily: 'NotoSans',
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CategorySelectionScreen()),
                );
              },
              child: Text(
                '문서 작성하러가기',
                style: TextStyle(fontSize: 20, color: Colors.white, fontFamily: 'NotoSans'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

