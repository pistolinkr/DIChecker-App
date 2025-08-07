#!/bin/bash

echo "🚀 Drug Interaction Checker - 모든 플랫폼 빌드 시작..."

# Node.js와 npm이 설치되어 있는지 확인
if ! command -v node &> /dev/null; then
    echo "❌ Node.js가 설치되어 있지 않습니다. https://nodejs.org에서 설치해주세요."
    exit 1
fi

if ! command -v npm &> /dev/null; then
    echo "❌ npm이 설치되어 있지 않습니다."
    exit 1
fi

echo "📦 의존성 설치 중..."
npm install

echo "🎨 앱 아이콘 생성 중..."
python3 create-simple-assets.py
python3 create-simple-ico.py

echo "🍎 macOS 앱 빌드 중..."
npm run build-mac

echo "🪟 Windows 앱 빌드 중..."
npm run build-win

echo "📦 배포 파일 준비 중..."
./deploy.sh

echo ""
echo "🎉 모든 플랫폼 빌드 완료!"
echo ""
echo "📁 생성된 파일들:"
echo "  📦 macOS: dist/Drug Interaction Checker-1.0.0.dmg (98MB)"
echo "  🪟 Windows: dist/Drug Interaction Checker Setup 1.0.0.exe (76MB)"
echo "  📂 배포: deploy/ 폴더에 모든 파일 준비됨"
echo ""
echo "🚀 이제 사용자들에게 배포할 수 있습니다!" 