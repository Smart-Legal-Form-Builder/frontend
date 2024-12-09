import '../utils/form_questions.dart';

final Map<String, List<Map<String, String>>> categoryFields = {
  '중고거래 사기': [
    {'label': '피해자 이름', 'placeholder':'피해자 본인의 이름을 입력해주세요.', 'key': 'complainant_name', 'category': '피해자 정보'},
    {'label': '주민등록번호', 'placeholder':'피해자 본인의 주민등록번호 13자리를 입력해주세요.', 'key': 'complainant_id', 'category': '피해자 정보'},
    {'label': '주소', 'placeholder':'피해자 본인의 소재지를 입력해주세요.', 'key': 'complainant_address', 'category': '피해자 정보'},
    {'label': '전화번호', 'placeholder':'피해자 본인의 전화번호를 입력해주세요.', 'key': 'complainant_phone', 'category': '피해자 정보'},
    {'label': '거래 물품', 'placeholder':'사기를 당한 거래 물품을 입력해주세요.', 'key': 'transaction_item', 'category': '사건 내용'},
    {'label': '거래 일자', 'placeholder':'사기를 당한 거래의 일자를 입력해주세요.', 'key': 'transaction_date', 'category': '사건 내용'},
    {'label': '사이트명', 'placeholder':'사기를 당한 거래를 진행한 사이트의 명칭을 입력해주세요.', 'key': 'site_name', 'category': '사건 내용'},
    {'label': '피해 금액', 'placeholder':'사기의 피해 금액을 입력해주세요.', 'key': 'amount', 'category': '사건 내용'},
    {'label': '상대방 이름', 'placeholder':'사기 행위를 저지른 상대방의 이름을 입력해주세요.', 'key': 'defendant_name', 'category': '상대방 정보'},
    {'label': '상대방 전화번호', 'placeholder':'사기 행위를 저지른 상대방의 전화번호를 입력해주세요.', 'key': 'defendant_phone', 'category': '상대방 정보'},
    {'label': '고소 날짜', 'placeholder':'고소를 신청할 날짜를 입력해주세요.', 'key': 'report_date', 'category': '고소 정보'},
    {'label': '관할 경찰서', 'placeholder':'고소를 신청할 관할 경찰서 명을 입력해주세요.', 'key': 'police_station', 'category': '고소 정보'},
  ],
  '온라인 욕설': [
    {'label': '피해자 이름', 'placeholder':'피해자 본인의 이름을 입력해주세요.', 'key': 'complainant_name', 'category': '피해자 정보'},
    {'label': '주민등록번호', 'placeholder':'피해자 본인의 주민등록번호 13자리를 입력해주세요.', 'key': 'complainant_id', 'category': '피해자 정보'},
    {'label': '닉네임', 'placeholder':'피해자 본인의 온라인 닉네임을 입력해주세요.', 'key': 'complainant_nickname', 'category': '피해자 정보'},
    {'label': '전화번호', 'placeholder':'피해자 본인의 전화번호를 입력해주세요.', 'key': 'complainant_phone', 'category': '피해자 정보'},
    {'label': '주소', 'placeholder':'피해자 본인의 소재지를 입력해주세요.', 'key': 'complainant_address', 'category': '피해자 정보'},
    {'label': '가해자 닉네임', 'placeholder':'욕설을 한 상대방의 온라인 닉네임을 입력해주세요.', 'key': 'defendant_nickname', 'category': '상대방 정보'},
    {'label': '사건 일자', 'placeholder':'욕설을 당한 날짜를 입력해주세요.', 'key': 'incident_date', 'category': '사건 내용'},
    {'label': '웹사이트', 'placeholder':'욕설을 당한 온라인 웹사이트의 이름을 입력해주세요.', 'key': 'website', 'category': '사건 내용'},
    {'label': '욕설 내용', 'placeholder':'상대방이 한 욕설의 내용을 입력해주세요.', 'key': 'offensive_comment', 'category': '사건 내용'},
    {'label': '고소 날짜', 'placeholder':'고소를 신청할 날짜를 입력해주세요.', 'key': 'report_date', 'category': '고소 정보'},
    {'label': '관할 경찰서', 'placeholder':'고소를 신청할 관할 경찰서 명을 입력해주세요.', 'key': 'police_station', 'category': '고소 정보'},
  ],
  '성희롱': [
    {'label': '피해자 이름', 'placeholder':'피해자 본인의 이름을 입력해주세요.', 'key': 'complainant_name', 'category': '피해자 정보'},
    {'label': '주민등록번호', 'placeholder':'피해자 본인의 주민등록번호 13자리를 입력해주세요.', 'key': 'complainant_id', 'category': '피해자 정보'},
    {'label': '주소', 'placeholder':'피해자 본인의 소재지를 입력해주세요.', 'key': 'complainant_address', 'category': '피해자 정보'},
    {'label': '전화번호', 'placeholder':'피해자 본인의 전화번호를 입력해주세요.', 'key': 'complainant_phone', 'category': '피해자 정보'},
    {'label': '가해자와의 관계', 'placeholder':'성희롱을 저지른 상대방과 본인의 관계를 입력해주세요.', 'key': 'relationship1', 'category': '상대방 정보'},
    {'label': '가해자 이름', 'placeholder':'성희롱을 저지른 상대방의 이름을 입력해주세요.', 'key': 'defendant_name', 'category': '상대방 정보'},
    {'label': '가해자 주소', 'placeholder':'성희롱을 저지른 상대방의 소재지를 입력해주세요.', 'key': 'defendant_address', 'category': '상대방 정보'},
    {'label': '가해자 전화번호', 'placeholder':'성희롱을 저지른 상대방의 전화번호를 입력해주세요.', 'key': 'defendant_phone', 'category': '상대방 정보'},
    {'label': '사건 일자', 'placeholder':'성희롱을 당한 날짜를 입력해주세요.', 'key': 'incident_date', 'category': '사건 내용'},
    {'label': '사건 장소', 'placeholder':'성희롱을 당한 장소를 입력해주세요.', 'key': 'incident_location', 'category': '사건 내용'},
    {'label': '사건 당시 같이 있던 사람들의 수', 'placeholder':'성희롱을 당할 때 같이 있었던 사람의 수를 입력해주세요.', 'key': 'people', 'category': '사건 내용'},
    {'label': '문제 발언', 'placeholder':'상대방의 성희롱 발언을 입력해주세요.', 'key': 'offensive_comment', 'category': '사건 내용'},
    {'label': '고소 날짜', 'placeholder':'고소를 신청할 날짜를 입력해주세요.', 'key': 'report_date', 'category': '고소 정보'},
    {'label': '관할 경찰서', 'placeholder':'고소를 신청할 관할 경찰서 명을 입력해주세요.', 'key': 'police_station', 'category': '고소 정보'},
  ],
  '강제추행': [
    {'label': '피해자 이름', 'placeholder':'피해자 본인의 이름을 입력해주세요.', 'key': 'complainant_name'},
    {'label': '주민등록번호', 'placeholder':'피해자 본인의 주민등록번호 13자리를 입력해주세요.', 'key': 'complainant_id'},
    {'label': '주소', 'placeholder':'피해자 본인의 소재지를 입력해주세요.', 'key': 'complainant_address'},
    {'label': '전화번호', 'placeholder':'피해자 본인의 전화번호를 입력해주세요.', 'key': 'complainant_phone'},
    {'label': '가해자 이름', 'placeholder':'강제추행을 저지른 상대방의 이름을 입력해주세요.', 'key': 'defendant_name', 'category': '상대방 정보'},
    {'label': '가해자와의 관계', 'placeholder':'강제추행을 저지른 상대방과 본인의 관계를 입력해주세요.', 'key': 'relationship2', 'category': '상대방 정보'},
    {'label': '사건 일자', 'placeholder':'강제추행을 당한 날짜를 입력해주세요.', 'key': 'incident_date', 'category': '사건 내용'},
    {'label': '사건 장소', 'placeholder':'강제추행을 당한 장소를 입력해주세요.', 'key': 'incident_location', 'category': '사건 내용'},
    {'label': '피해 사실', 'placeholder':'상대방의 행위로 인해서 입은 피해에 대해 입력해주세요.', 'key': 'facts', 'category': '사건 내용'},
    {'label': '고소 날짜', 'placeholder':'고소를 신청할 날짜를 입력해주세요.', 'key': 'report_date', 'category': '고소 정보'},
    {'label': '관할 경찰서', 'placeholder':'고소를 신청할 관할 경찰서 명을 입력해주세요.', 'key': 'police_station', 'category': '고소 정보'},
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
