import '../utils/form_questions.dart';

final Map<String, List<Map<String, String>>> categoryFields = {
  '중고거래 사기': [
    {'label': '피해자 이름', 'placeholder':'피해자 본인의 이름을 입력해주세요.', 'key': 'complainant_name'},
    {'label': '주민등록번호', 'placeholder':'피해자 본인의 주민등록번호 13자리를 입력해주세요.', 'key': 'complainant_id'},
    {'label': '주소', 'placeholder':'피해자 본인의 소재지를 입력해주세요.', 'key': 'complainant_address'},
    {'label': '전화번호', 'placeholder':'피해자 본인의 전화번호를 입력해주세요.', 'key': 'complainant_phone'},
    {'label': '거래 물품', 'placeholder':'사기를 당한 거래 물품을 입력해주세요.', 'key': 'transaction_item'},
    {'label': '거래 일자', 'placeholder':'사기를 당한 거래의 일자를 입력해주세요.', 'key': 'transaction_date'},
    {'label': '사이트명', 'placeholder':'사기를 당한 거래를 진행한 사이트의 명칭을 입력해주세요.', 'key': 'site_name'},
    {'label': '피해 금액', 'placeholder':'사기의 피해 금액을 입력해주세요.', 'key': 'amount'},
    {'label': '상대방 이름', 'placeholder':'사기 행위를 저지른 상대방의 이름을 입력해주세요.', 'key': 'defendant_name'},
    {'label': '상대방 전화번호', 'placeholder':'사기 행위를 저지른 상대방의 전화번호를 입력해주세요.', 'key': 'defendant_phone'},
    {'label': '고소 날짜', 'placeholder':'고소를 신청할 날짜를 입력해주세요.', 'key': 'report_date'},
    {'label': '관할 경찰서', 'placeholder':'고소를 신청할 관할 경찰서 명을 입력해주세요.', 'key': 'police_station'},
  ],
  '온라인 욕설': [
    {'label': '피해자 이름', 'placeholder':'피해자 본인의 이름을 입력해주세요.', 'key': 'complainant_name'},
    {'label': '주민등록번호', 'placeholder':'피해자 본인의 주민등록번호 13자리를 입력해주세요.', 'key': 'complainant_id'},
    {'label': '닉네임', 'placeholder':'피해자 본인의 온라인 닉네임을 입력해주세요.', 'key': 'complainant_nickname'},
    {'label': '전화번호', 'placeholder':'피해자 본인의 전화번호를 입력해주세요.', 'key': 'complainant_phone'},
    {'label': '주소', 'placeholder':'피해자 본인의 소재지를 입력해주세요.', 'key': 'complainant_address'},
    {'label': '가해자 닉네임', 'placeholder':'욕설을 한 상대방의 온라인 닉네임을 입력해주세요.', 'key': 'defendant_nickname'},
    {'label': '사건 일자', 'placeholder':'욕설을 당한 날짜를 입력해주세요.', 'key': 'incident_date'},
    {'label': '웹사이트', 'placeholder':'욕설을 당한 온라인 웹사이트의 이름을 입력해주세요.', 'key': 'website'},
    {'label': '욕설 내용', 'placeholder':'상대방이 한 욕설의 내용을 입력해주세요.', 'key': 'offensive_comment'},
    {'label': '고소 날짜', 'placeholder':'고소를 신청할 날짜를 입력해주세요.', 'key': 'report_date'},
    {'label': '관할 경찰서', 'placeholder':'고소를 신청할 관할 경찰서 명을 입력해주세요.', 'key': 'police_station'},
  ],
  '성희롱': [
    {'label': '피해자 이름', 'placeholder':'피해자 본인의 이름을 입력해주세요.', 'key': 'complainant_name'},
    {'label': '주민등록번호', 'placeholder':'피해자 본인의 주민등록번호 13자리를 입력해주세요.', 'key': 'complainant_id'},
    {'label': '주소', 'placeholder':'피해자 본인의 소재지를 입력해주세요.', 'key': 'complainant_address'},
    {'label': '전화번호', 'placeholder':'피해자 본인의 전화번호를 입력해주세요.', 'key': 'complainant_phone'},
    {'label': '가해자와의 관계', 'placeholder':'성희롱을 저지른 상대방과 본인의 관계를 입력해주세요.', 'key': 'relationship1'},
    {'label': '가해자 이름', 'placeholder':'성희롱을 저지른 상대방의 이름을 입력해주세요.', 'key': 'defendant_name'},
    {'label': '가해자 주소', 'placeholder':'성희롱을 저지른 상대방의 소재지를 입력해주세요.', 'key': 'defendant_address'},
    {'label': '가해자 전화번호', 'placeholder':'성희롱을 저지른 상대방의 전화번호를 입력해주세요.', 'key': 'defendant_phone'},
    {'label': '사건 일자', 'placeholder':'성희롱을 당한 날짜를 입력해주세요.', 'key': 'incident_date'},
    {'label': '사건 장소', 'placeholder':'성희롱을 당한 장소를 입력해주세요.', 'key': 'incident_location'},
    {'label': '사건 당시 같이 있던 사람들의 수', 'placeholder':'성희롱을 당할 때 같이 있었던 사람의 수를 입력해주세요.', 'key': 'people'},
    {'label': '문제 발언', 'placeholder':'상대방의 성희롱 발언을 입력해주세요.', 'key': 'offensive_comment'},
    {'label': '고소 날짜', 'placeholder':'고소를 신청할 날짜를 입력해주세요.', 'key': 'report_date'},
    {'label': '관할 경찰서', 'placeholder':'고소를 신청할 관할 경찰서 명을 입력해주세요.', 'key': 'police_station'},
  ],
  '강제추행': [
    {'label': '피해자 이름', 'placeholder':'피해자 본인의 이름을 입력해주세요.', 'key': 'complainant_name'},
    {'label': '주민등록번호', 'placeholder':'피해자 본인의 주민등록번호 13자리를 입력해주세요.', 'key': 'complainant_id'},
    {'label': '주소', 'placeholder':'피해자 본인의 소재지를 입력해주세요.', 'key': 'complainant_address'},
    {'label': '전화번호', 'placeholder':'피해자 본인의 전화번호를 입력해주세요.', 'key': 'complainant_phone'},
    {'label': '가해자 이름', 'placeholder':'강제추행을 저지른 상대방의 이름을 입력해주세요.', 'key': 'defendant_name'},
    {'label': '사건 일자', 'placeholder':'강제추행을 당한 날짜를 입력해주세요.', 'key': 'incident_date'},
    {'label': '사건 장소', 'placeholder':'강제추행을 당한 장소를 입력해주세요.', 'key': 'incident_location'},
    {'label': '가해자와의 관계', 'placeholder':'강제추행을 저지른 상대방과 본인의 관계를 입력해주세요.', 'key': 'relationship2'},
    {'label': '피해 사실', 'placeholder':'상대방의 행위로 인해서 입은 피해에 대해 입력해주세요.', 'key': 'facts'},
    {'label': '고소 날짜', 'placeholder':'고소를 신청할 날짜를 입력해주세요.', 'key': 'report_date'},
    {'label': '관할 경찰서', 'placeholder':'고소를 신청할 관할 경찰서 명을 입력해주세요.', 'key': 'police_station'},
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
