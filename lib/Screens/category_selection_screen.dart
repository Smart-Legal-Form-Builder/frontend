import 'package:flutter/material.dart';
import 'document_form.dart'; // DocumentForm 이동을 위해 import

class CategorySelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.indigo),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '먼저, 카테고리를 설정해주세요!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _buildCategoryTile(context, '중고거래 사기'),
                  _buildCategoryTile(context, '온라인 욕설'),
                  _buildCategoryTile(context, '성희롱/성추행'),
                  _buildCategoryTile(context, '폭행/상해'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryTile(BuildContext context, String title) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: EdgeInsets.symmetric(vertical: 10),
      elevation: 2,
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.indigo,
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.indigo),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => DocumentForm(title)),
          );
        },
      ),
    );
  }
}

