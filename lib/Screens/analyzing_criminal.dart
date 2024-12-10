import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AnalyzingCriminal extends StatefulWidget {
  const AnalyzingCriminal({Key? key}) : super(key: key);

  @override
  State<AnalyzingCriminal> createState() => _AnalyzingCriminalState();
}

class _AnalyzingCriminalState extends State<AnalyzingCriminal> {
  final TextEditingController _queryController = TextEditingController();
  bool _isLoading = false;
  Map<String, dynamic>? _result;

  // Flask 서버와 통신하는 함수
  Future<void> _analyzeQuery(String query) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('http://192.168.219.108:8000/ask'),  // 네트워크 IP 사용
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'query': query}),
      );

      if (response.statusCode == 200) {
        setState(() {
          _result = jsonDecode(utf8.decode(response.bodyBytes));
          _isLoading = false;
        });
      } else {
        throw Exception('서버 응답 오류');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // 에러 처리
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('분석 중 오류가 발생했습니다.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI 법률 상담'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 상단 설명 텍스트
            const Text(
              'AI ',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // 입력 필드
            TextField(
              controller: _queryController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'ex)"중고나라에서 게임기를 샀는데 판매자가 잠적해서 입금한 돈 300,000원을 돌려받지못했습니다. 경찰서에 가서 어떻게 행동하면 될까요?"처럼 사건의 경위와 AI 변호사의 조언이 필요한 부분을 적어주세요!',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // 분석 버튼
            ElevatedButton(
              onPressed: _isLoading
                  ? null
                  : () => _analyzeQuery(_queryController.text),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(_isLoading ? '분석 중...' : 'AI 분석 시작'),
              ),
            ),
            const SizedBox(height: 20),

            // 결과 표시
            if (_result != null) ...[
              // AI 변호사 팁
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'AI 변호사의 팁',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(_result!['AI_변호사_팁']),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // 예상 합의금 및 형량
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Text(
                        '예상 합의금과 형량',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              const Text('평균 합의금'),
                              Text(
                                '${_result!['평균_합의금'].toString()}원',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const Text('평균 징역'),
                              Text(
                                '${_result!['평균_징역'].toString()}개월',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // 유사 판례들
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '유사 판례',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...(_result!['판례들'] as List).asMap().entries.map(
                            (entry) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '판례 ${entry.key + 1}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(entry.value['content']),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '합의금: ${entry.value['settlement']}원',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      '형량: ${entry.value['sentence']}개월',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                if (entry.key < (_result!['판례들'] as List).length - 1)
                                  const Divider(height: 24),
                              ],
                            ),
                          ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
  }
}