const express = require('express');
// const OpenAI = require('openai');

const router = express.Router();
// const openai = new OpenAI({ apiKey: process.env.OPENAI_API_KEY });

// 고소장 생성 함수
function generateComplaint(category, userDetails) {
  const templates = {
    "중고거래 사기": `
고소장

고소인
성명: ${userDetails.complainant_name}
주민등록번호: ${userDetails.complainant_id}
주소: ${userDetails.complainant_address}
전화번호: ${userDetails.complainant_phone}

피고소인
성명(닉네임): ${userDetails.defendant_name}
전화번호: ${userDetails.defendant_phone}

고소취지

위 사건에 관하여 본 고소인은 아래와 같은 이유로 피고소인을 형법 제347조 제1항의 사기죄로 고소하오니, 수사하여 엄히 처벌하여 주시기 바랍니다.

법적사실

피고소인은 ${userDetails.transaction_date} 경 중고거래 사이트인 ${userDetails.site_name}에서, ${userDetails.transaction_item}(이하 '본 중고거래 대상물')를 판매한다는 글을 보고 연락해온 고소인에게 정상적인 본 중고거래 대상물을 판매하겠다고 아래와 같이 거짓말을 하였습니다.

사실 피고소인은 정상적으로 작동되는 물건이 없거나 아예 물건이 없어서 돈을 받더라도 정상적인 본 중고거래 대상물을 교부할 의사나 능력이 없었습니다.

고소이유

1. 상기 본인은 피고소인과 ${userDetails.transaction_date} 경 ${userDetails.site_name} 사이트의 판매글을 보고 알게 되어 사이트 내부 메신저를 통해 연락을 주고 받았습니다.

2. 피고소인은 중고물로서 정상적으로 작동 또는 사용할 수 있는 물건이 없거나 아예 물건이 없어서 본 중고거래 대상물을 판매할 의사나 능력이 없음에도, 마치 본 중고거래 대상물을 정상적으로 사용할 수 있는 것처럼 계시글을 올리고 고소인에게 본 중고거래 대상물을 판매할 것처럼 거짓말을 하였습니다.

3. 고소인은 본 중고거래 대상물을 피고소인으로부터 구매하기로 약속하고 피고소인의 계좌(-)로 현금 ${userDetails.amount}을 입금하였으나 피고소인으로부터 정상적인 물건을 받지 못했습니다.

4. 피고소인은 위와 같이 고소인을 기망하여 이에 속은 고소인으로부터 본 중고거래 대상물의 판매 대금 명목으로 피해금 ${userDetails.amount} 받아 위 피해금 상당을 편취하였습니다.

4. 따라서 피고소인의 위와 같은 행위는 형법 제347조 제1항에 정한 사기죄의 구성요건을 모두 갖추고 있습니다.

결론

위와 같은 피고소인의 행위는 형법 제347조 제1항에 정한 사기죄에 해당하고, 이로 인한 고소인의 재산적/정신적 피해가 극심하므로, 피고소인을 수사하여 엄벌에 처해주시기 바랍니다.

[별첨] - 증거자료
1. 위 사건 판매 게시글 캡쳐본 등

${userDetails.report_date}

위 고소인
${userDetails.complainant_name} (서명 또는 인)

${userDetails.police_station} 귀중
    `,

    "온라인 욕설": `
고소장

고소인
성명: ${userDetails.complainant_name}
주민등록번호: ${userDetails.complainant_id}
ID (닉네임): ${userDetails.complainant_nickname}
전화번호: ${userDetails.complainant_phone}
주소: ${userDetails.complainant_address}

피고소인
ID (닉네임): ${userDetails.defendant_nickname}

고소취지

위 사건에 관하여 본 고소인은 아래와 같은 이유로 피고소인을 형법 제311조의 모욕죄로 고소하오니, 수사하여 엄히 처벌하여 주시기 바랍니다.

법적사실

1. 고소인과 피고소인은 사건이 발생한 ${userDetails.incident_date} 경, 인터넷 커뮤니티 사이트 ${userDetails.website}의 이용자들입니다.

2. 당시 피고소인은 디시의 불특정 이용자들이 접속할 수 있는 위 인터넷 커뮤니티 사이트에서 고소인에게 "${userDetails.offensive_comment}"라고 하며 고소인을 공연히 모욕하였습니다.

3. 이에 고소인은 피고소인의 위와 같은 모욕 행위가 형법 제311조에 정한 모욕죄의 구성요건(공연성, 모욕성, 특정성)을 모두 갖추고 있고 이로 인해 고소인은 막대한 피해를 입었는바, 그 구체적인 이유는 아래와 같습니다.

고소이유

1. 공연성에 관하여
가. 모욕죄의 구성요건인 공연성에 대한 대법원 판례 역시 "공연성은 불특정 다수 또는 다수인이 인식할 수 있는 상태를 의미하므로 비록 개별적으로 한 사람에게 사실을 유포하였다 하더라도 그로부터 불특정 또는 다수인에게 전파될 가능성이 있다면 공연성의 요건을 충족한다."는 입장을 취하고 있습니다(대법원 1985. 4. 23. 선고 85도431판결, 대법원 1990. 7. 24. 선고 90도1167판결 등 참조).

나. 본 사건이 발생한 오후 6시 30분경 당시 해당 사이트는 고소인과 피고소인을 포함한 불특정 다수의 이용자들에게 공개되어 있었으며, 피고소인은 그들이 지켜보는 가운데 "${userDetails.offensive_comment}"라는 언행으로써 공연히 고소인에 대한 모욕을 입혔고, 당시 다른 이용자들은 고소인과 같은 서비스를 이용하는 관계에 불과할 뿐 고소인에 대한 소문을 비밀로 지켜줄만한 특별한 신분관계는 없었던 만큼, 피고소인의 모욕행위는 명백히 불특정 다수에게 전파될 가능성을 내포하고 있다할 것이므로 공연성 요건 역시 충족하고 있습니다.

2. 모욕성에 관하여
가. 대법원은 "형법 제311조의 모욕죄는 사람의 가치에 대한 사회적 평가를 의미하는 외부적 명예를 보호법익으로 하는 법죄로서 모욕죄에서 말하는 모욕이란, 사실을 적시하지 아니하고 사람의 사회적 평가를 저하시킬 추상적인 판단이나 경멸적 감정을 표현하는 것을 의미한다."고 판시하고 있습니다(대법원 2003. 11. 28 선고 2003도397 판결 참조).

나. 본 사건에서 피고소인의 "${userDetails.offensive_comment}"라는 언행은 표현이 다소 무례한 방법으로 표시된 것을 넘어 고소인의 사회적 평가를 저하시킬 만한 경멸적인 감정을 표현하였으며, 감정이 격해서 우발적·일회적으로 행한 행동이 아니고 의도적으로 고소인을 비방하기 위하여 수차에 걸쳐 지속적으로 고소인에게 모욕적인 발언을 일삼은 바 이는 모욕죄의 구성요건인 모욕성을 충족하고 있습니다.

3. 특정성에 대하여
가. "명예훼손죄와 모욕죄의 보호법익은 사람의 가치에 대한 사회적 평가인 이른바 외부적 명예인 점에서 차이가 없고, 명예의 주체인 사람은 특정한 자임을 요하지만 반드시 사람의 성명을 명시하여 허위의 사실을 적시하여야만 하는 것은 아니므로 사람의 성명을 명시한 바 없는 허위사실의 적시행위도 그 표현의 내용을 주위사정과 종합 판단하여 그것이 어느 특정인을 지목하는 것인가를 알아낼 수 있는 경우에는 그 특정인에 대한 명예훼손죄를 구성한다."는 것이 대법원의 일관된 입장입니다(대법원 2002. 5. 10. 선고 2000다50213판결 참조).

나. 이에 비추어 피고소인의 행위가 모욕죄의 구성요건인 특정성을 충족하는지 여부를 판단해보면, 사건 당시 고소인의 인적사항이 컴퓨터를 통해 공개되어 당시 사건을 목격한 다른 이용자들이 고소인의 닉네임(ID)을 통하여 고소인을 현실에서 특정하여 인식할 수 있는 충분한 가능성이 있었던 상태였음이 인정되므로, 피고소인의 모욕행위는 특정성 또한 충족하고 있습니다.

4. 고소인의 피해내용
가. 고소인은 피고소인에게 모욕행위를 중단해달라고 수차례 제지하였으나, 피고소인은 아랑곳하지 않고 모욕적인 언동을 그치지 않았습니다. 이로 인해 고소인은 심한 모욕감과 수치심을 느꼈고, 당시 상황이 수시로 떠올라 심각한 정신적 스트레스 및 육체적 고통을 겪고 있는 상황입니다. 이와 같이 피고소인은 모욕적인 언동으로 형법 제311조를 위반하여 1년 이하의 징역이나 금고 또는 200만원 이하의 벌금에 처할 수 있는 엄한 죄를 저질렀으므로 처벌법규를 위해 피고소인을 엄히 처벌해 주시길 바랍니다.

결론

피고소인의 모욕행위는 형법 제311조에 정한 모욕죄의 구성요건을 모두 구비하고 있어 형법상 모욕죄를 범하였고, 이로 인해 고소인은 정상적인 생활이 어려울 정도로 막대한 피해를 입고 있으므로 피고소인을 철저하게 수사하여 엄벌해 주시기 바랍니다.

${userDetails.report_date}

위 고소인
${userDetails.complainant_name} (서명 또는 인)

${userDetails.police_station} 귀중
    `,

    "성희롱": `
고소장

고소인
성명: ${userDetails.complainant_name}
주민등록번호: ${userDetails.complainant_id}
주소: ${userDetails.complainant_address}
전화번호: ${userDetails.complainant_phone}

피고소인
성명: ${userDetails.defendant_name}
주소: ${userDetails.defendant_address}
전화번호: ${userDetails.defendant_phone}

고소취지

위 사건에 관하여 본 고소인은 아래와 같은 이유로 피고소인을 형법 제311조의 모욕죄로 고소하오니, 수사하여 엄히 처벌하여 주시기 바랍니다.

법적사실

1. 고소인과 피고소인은 ${userDetails.relationship1} 관계로서, 고소인과 피고소인은 사건이 발생한 ${userDetails.incident_date} ${userDetails.incident_location}에서 함께 있었습니다.

2. 당시 피고소인은 고소인에게 "${userDetails.offensive_comment}"라고 하며, 고소인을 공연히 희롱하였는데, 이는 당시 서울 여의도 소재 IFC몰 식당가에 있던 ${userDetails.people}의 사람이 함께 있었습니다.

3. 고소인은 피고소인의 이러한 행위를 수차례 제지하였으나 피고소인은 모욕적인 언동을 그치지 않았습니다. 이러한 피고소인의 계속된 모욕 행위로 고소인은 심한 모욕감을 느꼈습니다.

4. 이에 고소인은 피고소인의 위와 같은 모욕 행위가 형법 제311조에 정한 모욕죄의 구성요건(공연성, 모욕성, 특정성)을 모두 갖추고 있어 피고소인을 엄벌에 처해야한다고 주장하는 바 구체적인 이유는 아래와 같습니다.

고소이유

1. 공연성에 관하여
모욕죄의 구성요건인 공연성에 대한 대법원 판례 역시 "공연성은 불특정 다수 또는 다수인이 인식할 수 있는 상태를 의미하므로 비록 개별적으로 한 사람에게 사실을 유포하였다 하더라도 그로부터 불특정 또는 다수인에게 전파될 가능성이 있다면 공연성의 요건을 충족한다."는 입장을 취하고 있습니다(대법원 1985. 4. 23. 선고 85도431판결, 대법원 1990. 7. 24. 선고 90도1167판결 등 참조).

본 사건이 발생한 ${userDetails.incident_date} 당시 ${userDetails.incident_location} 에는 고소인과 피고소인을 제외한 ${userDetails.people}의 사람이 있었으며, 피고소인은 이들이 지켜보는 가운데 "${userDetails.offensive_comment}" 라는 언행으로써 공연히 고소인에 대한 모욕을 입혔습니다. 또한 당시 주변인들은 고소인에 대한 소문을 비밀로 지켜줄만한 특별한 신분관계 또는 친분관계가 없었던 만큼, 피고소인의 모욕행위는 명백히 불특정 다수에게 전파될 가능성을 내포하고 있다할 것이므로 공연성 요건을 충족하고 있습니다.

2. 모욕성에 관하여
대법원은 "형법 제311조의 모욕죄는 사람의 가치에 대한 사회적 평가를 의미하는 외부적 명예를 보호법익으로 하는 범죄로서 모욕죄에서 말하는 모욕이란, 사실을 적시하지 아니하고 사람의 사회적 평가를 저하시킬 추상적인 판단이나 경멸적 감정을 표현하는 것을 의미한다."고 판시하고 있습니다(대법원 2003. 11. 28 선고 2003도397 판결 참조).

본 사건에서 피고소인의 "${userDetails.offensive_comment}" 라는 언행은 표현이 다소 무례한 방법으로 표시된 것을 넘어 고소인의 사회적 평가를 저하시킬 만한 경멸적인 감정을 표현하였으며, 감정이 격해서 우발적·일회적으로 행한 행동이 아니라 고의로 고소인을 비방하기 위하여 수차에 걸쳐 지속적으로 고소인에게 모욕적인 발언을 일삼은 바, 이는 모욕죄의 구성요건인 모욕성을 충족하고 있습니다.

3. 특정성에 대하여
형법 제311조는 공연히 사람을 모욕한 자를 처벌하도록 하는 법률조항으로서, 이는 불특정 또는 다수인이 인식할 수 있는 상태 하에서의 모욕 표현을 제한하고자 하는 취지를 담고 있습니다.

사건 당시 피고소인은 고소인을 직접 대면한 상황에서 지속적으로 위와 같은 모욕을 행한 바에 비추어 피고소인의 행위가 모욕죄의 구성요건인 특정성을 충족하는지 여부를 판단해보면, 이 사건 모욕의 대상이 고소인으로 특정됨이 너무나 인정될 것입니다.

결론

위와 같이 피고소인의 모욕행위는 형법 제311조에 정한 모욕죄의 구성요건을 모두 구비하고 있으므로, 피고소인을 수사하여 엄벌에 처해주시기 바랍니다.

증거자료(추후 추가될 예정)


${userDetails.report_date}

위 고소인
${userDetails.complainant_name} (서명 또는 인)

${userDetails.police_station} 귀중
    `,

    "강제추행": `
고소장

고소인
성명: ${userDetails.complainant_name}
주민등록번호: ${userDetails.complainant_id}
주소: ${userDetails.complainant_address}
전화번호: ${userDetails.complainant_phone}

피고소인
성명: ${userDetails.defendant_name}

고소취지

위 사건에 관하여 본 고소인은 아래와 같은 이유로 피고소인을 형법 제298조의 강제추행죄로 고소하오니, 수사하여 엄히 처벌하여 주시기 바랍니다.

법적사실 및 고소이유

1. 고소인과 피고소인은 ${userDetails.relationship2} 관계로서, ${userDetails.incident_date} ${userDetails.incident_location}에 있었습니다.

2. 당시 피고소인은 고소인에게 "${userDetails.facts}"라는 행위를 하였습니다.

3. 고소인은 피고소인의 이러한 행위를 수차례 제지하였으나 피고소인은 추행을 멈추지 않았습니다. 이러한 피고소인의 계속된 추행 행위로 고소인은 극심한 정적 수치심을 느꼈고, 이로 인하여 심각한 신체적/정신적 스트레스를 겪고 있습니다.

4. 따라서 피고소인의 위와 같은 강제추행 행위는 형법 제298조에 정한 강제추행죄의 구성요건을 모두 갖추고 있습니다.

결론

위와 같은 피고소인의 행위는 형법 제298조에 정한 강제추행죄에 해당하고, 이로 인한 고소인의 신체적/정신적 피해가 극심하므로, 피고소인을 수사하여 엄벌에 처해주시기 바랍니다.

[별첨] - 증거자료
1. 증제1호 - 사건이 촬영된 CCTV 파일

${userDetails.report_date}

위 고소인
${userDetails.complainant_name} (서명 또는 인)

${userDetails.police_station} 귀중
    `
  };

  return templates[category] || "유효하지 않은 카테고리입니다.";
}

module.exports = { generateComplaint };
