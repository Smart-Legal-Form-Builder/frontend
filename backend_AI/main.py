from flask import Flask, request, jsonify
from dotenv import load_dotenv
import json
from pathlib import Path
import os
from langchain_community.vectorstores import FAISS
from langchain_core.output_parsers import StrOutputParser
from langchain_core.runnables import RunnablePassthrough
from langchain_core.prompts import PromptTemplate
from langchain_openai import ChatOpenAI, OpenAIEmbeddings
from langchain.chains import RetrievalQA
from flask_cors import CORS

# Flask 앱 생성
app = Flask(__name__)
CORS(app) 

# 환경변수 로드
load_dotenv(override=True)
embeddings = OpenAIEmbeddings()

# 디렉터리 내 모든 JSON 파일 불러오기
def load_all_json_files(directory_path):
    all_cases = []  # 모든 판례 데이터를 저장할 리스트

    # 디렉터리의 모든 하위 폴더 및 파일 탐색
    for root, _, files in os.walk(directory_path):
        for file in files:
            if file.endswith('.json'):  # JSON 파일만 선택
                file_path = os.path.join(root, file)
                with open(file_path, 'r', encoding='utf-8') as f:
                    try:
                        data = json.load(f)
                        all_cases.extend(data)  # 파일의 데이터를 리스트에 추가
                    except json.JSONDecodeError as e:
                        print(f"JSON 디코딩 실패: {file_path}, 오류: {e}")

    return all_cases

# RAG 시스템 구축 (vector_store와 retriever를 처리하도록 수정)
def build_rag_system(directory_path):
    # JSON 파일을 로드하고 텍스트와 메타데이터를 준비
    cases = load_all_json_files(directory_path)
    texts = [case["text"] for case in cases]
    metadata = [{"category": case["category"], "settlement": case["settlement"], "sentence": case["sentence"]} for case in cases]

    # FAISS 벡터 저장소 생성
    vector_store = FAISS.from_texts(texts, embeddings, metadatas=metadata)

    # 검색기(Retriever) 설정
    retriever = vector_store.as_retriever(search_kwargs={"k": 3})  # k=3: 유사한 결과를 3개 가져옵니다.

    # 프롬프트 템플릿 설정
    template = """당신은 고소 사건을 전문으로 한 변호사입니다.
    주어진 문서 내용을 바탕으로 향후 사용자가 하면 좋을 행동과 사건에 대한 간단한 법률 조언을 해주세요.
    문서에 없는 내용이면 "판례를 찾을 수 없습니다."라고 답변해주세요.
    
    문서 내용:
    {context}
    
    질문:
    {question}
    
    답변:"""
    prompt = PromptTemplate.from_template(template)

    # LLM 설정 (gpt-4 모델을 사용)
    llm = ChatOpenAI(
        temperature=0,  # 응답의 창의성 수준 (0: 일관된 응답)
        model_name="gpt-4"  # 사용할 모델
    )

    # RAG 체인 구성
    chain = RetrievalQA.from_chain_type(
        llm=llm, 
        chain_type="stuff",  # 텍스트를 모두 읽고 응답 생성
        retriever=retriever,
        return_source_documents=True  # 반환되는 문서도 포함
    )
    
    return chain

# RAG 시스템을 한 번만 초기화
directory_path = "./RAG_dataset" 
chain = build_rag_system(directory_path)

# 사용자 질문을 처리하는 엔드포인트
@app.route('/ask', methods=['POST'])
def ask_question():
    try:
        # 요청 본문에서 데이터 가져오기
        request_data = request.get_json()
        
        # 쿼리 데이터 추출
        query = request_data.get('query')
        
        if not query:
            return jsonify({"error": "Query parameter is required"}), 400
        
        # 질의 실행
        result = chain({"query": query})

        # 결과 준비
        response = {
            "result": result["result"],
            "source_documents": [
                {
                    "category": doc.metadata["category"],
                    "content": doc.page_content,
                    "settlement": doc.metadata["settlement"],
                    "sentence": doc.metadata["sentence"]
                }
                for doc in result["source_documents"]
            ]
        }
        settlement_values = [doc["settlement"] for doc in response['source_documents']]
        sentence_values = [doc["sentence"] for doc in response['source_documents']]

        ## 넘겨줄 변수
        # ai 변호사의 말
        lawyer = response['result']

        # 평균 계산
        average_settlement = int(round(sum(settlement_values) / len(settlement_values), -4))
        average_sentence = int(round(sum(sentence_values) / len(sentence_values)))

        # 각각의 유사 판례
        source1 = response['source_documents'][0]
        source2 = response['source_documents'][1]
        source3 = response['source_documents'][2]

        # 결과 출력
        print(f"AI 변호사의 팁: {lawyer}")
        print(f"평균 합의금: {average_settlement} 원")
        print(f"평균 징역: {average_sentence} 개월")
        print(f"판례1: {source1}")
        print(f"판례2: {source2}")
        print(f"판례3: {source3}")

        result = {
            "AI_변호사_팁": lawyer,
            "평균_합의금": average_settlement,
            "평균_징역": average_sentence,
            "판례들": [
                {"category": source1['category'], "content": source1['content'], "settlement": source1['settlement'], "sentence": source1['sentence']},
                {"category": source2['category'], "content": source2['content'], "settlement": source2['settlement'], "sentence": source2['sentence']},
                {"category": source3['category'], "content": source3['content'], "settlement": source3['settlement'], "sentence": source3['sentence']}
            ]
        }
    
        return jsonify(result)
    
    except Exception as e:
        # 예외 처리
        return jsonify({"error": f"Error while processing the query: {str(e)}"}), 500

# 서버 실행 (로컬 환경에서 테스트 시 사용)
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000) 
