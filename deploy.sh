#!/bin/bash

echo "🚀 Drug Interaction Checker 배포 준비 중..."

# 버전 정보
VERSION="1.0.0"
APP_NAME="Drug Interaction Checker"

# 배포 폴더 생성
DEPLOY_DIR="deploy"
mkdir -p $DEPLOY_DIR

echo "📦 배포 파일 준비 중..."

# DMG 파일 복사
if [ -f "dist/$APP_NAME-$VERSION.dmg" ]; then
    cp "dist/$APP_NAME-$VERSION.dmg" "$DEPLOY_DIR/"
    echo "✅ DMG 파일 복사 완료"
else
    echo "⚠️ DMG 파일을 찾을 수 없습니다."
fi

# EXE 파일 복사
if [ -f "dist/$APP_NAME Setup $VERSION.exe" ]; then
    cp "dist/$APP_NAME Setup $VERSION.exe" "$DEPLOY_DIR/"
    echo "✅ EXE 파일 복사 완료"
else
    echo "⚠️ EXE 파일을 찾을 수 없습니다."
fi

# 설치 가이드 복사
if [ -f "DMG_INSTALL_GUIDE.md" ]; then
    cp "DMG_INSTALL_GUIDE.md" "$DEPLOY_DIR/"
    echo "✅ macOS 설치 가이드 복사 완료"
fi

if [ -f "WINDOWS_INSTALL_GUIDE.md" ]; then
    cp "WINDOWS_INSTALL_GUIDE.md" "$DEPLOY_DIR/"
    echo "✅ Windows 설치 가이드 복사 완료"
fi

# README 복사
if [ -f "README.md" ]; then
    cp "README.md" "$DEPLOY_DIR/"
    echo "✅ README 복사 완료"
fi

# 배포 정보 파일 생성
cat > "$DEPLOY_DIR/RELEASE_NOTES.md" << EOF
# Drug Interaction Checker v$VERSION

## 🎉 새로운 버전이 출시되었습니다!

### 📦 다운로드
- **macOS DMG 파일**: \`$APP_NAME-$VERSION.dmg\` (약 98MB)
- **Windows EXE 파일**: \`$APP_NAME Setup $VERSION.exe\` (약 76MB)
- **지원 아키텍처**: macOS (Intel x64, Apple Silicon arm64), Windows (x64)

### ✨ 주요 기능
- 💊 FDA 데이터베이스 기반 약물 상호작용 검사
- 🤖 AI 분석 (OpenAI, Claude, Perplexity, Gemini)
- 🔍 실시간 검색 (타이포 허용, 퍼지 매칭)
- 🌐 한국어/영어 지원
- 💻 네이티브 macOS 앱

### 🛠️ 설치 방법
**macOS:**
1. \`DMG_INSTALL_GUIDE.md\` 파일을 참조하세요
2. DMG 파일을 다운로드하고 더블클릭
3. Applications 폴더로 드래그 앤 드롭

**Windows:**
1. \`WINDOWS_INSTALL_GUIDE.md\` 파일을 참조하세요
2. EXE 파일을 다운로드하고 더블클릭
3. 설치 마법사를 따라 진행

### 🔧 시스템 요구사항
**macOS:**
- macOS 10.12 (Sierra) 이상
- Intel (x64) 또는 Apple Silicon (arm64)
- 최소 4GB RAM
- 최소 200MB 여유 저장공간

**Windows:**
- Windows 10 (버전 1903) 이상
- 64비트 (x64)
- 최소 4GB RAM
- 최소 200MB 여유 저장공간

### 📝 변경사항
- 초기 릴리즈
- Electron 기반 네이티브 앱 (macOS + Windows)
- 웹 버전의 모든 기능 포함
- 크로스 플랫폼 지원

### 🔒 보안
- 로컬 실행으로 개인정보 보호
- 선택적 AI API 연결
- 코드 서명 없음 (개발자 모드 필요)

---
**📅 릴리즈 날짜**: $(date '+%Y년 %m월 %d일')
**🔗 GitHub**: https://github.com/yourusername/drug-interaction-checker
EOF

echo "✅ 배포 정보 파일 생성 완료"

# 배포 폴더 내용 확인
echo ""
echo "📁 배포 폴더 내용:"
ls -la $DEPLOY_DIR/

echo ""
echo "🎉 배포 준비 완료!"
echo "📂 배포 파일들이 '$DEPLOY_DIR' 폴더에 준비되었습니다."
echo ""
echo "📤 배포 방법:"
echo "1. '$DEPLOY_DIR' 폴더의 내용을 웹사이트나 GitHub Releases에 업로드"
echo "2. 사용자들에게 DMG 파일과 설치 가이드를 공유"
echo "3. RELEASE_NOTES.md의 내용을 릴리즈 노트로 사용" 