const express = require('express');
const cors = require('cors');
const dotenv = require('dotenv');
const PDFDocument = require('pdfkit');
const fs = require('fs');
const path = require('path');
const { generateComplaint } = require('./routes/complaint');

dotenv.config();

const app = express();
app.use(cors());
app.use(express.json());

// PDF 저장 디렉토리 설정
const pdfDir = path.join(__dirname, 'pdfs');
if (!fs.existsSync(pdfDir)) {
  fs.mkdirSync(pdfDir, { recursive: true });
}

// PDF 생성 API
app.post('/api/generate-complaint', (req, res) => {
  const { category, userDetails } = req.body;

  if (!category || !userDetails) {
    console.log('Category or userDetails is missing');
    return res.status(400).json({ error: "Category and userDetails are required" });
  }

  try {
    const complaintText = generateComplaint(category, userDetails);
    console.log('Generated Complaint Text:', complaintText);

    const doc = new PDFDocument();
    const fileName = `complaint_${Date.now()}.pdf`;
    const filePath = path.join(pdfDir, fileName);

    // 폰트 파일 경로 설정 (NanumGothic.otf)
    const fontPath = path.join(__dirname, 'fonts', 'NanumGothic.otf');

    // 폰트 등록 및 적용
    if (fs.existsSync(fontPath)) {
      doc.registerFont('NanumGothic', fontPath);
      doc.font('NanumGothic');
    } else {
      console.error('Font file not found:', fontPath);
      return res.status(500).json({ error: 'Font file not found' });
    }

    const writeStream = fs.createWriteStream(filePath);
    doc.pipe(writeStream);
    doc.fontSize(12).text(complaintText, {
      lineGap: 4, // 줄 간격 설정 (선택 사항)
    });
    doc.end();

    writeStream.on('finish', () => {
      console.log('PDF generated successfully:', filePath);
      res.status(200).json({
        message: 'PDF 생성 성공',
        fileUrl: `http://localhost:${process.env.PORT || 5000}/api/download-pdf/${fileName}`,
      });
    });

    writeStream.on('error', (err) => {
      console.error('Error writing PDF file:', err);
      res.status(500).json({ error: 'PDF 생성 실패' });
    });
  } catch (error) {
    console.error('Error generating PDF:', error);
    res.status(500).json({ error: 'PDF 생성 실패' });
  }
});

// PDF 다운로드 API
app.get('/api/download-pdf/:fileName', (req, res) => {
  const { fileName } = req.params;
  const filePath = path.join(pdfDir, fileName);

  // 파일 존재 여부 확인
  if (fs.existsSync(filePath)) {
    res.download(filePath); // 파일 다운로드
  } else {
    res.status(404).json({ error: '파일을 찾을 수 없습니다.' });
  }
});

// 서버 실행
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});

