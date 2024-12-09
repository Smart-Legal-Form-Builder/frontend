import 'package:flutter/material.dart';
import 'document_form.dart'; // DocumentForm 이동을 위해 import

class CategorySelectionScreen extends StatelessWidget {
  final List<String> categories = [
    '중고거래 사기',
    '온라인 욕설',
    '성희롱',
    '강제추행'
  ];
  final List<String> categoryExplain = [
    '\n\n온라인 중고거래 과정에서 발생하는\n허위매물, 결제 사기 등 금전적 피해\n사례에 대한 고소장 작성',
    '\n\n게임, SNS 등 온라인 공간에서\n발생하는 악성 댓글, 혐오 발언 등의\n언어폭력에 대한 고소장 작성',
    '\n\n일상생활에서 발생하는\n불쾌한 성적 발언이나 행동에 대한\n고소장 작성',
    '\n\n물리적인 강제 접촉이나\n추행 등의 성범죄에 대한\n고소장 작성'
  ];

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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '작성할 고소장의 카테고리를 선택해주세요!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
                fontFamily: 'NotoSans',
              ),
            ),
            SizedBox(height: 20),
            Container(
              constraints: BoxConstraints(maxHeight: 600), // GridView 높이 제한
              child: GridView.builder(
                shrinkWrap: true, // GridView 크기를 자식 항목에 맞춤
                physics: NeverScrollableScrollPhysics(), // 스크롤 비활성화
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 한 행에 2개의 버튼
                  crossAxisSpacing: 10, // 버튼 간의 가로 간격
                  mainAxisSpacing: 10, // 버튼 간의 세로 간격
                  childAspectRatio: 1.0, // 버튼의 가로:세로 비율
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return _buildCategoryTile(context, categories[index], categoryExplain[index]);
                },
              ),
            ),
            SizedBox(height: 40),
            Text(
              '[제출 전 주의사항]',
              style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
              fontFamily: 'NotoSans',
              ),
            ),
            SizedBox(height: 10),
            Text(
              '허위사실에 기반한 고소는 무고죄로 처벌받을 수 있음을 고지합니다.',
              style: TextStyle(
              fontSize: 14,
              fontFamily: 'NotoSans',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryTile(BuildContext context, String title, String explain) {
    return Card(
      color: Colors.indigo,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 2,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DocumentForm(category: title),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontFamily: 'NotoSans',
                ),
              ),
              SizedBox(height: 10),
              Text(
                explain,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  /*
  Widget _buildCategoryTile(BuildContext context, String title, String explain) {
    return Card(
      color: Colors.indigo,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: EdgeInsets.symmetric(vertical: 10),
      elevation: 2,
      child: ListTile(
        title: RichText(
          text: TextSpan(
            text: title, // default text style
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontFamily: 'NotoSans',
            ),
            children: <TextSpan>[
              TextSpan(text: explain, style: TextStyle(fontSize: 12)),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DocumentForm(category: title),
            ),
          );
        },
      ),
    );
  }
  */
}

