#!/bin/bash

echo "🚀 Drug Interaction Checker DMG 빌드 시작..."

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

echo "🔨 Electron 앱 빌드 중..."
npm run build-mac
echo "📦 DMG 파일 생성 중..."
npm run build-dmg

echo "✅ 빌드 완료!"
echo "📁 DMG 파일은 dist 폴더에 생성되었습니다."
echo "🎉 이제 사용자들이 DMG 파일을 다운로드해서 설치할 수 있습니다!" 