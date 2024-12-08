import '../utils/form_questions.dart';

final Map<String, List<Map<String, String>>> categoryFields = {
  '중고거래 사기': [
    {'label': '피해자 본인의 이름', 'key': 'complainant_name'},
    {'label': '주민등록번호', 'key': 'complainant_id'},
    {'label': '주소', 'key': 'complainant_address'},
    {'label': '전화번호', 'key': 'complainant_phone'},
    {'label': '거래 물품', 'key': 'transaction_item'},
    {'label': '거래 일자', 'key': 'transaction_date'},
    {'label': '사이트명', 'key': 'site_name'},
    {'label': '피해 금액', 'key': 'amount'},
    {'label': '상대방 이름', 'key': 'defendant_name'},
    {'label': '상대방 전화번호', 'key': 'defendant_phone'},
    {'label': '고소 날짜', 'key': 'report_date'},
    {'label': '관할 경찰서', 'key': 'police_station'},
  ],
  '온라인 욕설': [
    {'label': '피해자 본인의 이름', 'key': 'complainant_name'},
    {'label': '주민등록번호', 'key': 'complainant_id'},
    {'label': '닉네임', 'key': 'complainant_nickname'},
    {'label': '전화번호', 'key': 'complainant_phone'},
    {'label': '주소', 'key': 'complainant_address'},
    {'label': '가해자 닉네임', 'key': 'defendant_nickname'},
    {'label': '사건 일자', 'key': 'incident_date'},
    {'label': '웹사이트', 'key': 'website'},
    {'label': '욕설 내용', 'key': 'offensive_comment'},
    {'label': '고소 날짜', 'key': 'report_date'},
    {'label': '관할 경찰서', 'key': 'police_station'},
  ],
  '성희롱': [
    {'label': '피해자 본인의 이름', 'key': 'complainant_name'},
    {'label': '주민등록번호', 'key': 'complainant_id'},
    {'label': '주소', 'key': 'complainant_address'},
    {'label': '전화번호', 'key': 'complainant_phone'},
    {'label': '가해자와의 관계', 'key': 'relationship1'},
    {'label': '가해자 이름', 'key': 'defendant_name'},
    {'label': '가해자 주소', 'key': 'defendant_address'},
    {'label': '가해자 전화번호', 'key': 'defendant_phone'},
    {'label': '사건 일자', 'key': 'incident_date'},
    {'label': '사건 장소', 'key': 'incident_location'},
    {'label': '사건 당시 같이 있던 사람들의 수', 'key': 'people'},
    {'label': '문제 발언', 'key': 'offensive_comment'},
    {'label': '고소 날짜', 'key': 'report_date'},
    {'label': '관할 경찰서', 'key': 'police_station'},
  ],
  '강제추행': [
    {'label': '피해자 본인의 이름', 'key': 'complainant_name'},
    {'label': '주민등록번호', 'key': 'complainant_id'},
    {'label': '주소', 'key': 'complainant_address'},
    {'label': '전화번호', 'key': 'complainant_phone'},
    {'label': '가해자 이름', 'key': 'defendant_name'},
    {'label': '사건 일자', 'key': 'incident_date'},
    {'label': '사건 장소', 'key': 'incident_location'},
    {'label': '가해자와의 관계', 'key': 'relationship2'},
    {'label': '피해 사실', 'key': 'facts'},
    {'label': '고소 날짜', 'key': 'report_date'},
    {'label': '관할 경찰서', 'key': 'police_station'},
  ],
};

/// 선택한 카테고리의 질문 목록을 반환하는 함수
List<String> getQuestions(String category) {
  final fields = categoryFields[category];
  if (fields != null) {
    return fields.map((field) => field['label']!).toList();
  }
  return [];
}
